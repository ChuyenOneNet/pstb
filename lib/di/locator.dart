import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:pstb/core/services/dropdown_service.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import '../app/modules/electronic_signature_v2/data/remote/e_signature_api.dart';
import '../app/modules/electronic_signature_v2/data/remote/e_signature_role_api.dart';
import '../app/modules/electronic_signature_v2/data/repositories/signature_repository.dart';
import '../app/modules/electronic_signature_v2/data/repositories/signature_repository_impl.dart';
import '../app/modules/electronic_signature_v2/presentation/cubits/departments_cubit/departments_cubit.dart';
import '../core/repositories/booking_repository.dart';
import '../core/repositories/dropdown_repository.dart';
import '../cubits/address_cubit.dart';
import '../cubits/ethnic_cubit.dart';
import '../cubits/job_cubit.dart';
import '../cubits/nationality_cubit.dart';
import '../feature/booking/datasources/local/history_local_ds.dart';
import '../feature/booking/datasources/remote/catalog_service.dart';
import '../feature/booking/datasources/remote/crm_booking_service.dart';
import '../feature/relatives/data/datasources/relative_remote_ds.dart';
import '../feature/relatives/data/repositories/fake_relative_repository.dart';
import '../feature/relatives/data/repositories/relative_repo_impl.dart';
import '../feature/relatives/domain/repositories/relative_repository.dart';
import '../feature/relatives/domain/usecases/add_relative_usecase.dart';
import '../feature/relatives/domain/usecases/delete_relative_usecase.dart';
import '../feature/relatives/domain/usecases/get_relative_detail_usecase.dart';
import '../feature/relatives/domain/usecases/get_relatives_usecase.dart';
import '../feature/relatives/domain/usecases/update_relative_usecase.dart';
import '../feature/relatives/presentation/cubit/relative_form_cubit.dart';
import '../feature/relatives/presentation/cubit/relative_list_cubit.dart';
import '../services/fcm_service.dart';
import '../utils/http_services.dart';
import '../utils/navigation_service.dart';
import '../utils/shared_preferences_manager.dart';

GetIt serviceLocator = GetIt.instance;

Future<void> setupLocator() async {
  //serviceLocator
  serviceLocator.registerLazySingleton(() => NavigationService());
  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(
      () => SharedPreferencesManager(sharedPreferences: sharedPreferences));
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final vduhUrl =
      await prefs.getString("vduhUrl") ?? "https://116.97.240.210:6443";
  final Dio dio = await setupDio(baseUrl: vduhUrl, isHaveToken: true);
  final dbPath = await getDatabasesPath();
  final path = join(dbPath, 'request_history.db');

  serviceLocator.registerLazySingleton(() => JobCubit());
  serviceLocator.registerLazySingleton(() => AddressCubit());
  serviceLocator.registerLazySingleton(() => NationalityCubit());
  serviceLocator.registerLazySingleton(() => EthnicCubit());
  serviceLocator
      .registerLazySingleton<DropdownService>(() => DropdownService(dio));
//

  serviceLocator.registerFactory<DropdownRepository>(
      () => DropdownRepositoryImpl(serviceLocator<DropdownService>()));

  final crmDio = await setupDio(
      baseUrl: "https://crm.phusanthaibinh.vn", isHaveToken: false);
  final catalogDio = await setupDio(
      baseUrl: "https://crm.phusanthaibinh.vn", isHaveToken: false);

  // Services
  serviceLocator.registerLazySingleton<CrmBookingService>(
      () => CrmBookingService(crmDio));
  serviceLocator
      .registerLazySingleton<CatalogService>(() => CatalogService(catalogDio));

  // Local
  serviceLocator.registerLazySingleton<HistoryLocalSqliteDs>(
      () => HistoryLocalSqliteDs());

  // Repository
  serviceLocator
      .registerLazySingleton<BookingRepository>(() => BookingRepositoryImpl(
            bookingService: serviceLocator(),
            catalogService: serviceLocator<CatalogService>(),
            historyLocal: serviceLocator(),
            accessKey: 'TXEjpPNBINpFYD70', // <-- access key CRM
            inputSource: 'APP MOBILE',
          ));
  final Dio dioSign =
      await setupDio(baseUrl: "http://116.97.240.210:5105", isHaveToken: true);
  // --- Ký số (V1) ---
  serviceLocator.registerLazySingleton<ESignatureApi>(
    () => ESignatureApi(dioSign),
  );
  final Dio dioSignRoleByUserNameAndDocument =
      await setupDio(baseUrl: "https://113.160.200.31:6443", isHaveToken: true);
  // --- Ký số (V1) ---
  serviceLocator.registerLazySingleton<ESignatureRoleApi>(
    () => ESignatureRoleApi(dioSignRoleByUserNameAndDocument),
  );
  serviceLocator.registerLazySingleton<SignatureRepository>(
    () => SignatureRepositoryImpl(
      serviceLocator<ESignatureApi>(),
      serviceLocator<ESignatureRoleApi>(),
    ),
  );
  serviceLocator
      .registerLazySingleton<DepartmentsCubit>(() => DepartmentsCubit());

  serviceLocator.registerLazySingleton<RelativeRemoteDataSource>(
    () => RelativeRemoteDataSource(dioSignRoleByUserNameAndDocument
        // thay bằng baseUrl của bạn
        ),
  );

  // serviceLocator.registerLazySingleton<RelativeRepository>(
  //   () => RelativeRepositoryImpl(serviceLocator()),
  // );
  serviceLocator.registerLazySingleton<RelativeRepository>(
    () => FakeRelativeRepository(),
  );
  // Usecases
  serviceLocator
      .registerLazySingleton(() => GetRelativesUseCase(serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => GetRelativeDetailUseCase(serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => AddRelativeUseCase(serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => UpdateRelativeUseCase(serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => DeleteRelativeUseCase(serviceLocator()));

  // Cubits
  serviceLocator.registerFactory(
    () => RelativeListCubit(
      getRelativesUseCase: serviceLocator(),
      deleteRelativeUseCase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => RelativeFormCubit(
      addRelativeUseCase: serviceLocator(),
      updateRelativeUseCase: serviceLocator(),
      getDetailUseCase: serviceLocator(),
    ),
  );

  serviceLocator.registerSingleton<FcmService>(
    FcmService(FirebaseMessaging.instance),
  );
}
