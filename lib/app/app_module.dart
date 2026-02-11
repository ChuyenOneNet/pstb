import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pstb/app/app_store.dart';
import 'package:pstb/app/modules/about_page/about_page_module.dart';
import 'package:pstb/app/modules/auth_guard/auth_guard_page.dart';
import 'package:pstb/app/modules/bottom_nav/bottom_nav_module.dart';
import 'package:pstb/app/modules/bottom_nav/bottom_nav_store.dart';
import 'package:pstb/app/modules/change_password/change_password_module.dart';
import 'package:pstb/app/modules/community/community_page_store.dart';
import 'package:pstb/app/modules/community/detail_question/detail_question_page.dart';
import 'package:pstb/app/modules/community/group_diseases_page/detail_answer_disease/detail_answer_disease_module.dart';
import 'package:pstb/app/modules/community/question_page/widgets/question_module.dart';
import 'package:pstb/app/modules/community/search_question/result_search_question_page.dart';
import 'package:pstb/app/modules/community/search_question/search_question_page.dart';

import 'package:pstb/app/modules/emergency/emergency_module.dart';
import 'package:pstb/app/modules/emergency_call/emergency_call_module.dart';
import 'package:pstb/app/modules/first_aid_guide/first_aid_module.dart';

import 'package:pstb/app/modules/home/home_store.dart';
import 'package:pstb/app/modules/home/offer_detail/promotion_detail_page.dart';
import 'package:pstb/app/modules/home/offer_detail/promotion_detail_store.dart';
import 'package:pstb/app/modules/home/widgets/category/detail_package_group/detail_package_group_page.dart';
import 'package:pstb/app/modules/home/widgets/category/package_module.dart';
import 'package:pstb/app/modules/landing/landing_module.dart';
import 'package:pstb/app/modules/landing_unit/landing_unit_page.dart';
import 'package:pstb/app/modules/login/login_module.dart';

import 'package:pstb/app/modules/medical_appointment/medical_appointment_module.dart';
import 'package:pstb/app/modules/medical_appointment/medical_appointment_store.dart';
import 'package:pstb/app/modules/medical_unit/all_review_unit/all_review_unit.dart';
import 'package:pstb/app/modules/medical_unit/selection_hospital_store.dart';
import 'package:pstb/app/modules/news/news_module.dart';
import 'package:pstb/app/modules/notification/notification_module.dart';
import 'package:pstb/app/modules/on_board/on_board_module.dart';
import 'package:pstb/app/modules/profile/pages/edit_profile_page/edit_profile_store.dart';
import 'package:pstb/app/modules/profile/pages/setting/setting_store.dart';
import 'package:pstb/app/modules/profile/pages/steps_foot/steps_foot_store.dart';
import 'package:pstb/app/modules/profile/profile_module.dart';
import 'package:pstb/app/modules/signup/signup_info.dart';
import 'package:pstb/app/modules/signup/signup_module.dart';
import 'package:pstb/app/modules/signup/signup_otp_v2.dart';
import 'package:pstb/app/modules/signup/sigup_success.dart';
import 'package:pstb/app/modules/web_view/web_view.dart';
import 'package:pstb/app/user_app_store.dart';
import 'package:pstb/services/api_base_helper.dart';
import 'package:pstb/services/electronic_signature_service.dart';
import 'package:pstb/services/filter_signature_service.dart';
import 'package:pstb/utils/image_picker_helper.dart';
import 'package:pstb/utils/routes.dart';
import 'package:pstb/widgets/theme_data_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../di/locator.dart';
import 'modules/attach_document_his/medical_record_lookup_for_his_page.dart';
import 'modules/attach_document_his/upload_medical_document_page.dart';
import 'modules/business/business_module.dart';
import 'modules/business/business_page.dart';
import 'modules/business/business_store.dart';
import 'modules/business/page/business_detail_screen.dart';
import 'modules/business/page/change_password_business_page.dart';
import 'modules/business/page/reset_password_page.dart';
import 'modules/business/page/web_view_screen.dart';
import 'modules/business_for_his/business_detail_for_his_screen.dart';
import 'modules/business_for_his/business_login_for_his_page.dart';
import 'modules/business_for_his/business_page_for_his.dart';
import 'modules/change_password/change_password_otp.dart';
import 'modules/change_password/change_password_success.dart';
import 'modules/community/community_page_module.dart';
import 'modules/community/group_diseases_page/category_diseases_module.dart';
import 'modules/community/my_question/my_question_page.dart';

import 'modules/electronic_signature_v2/presentation/cubits/departments_cubit/departments_cubit.dart';
import 'modules/electronic_signature_v2/presentation/cubits/filters_cubit/filters_cubit_v2.dart';
import 'modules/electronic_signature_v2/presentation/cubits/patients_cubit/patients_cubit.dart';
import 'modules/electronic_signature_v2/presentation/cubits/roles_cubit/roles_cubit.dart';
import 'modules/electronic_signature_v2/presentation/cubits/sign_action_cubit/sign_action_cubit.dart';
import 'modules/electronic_signature_v2/presentation/document_types_by_status_cubit/document_types_by_status_cubit.dart';
import 'modules/electronic_signature_v2/presentation/pages/sign_home_page_v2.dart';
import 'modules/home/home_module.dart';
import 'modules/home/widgets/category/detail_package_group/detail_package_store.dart';

import 'modules/medical_appointment/pages/medical_package/medical_package_store.dart';
import 'modules/medical_appointment/pages/medical_package/pages/medical_package_page.dart';
import 'modules/medical_unit/search_hospital/search_hospital_page.dart';
import 'modules/medical_unit/selection_hospital_module.dart';

import 'modules/profile/pages/comming_soon/comming_soon_page.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.singleton((i) => singletonAppStore),
    Bind.lazySingleton((i) => UserAppStore()..init()),
    Bind.singleton((i) => BottomNavStore()),
    Bind.lazySingleton((i) => ImagePickerHelper(picker: ImagePicker())),
    Bind.lazySingleton((i) => PromotionDetailStore()),
    Bind.lazySingleton((i) => CommunityPageStore()..checkLogin()),
    Bind.lazySingleton((i) => SelectionHospitalStore()),
    Bind.lazySingleton((i) => HomeStore()),
    // Bind.lazySingleton((i) => HomeStore()..initHomeStore()),
    Bind.singleton((i) => ApiBaseHelper()),
    AsyncBind<SharedPreferences>((i) => SharedPreferences.getInstance()),
    Bind.lazySingleton((i) => EditProfileStore()),
    Bind.lazySingleton((i) => MedicalPackageStore()),
    Bind.lazySingleton((i) => MedicalAppointmentStore()),
    Bind.lazySingleton((i) => SettingStore()..initState()),
    Bind.singleton((i) => ThemeDataWidget()),
    Bind.lazySingleton((i) => DetailPackageStore()),
    Bind.lazySingleton((i) => StepsFootStore()),
    Bind.lazySingleton((i) => ElectronicSignatureService(
        apiBaseHelper: Modular.get<ApiBaseHelper>())),
    Bind.lazySingleton((i) =>
        FilterSignatureService(apiBaseHelper: Modular.get<ApiBaseHelper>())),
    Bind.singleton((i) => GlobalContextService()),
    Bind.lazySingleton((i) => BusinessStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    /// Landing
    ModuleRoute(Modular.initialRoute, module: LandingModule()),

    /// LandingUnit
    ChildRoute(
      AppRoutes.landingUnit,
      child: (_, args) => LandingUnitPage(),
    ),

    /// Onboard
    ModuleRoute(AppRoutes.onBoard, module: OnBoardModule()),

    /// HomePage
    ModuleRoute(AppRoutes.home, module: HomeModule()),
    ChildRoute(AppRoutes.promotionNewsDetail,
        child: (_, args) => PromotionDetailPage(id: args.data)),
    ChildRoute(AppRoutes.detailPackageGroup,
        child: (_, args) => const DetailPackageGroupPage()),

    /// MedicalPackage
    ModuleRoute(AppRoutes.medicalPackageDetail, module: PackageModule()),
    ModuleRoute(AppRoutes.medicalAppointment,
        module: MedicalAppointmentModule()),
    ChildRoute(
      AppRoutes.medicalPackagePage,
      child: (_, args) => const MedicalPackagePage(),
    ),

    /// LoginPage
    ModuleRoute(AppRoutes.login, module: LoginModule()),
    //forgot

    /// NewsPage
    ModuleRoute(AppRoutes.news, module: NewsModule()),

    /// BottomBar
    ModuleRoute(AppRoutes.main, module: BottomNavBarModule()),

    /// AuthGuardPage
    ChildRoute(
      AppRoutes.authGuardPage,
      child: (_, args) => AuthGuardPage(
        data: args.data,
        canPop: true,
      ),
    ),

    /// NotifyPage
    ChildRoute(AppRoutes.noti, child: (_, args) => NotificationModule()),

    /// EmergencyPage
    ModuleRoute(AppRoutes.emergency, module: EmergencyModule()),
    ModuleRoute(AppRoutes.emergencyCall, module: EmergencyCallModule()),

    /// FirstAidPage
    ModuleRoute(AppRoutes.firstAid, module: FirstAidModule()),

    /// SignUp
    ModuleRoute(AppRoutes.signup, module: SignupModule()),
    ChildRoute(AppRoutes.signupInfo, child: (_, __) => const SignupInfo()),
    ChildRoute(AppRoutes.signupSuccess,
        child: (_, __) => const SignupSuccess()),

    /// SchedulePage

    ChildRoute(
      AppRoutes.changePasswordSuccessPage,
      child: (_, args) => const ChangePasswordPageSuccess(),
    ),

    /// ProfilePage
    ModuleRoute(AppRoutes.profile, module: ProfileModule()),

    /// AboutPage
    ModuleRoute(AppRoutes.aboutPage, module: AboutPageModule()),

    /// WebviewPage
    ChildRoute(AppRoutes.webView,
        child: (_, args) => WebViewApp(
              url: args.data,
            )),

    /// ComunityPage
    ModuleRoute(AppRoutes.diseases, module: CategoryDiseasesModule()),
    ModuleRoute(AppRoutes.community, module: CommunityPageModule()),
    ChildRoute(AppRoutes.searchQuestion,
        child: (_, args) => SearchQuestionPage()),
    ChildRoute(AppRoutes.myQuestion, child: (_, args) => MyQuestionPage()),
    ChildRoute(AppRoutes.resultSearchQuestion,
        child: (_, args) => const ResultSearchQuestionPage()),
    ChildRoute(AppRoutes.detailQuestion,
        child: (_, args) => DetailQuestionPage(
              questionTitle: args.data['questionTitle'],
              requesterName: args.data['requesterName'],
              question: args.data['question'],
              topicName: args.data['topicName'],
              createdTime: args.data['createdTime'],
              replierName: args.data['replierName'],
              answer: args.data['answer'],
            )),
    ModuleRoute(AppRoutes.setUpQuestion, module: QuestionModule()),
    ModuleRoute(AppRoutes.detailAnswer, module: DetailAnswerDiseaseModule()),

    /// CommingSoonPage
    ChildRoute(
      AppRoutes.comingSoonPage,
      child: (_, args) => const ComingSoonPage(),
    ),

    /// Seletion Hospital
    ModuleRoute(
      AppRoutes.selectionHospitalModule,
      module: SelectionHospitalModule(),
    ),
    ChildRoute(
      AppRoutes.searchHospitalPage,
      child: (_, args) => SearchHospitalPage(),
    ),
    ChildRoute(
      AppRoutes.allReviewHospital,
      child: (_, args) => AllReviewUnit(),
    ),

    /// Doctor appointment

    ModuleRoute(
      AppRoutes.businessModule,
      module: BusinessModule(),
    ),
    ChildRoute(
      AppRoutes.businessPage,
      child: (_, args) => BusinessPage(),
    ),
    ChildRoute(
      AppRoutes.detailBusinessPage,
      child: (_, args) => BusinessDetailScreen(
        idBusiness: args.data['idBusiness'],
      ),
    ),
    ChildRoute(
      AppRoutes.detailBusinessPageForHis,
      child: (_, args) => BusinessDetailScreenForHis(
        idBusiness: args.data['idBusiness'],
      ),
    ),
    ChildRoute(
      AppRoutes.medicalRecordLookupForHis,
      child: (_, __) => const MedicalRecordLookupForHisPage(),
    ),
    ChildRoute(
      AppRoutes.uploadMedicalDocument,
      child: (_, args) => UploadMedicalDocumentPage(
        dangKyId: args.data['dangKyId'],
        benhNhanId: args.data['benhNhanId'],
      ),
    ),

    ChildRoute(AppRoutes.businessWebViewPdf, child: (_, args) {
      final url = args.data['url'];
      final title = args.data['title'];
      return RadWebViewScreen(url: url, title: title);
    }),
    ChildRoute(
      AppRoutes.businessLoginForHisPage,
      child: (_, __) => const BusinessLoginForHisPage(),
    ),
    ChildRoute(
      AppRoutes.businessPageForHis,
      child: (_, args) => BusinessPageForHis(),
    ),
    ChildRoute(
      AppRoutes.resetPasswordBusiness,
      child: (_, args) => ResetPasswordScreen(),
    ),
    ChildRoute(
      AppRoutes.changePasswordBusiness,
      child: (_, args) => ChangePasswordBusinessScreen(),
    ),
    ModuleRoute(
      AppRoutes.changePassword,
      module: ChangePasswordModule(),
    ),

    ChildRoute(
      '/sign-home-v2',
      child: (_, args) {
        final userName = (args.data?['userName'] ?? 'sys.admin') as String;

        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => FiltersCubitV2()),
            BlocProvider(create: (_) => serviceLocator<DepartmentsCubit>()),
            // LƯU Ý: bạn đang tạo DepartmentsCubit 2 lần ở ShortcutMenuStaff
            // BlocProvider(create: (_) => DepartmentsCubit()),  // bỏ dòng này
            BlocProvider(create: (_) => RolesCubit()..load(userName)),
            BlocProvider(create: (_) => SignActionCubit()),
            BlocProvider(create: (_) => PatientsCubit()),
            BlocProvider(create: (_) => DocumentTypesByStatusCubit()),
          ],
          child: SignHomePageV2(userName: userName),
        );
      },
    ),
  ];
}

class GlobalContextService {
  // late BuildContext _context;
  //
  // void setContext(BuildContext context) {
  //   _context = context;
  // }
  //
  // BuildContext? get context => _context;
  late BuildContext context;

  void setContext(BuildContext ctx) {
    context = ctx;
  }
}
