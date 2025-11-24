import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pstb/app/modules/booking_v2/cubit/create_request_cubit.dart';
import 'package:pstb/app/modules/nurse_page/electronic_signature_v2/data/remote/e_signature_role_api.dart';
import 'package:pstb/core/services/dropdown_service.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import '../app/modules/booking_v2/sqlite_dao/request_history_dao.dart';
import '../app/modules/nurse_page/electronic_signature_v2/data/remote/e_signature_api.dart';
import '../app/modules/nurse_page/electronic_signature_v2/data/repositories/signature_repository.dart';
import '../app/modules/nurse_page/electronic_signature_v2/data/repositories/signature_repository_impl.dart';
import '../app/modules/nurse_page/electronic_signature_v2/presentation/cubits/departments_cubit/departments_cubit.dart';
import '../core/repositories/booking_repository.dart';
import '../core/repositories/dropdown_repository.dart';
import '../core/repositories/request_repository.dart';
import '../core/services/booking_service.dart';
import '../cubits/address_cubit.dart';
import '../cubits/ethnic_cubit.dart';
import '../cubits/job_cubit.dart';
import '../cubits/nationality_cubit.dart';
import '../feature/booking/datasources/local/history_local_ds.dart';
import '../feature/booking/datasources/remote/catalog_service.dart';
import '../feature/booking/datasources/remote/crm_booking_service.dart';
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

  final db = await openDatabase(
    path,
    version: 1,
    onCreate: (Database db, int version) async {
      await RequestHistoryDao.createTable(db);
    },
  );
  final requestHistoryDao = RequestHistoryDao(db);
  serviceLocator.registerSingleton<RequestHistoryDao>(requestHistoryDao);
  serviceLocator.registerLazySingleton(() => JobCubit());
  serviceLocator.registerLazySingleton(() => AddressCubit());
  serviceLocator.registerLazySingleton(() => NationalityCubit());
  serviceLocator.registerLazySingleton(() => EthnicCubit());
  serviceLocator
      .registerLazySingleton<DropdownService>(() => DropdownService(dio));
//

  serviceLocator.registerFactory<DropdownRepository>(
      () => DropdownRepositoryImpl(serviceLocator<DropdownService>()));

  serviceLocator.registerLazySingleton(() => CreateRequestCubit());
  serviceLocator
      .registerLazySingleton<BookingService>(() => BookingService(dio));
//

  serviceLocator.registerFactory<RequestRepository>(
    () => RequestRepository(
      serviceLocator<BookingService>(),
      serviceLocator<RequestHistoryDao>(),
    ),
  );

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
}
