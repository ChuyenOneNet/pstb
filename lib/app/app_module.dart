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
import 'package:pstb/app/modules/doctor_appointment/doctor_appointment_module.dart';
import 'package:pstb/app/modules/ehr_page/ehr_module.dart';
import 'package:pstb/app/modules/ehr_page/pages/signature_patient/otp_signature.dart';
import 'package:pstb/app/modules/emergency/emergency_module.dart';
import 'package:pstb/app/modules/emergency_call/emergency_call_module.dart';
import 'package:pstb/app/modules/first_aid_guide/first_aid_module.dart';
import 'package:pstb/app/modules/forgot_password/forgot_module.dart';
import 'package:pstb/app/modules/forgot_password/forgot_page.dart';
import 'package:pstb/app/modules/forgot_password/forgot_page_success.dart';
import 'package:pstb/app/modules/forgot_password/widget/include_phone_number/include_phone_module.dart';
import 'package:pstb/app/modules/home/home_store.dart';
import 'package:pstb/app/modules/home/offer_detail/promotion_detail_page.dart';
import 'package:pstb/app/modules/home/offer_detail/promotion_detail_store.dart';
import 'package:pstb/app/modules/home/widgets/category/detail_package_group/detail_package_group_page.dart';
import 'package:pstb/app/modules/home/widgets/category/package_module.dart';
import 'package:pstb/app/modules/landing/landing_module.dart';
import 'package:pstb/app/modules/landing_unit/landing_unit_page.dart';
import 'package:pstb/app/modules/login/login_module.dart';
import 'package:pstb/app/modules/manage_document_patient/document_patient_module.dart';
import 'package:pstb/app/modules/medical_appointment/medical_appointment_module.dart';
import 'package:pstb/app/modules/medical_appointment/medical_appointment_store.dart';
import 'package:pstb/app/modules/medical_unit/all_review_unit/all_review_unit.dart';
import 'package:pstb/app/modules/medical_unit/selection_hospital_store.dart';
import 'package:pstb/app/modules/news/news_module.dart';
import 'package:pstb/app/modules/notification/notification_module.dart';
import 'package:pstb/app/modules/nurse_page/electronic_signature/detail_signature/detail_signature_page.dart';
import 'package:pstb/app/modules/nurse_page/electronic_signature/detail_signature/detail_signature_store.dart';
import 'package:pstb/app/modules/nurse_page/electronic_signature/electronic_signature_page.dart';
import 'package:pstb/app/modules/nurse_page/electronic_signature/electronic_signature_store.dart';
import 'package:pstb/app/modules/nurse_page/electronic_signature/filter_signature/filter_signature_store.dart';
import 'package:pstb/app/modules/nurse_page/information_nurse/information_page.dart';
import 'package:pstb/app/modules/nurse_page/input_heathycare/input_heathycare.dart';
import 'package:pstb/app/modules/nurse_page/input_patient/input_patient.dart';
import 'package:pstb/app/modules/nurse_page/nurse_searching_page.dart';
import 'package:pstb/app/modules/nurse_page/qr_scanner/qr_code_store.dart';
import 'package:pstb/app/modules/nurse_page/therapy_information/detail_therapy/command/command_page.dart';
import 'package:pstb/app/modules/nurse_page/therapy_information/detail_therapy/command/command_store.dart';
import 'package:pstb/app/modules/nurse_page/therapy_information/detail_therapy/detail_therapy_page.dart';
import 'package:pstb/app/modules/nurse_page/therapy_information/detail_therapy/detail_therapy_store.dart';
import 'package:pstb/app/modules/nurse_page/therapy_information/detail_therapy/health_care_patient/create_care/create_care_store.dart';
import 'package:pstb/app/modules/nurse_page/therapy_information/detail_therapy/health_care_patient/create_care/create_health_care_page.dart';
import 'package:pstb/app/modules/nurse_page/therapy_information/detail_therapy/health_care_patient/healthcare_store.dart';
import 'package:pstb/app/modules/nurse_page/therapy_information/therapy_information_page.dart';
import 'package:pstb/app/modules/nurse_page/therapy_information/therapy_information_store.dart';
import 'package:pstb/app/modules/nurse_page/widgets/recording_page.dart';
import 'package:pstb/app/modules/on_board/on_board_module.dart';
import 'package:pstb/app/modules/profile/pages/edit_profile_page/edit_profile_store.dart';
import 'package:pstb/app/modules/profile/pages/setting/setting_store.dart';
import 'package:pstb/app/modules/profile/pages/steps_foot/steps_foot_store.dart';
import 'package:pstb/app/modules/profile/profile_module.dart';
import 'package:pstb/app/modules/schedule/schedule_module.dart';
import 'package:pstb/app/modules/schedule_detail/schedule_detail_module.dart';
import 'package:pstb/app/modules/signup/signup_info.dart';
import 'package:pstb/app/modules/signup/signup_module.dart';
import 'package:pstb/app/modules/signup/signup_otp_v2.dart';
import 'package:pstb/app/modules/signup/sigup_success.dart';
import 'package:pstb/app/modules/specific_patient/checking_information_specific/checking_information_specific_page.dart';
import 'package:pstb/app/modules/specific_patient/checking_information_specific/checking_specific_patient_store.dart';
import 'package:pstb/app/modules/specific_patient/list_specific/list_specific_page.dart';
import 'package:pstb/app/modules/specific_patient/list_specific/list_specific_store.dart';
import 'package:pstb/app/modules/specific_patient/specific_patient_page.dart';
import 'package:pstb/app/modules/specific_patient/specific_patient_store.dart';
import 'package:pstb/app/modules/web_view/web_view.dart';
import 'package:pstb/app/user_app_store.dart';
import 'package:pstb/services/api_base_helper.dart';
import 'package:pstb/services/electronic_signature_service.dart';
import 'package:pstb/services/filter_signature_service.dart';
import 'package:pstb/services/registration_service.dart';
import 'package:pstb/utils/image_picker_helper.dart';
import 'package:pstb/utils/routes.dart';
import 'package:pstb/widgets/theme_data_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/perform_medicine/medicine_usage_model.dart';
import 'modules/business/business_module.dart';
import 'modules/business/business_page.dart';
import 'modules/business/business_store.dart';
import 'modules/business/page/business_detail_screen.dart';
import 'modules/business/page/change_password_business_page.dart';
import 'modules/business/page/reset_password_page.dart';
import 'modules/business/page/web_view_screen.dart';
import 'modules/change_password/change_password_otp.dart';
import 'modules/change_password/change_password_success.dart';
import 'modules/community/community_page_module.dart';
import 'modules/community/group_diseases_page/category_diseases_module.dart';
import 'modules/community/my_question/my_question_page.dart';
import 'modules/ehr_page/ehr_page.dart';
import 'modules/ehr_page/pages/pdf_indication/pdf_indication_page.dart';
import 'modules/forgot_password/forgot_store.dart';
import 'modules/home/home_module.dart';
import 'modules/home/widgets/category/detail_package_group/detail_package_store.dart';
import 'modules/manage_document_patient/widget/otp_document_page.dart';
import 'modules/manage_document_patient/widget/pdf_document_page.dart';
import 'modules/medical_appointment/pages/medical_package/medical_package_store.dart';
import 'modules/medical_appointment/pages/medical_package/pages/medical_package_page.dart';
import 'modules/medical_unit/detail_hospital/detail_hospital_page.dart';
import 'modules/medical_unit/search_hospital/search_hospital_page.dart';
import 'modules/medical_unit/selection_hospital_module.dart';
import 'modules/nurse_page/nurse_searching_modular.dart';
import 'modules/nurse_page/nurse_searching_store.dart';
import 'modules/nurse_page/qr_scanner/qr_scanner_page.dart';
import 'modules/nurse_page/therapy_information/detail_therapy/health_care_patient/health_care_page.dart';
//import 'modules/nurse_page_new/electronic_signature/example_sign_page.dart';
import 'modules/perform_medicine/medicine_usage/medicine_usage_page.dart';
import 'modules/perform_medicine/perform_medicine_module.dart';
import 'modules/perform_medicine/perform_medicine_order/perform_medicine_order.dart';
import 'modules/perform_medicine/perform_medicine_page.dart';
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
    Bind.lazySingleton((i) => CheckingSpecificPatientStore()),
    Bind.lazySingleton((i) => MedicalPackageStore()),
    Bind.lazySingleton((i) => ListSpecificStore()),
    Bind.lazySingleton((i) => MedicalAppointmentStore()),
    Bind.lazySingleton((i) => SpecificPatientStore()),
    Bind.lazySingleton((i) => SettingStore()..initState()),
    Bind.singleton((i) => ThemeDataWidget()),
    Bind.lazySingleton((i) => NurseSearchingStore()),
    Bind.lazySingleton((i) => DetailSignatureStore()),
    Bind.lazySingleton((i) => ElectronicSignatureStore()),
    Bind.lazySingleton((i) => FilterSignatureStore()),
    Bind.lazySingleton((i) => DetailPackageStore()),
    Bind.lazySingleton((i) => TherapyInformationStore()),
    Bind.lazySingleton((i) => DetailSignatureStore()),
    Bind.lazySingleton((i) => DetailTherapyStore()),
    Bind.lazySingleton((i) => CommandStore()),
    Bind.lazySingleton((i) => HealthCareStore()),
    Bind.lazySingleton((i) => CreateCareStore()),
    // Bind.lazySingleton((i) => QRCodeStore()),
    Bind.lazySingleton((i) => StepsFootStore()),
    Bind.lazySingleton((i) => ElectronicSignatureService(
        apiBaseHelper: Modular.get<ApiBaseHelper>())),
    Bind.lazySingleton((i) =>
        FilterSignatureService(apiBaseHelper: Modular.get<ApiBaseHelper>())),
    Bind.lazySingleton((i) =>
        RegistrationService(apiBaseHelper: Modular.get<ApiBaseHelper>())),
    Bind.singleton((i) => GlobalContextService()),
    Bind.lazySingleton((i) => BusinessStore()),
    Bind.lazySingleton((i) => ForgotStore()),
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
    ChildRoute(AppRoutes.forgotPage, child: (_, args) => const ForgotPage()),
    ChildRoute(AppRoutes.forgotSuccess,
        child: (_, args) => ForgotPageSuccess()),

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

    /// TherapyPage
    ChildRoute(
      AppRoutes.takeCare,
      child: (_, args) => const HealthCarePage(),
    ),
    ChildRoute(
      AppRoutes.createHealthCare,
      child: (_, args) => const CreateHealthCarePage(),
    ),
    ChildRoute(
      AppRoutes.therapyInformation,
      child: (_, args) => const TherapyInformationPage(),
    ),
    ChildRoute(
      AppRoutes.detailTherapy,
      child: (_, args) => DetailTherapyPage(id: args.data['id']),
    ),

    /// EhrPage
    ModuleRoute(AppRoutes.ehrModule, module: EHRModule()),
    ChildRoute(
      AppRoutes.ehrPage,
      child: (_, args) => EHRPage(
        patientId: args.data['patientId'],
        phone: args.data['phone'],
      ),
    ),
    ChildRoute(
      AppRoutes.pdfIndication,
      child: (_, args) => PDFIndicationPage(
        documentModel: args.data['documentModel'],
      ),
    ),
    ChildRoute(
      AppRoutes.otpSignaturePatient,
      child: (_, args) => OtpSignaturePatient(
        transactionId: args.data['transactionId'],
        documentModel: args.data['documentModel'],
      ),
    ),

    /// EmergencyPage
    ModuleRoute(AppRoutes.emergency, module: EmergencyModule()),
    ModuleRoute(AppRoutes.emergencyCall, module: EmergencyCallModule()),

    /// FirstAidPage
    ModuleRoute(AppRoutes.firstAid, module: FirstAidModule()),

    /// NursePage
    //ModuleRoute(AppRoutes.nursePage, module: NurseSearchingModule()),
    ChildRoute(
      AppRoutes.electronicSignature,
      child: (_, args) => ElectronicSignaturePage(
        userName: args.data['userName'] as String?,
        roleCode: args.data['rollCode'] as String?,
      ),
    ),
    //ChildRoute("/testsign", child: (_, __) => const ExampleSignPage()),
    ChildRoute(AppRoutes.inputPatient, child: (_, __) => const InputPatient()),
    ChildRoute(AppRoutes.inforPage, child: (_, __) => InformationNursePage()),
    //ChildRoute(AppRoutes.qrCode, child: (_, __) => const QRScannerPage()),
    ChildRoute(AppRoutes.recordingPage, child: (_, __) => RecordingPage()),
    // ChildRoute(AppRoutes.nursePage,
    //     child: (_, args) => const NurseSearchingPage()),
    ChildRoute(
      AppRoutes.detailSignaturePage,
      child: (_, args) => DetailSignaturePage(
        documentModel: args.data['documentModel'],
      ),
    ),
    ChildRoute(
      AppRoutes.command,
      child: (_, args) => const CommandPage(),
    ),
    ChildRoute(AppRoutes.inputHeathycare,
        child: (_, __) => const InputHealthyCare()),

    /// ForgotPage
    ModuleRoute(AppRoutes.forgot, module: ForgotModule()),
    ChildRoute(AppRoutes.forgotPage, child: (_, __) => const ForgotPage()),
    ChildRoute(AppRoutes.forgotSuccess,
        child: (_, __) => const ForgotPageSuccess()),
    ModuleRoute(AppRoutes.includePhoneNumber, module: IncludePhoneModule()),

    /// SignUp
    ModuleRoute(AppRoutes.signup, module: SignupModule()),
    ChildRoute(AppRoutes.signupOTP, child: (_, __) => const SignupOtpV2()),
    ChildRoute(AppRoutes.signupInfo, child: (_, __) => const SignupInfo()),
    ChildRoute(AppRoutes.signupSuccess,
        child: (_, __) => const SignupSuccess()),

    /// SchedulePage
    ModuleRoute(AppRoutes.calendar, module: ScheduleModule()),
    ModuleRoute(AppRoutes.scheduleDetail, module: ScheduleDetailModule()),

    /// ChangePassword
    ModuleRoute(AppRoutes.changePassword, module: ChangePasswordModule()),
    ChildRoute(
      AppRoutes.changePasswordOtp,
      child: (_, args) => const ChangePasswordOtpScreen(),
    ),
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

    /// SpecificPatientPage
    ChildRoute(AppRoutes.specificPatient,
        child: (_, args) => const SpecificPatientPage()),
    ChildRoute(AppRoutes.listSpecific,
        child: (_, args) => const ListSpecificPatientPage()),
    ChildRoute(AppRoutes.checkingSpecific,
        child: (_, args) => const CheckingInformationSpecificPage()),

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

    /// DocumentPatientPage
    ModuleRoute(AppRoutes.documentPatientModule,
        module: DocumentPatientModule()),
    ChildRoute(
      AppRoutes.pdfDocumentPatient,
      child: (_, args) => PdfDocumentPage(
        documentModel: args.data['documentModel'],
        index: args.data['index'],
      ),
    ),
    ChildRoute(
      AppRoutes.otpdocumentPatient,
      child: (_, args) => OtpDocumentPage(
        transactionId: args.data['transactionId'],
        documents: args.data['documents'],
      ),
    ),

    /// Seletion Hospital
    ModuleRoute(
      AppRoutes.selectionHospitalModule,
      module: SelectionHospitalModule(),
    ),
    ChildRoute(
      AppRoutes.detailHospitalPage,
      child: (_, args) => DetailHospitalPage(
        hospitalModel: args.data['hospitalModel'],
      ),
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
      AppRoutes.doctorAppointmentModule,
      module: DoctorAppointmentModule(),
    ),

    ModuleRoute(
      AppRoutes.perFormMedicineModule,
      module: PerformMedicineModule(),
    ),
    ChildRoute(
      AppRoutes.perFormMedicinePage,
      child: (_, args) => PerformMedicinePage(),
    ),
    ChildRoute(
      AppRoutes.perFormMedicineOrderPage,
      child: (_, args) => PerformMedicineOrdersPage(
        executionDate: args.data['executionDate'],
        patientCode: args.data['patientCode'],
        patientInfo: args.data['patientInfo'],
      ),
    ),
    ChildRoute(
      AppRoutes.performMedicineConfigPage,
      child: (_, args) => PerformMedicineConfigPage(
        executionDate: args.data['executionDate'] as String,
        patientCode: args.data['patientCode'] as String,
        patientInfo: args.data['patientInfo'] as String,
        userName: args.data['userName'] as String,
        initialData: (args.data['initialData'] as List<dynamic>)
            .cast<MedicineUsageModel>(),
      ),
    ),

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
    ChildRoute(AppRoutes.businessWebViewPdf, child: (_, args) {
      final url = args.data['url'];
      return WebViewScreen(url: url);
    }),
    ChildRoute(
      AppRoutes.resetPasswordBusiness,
      child: (_, args) => ResetPasswordScreen(),
    ),
    ChildRoute(
      AppRoutes.changePasswordBusiness,
      child: (_, args) => ChangePasswordBusinessScreen(),
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
