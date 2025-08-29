class AppRoutes {
  static String landing = "/landing";
  static String landingUnit = "/landingUnit";
  static String home = "/home";
  static String onBoard = "/onBoard";
  static String login = "/login";
  static String signup = "/signup";
  static String news = "/news";
  static String newDetailPage = news + "/newsDetail";
  static String newSearchPage = news + "/newsSearch";
  static String resultSearchNew = news + "/resultSearchNew";
  static String newDetail = news + newDetailPage;
  static String newSearch = news + newSearchPage;
  static String resultNewSearch = news + resultSearchNew;
  static String main = "/main";
  static String search = "/search";
  static String calendar = "/calendar";
  static String noti = "/noti";
  static String user = "/user";
  static String mainHome = "/main/home";
  static String emergency = "/emergency";
  static String firstAid = "/firstAid";
  static String myQRCode = "/myQRCode";
  static String forgot = '/forgot';
  static String includePhoneNumber = "/includePhoneNumber";
  static String forgotPage = "/forgotPage";
  static String forgotOTP = '/forgotOTP';
  static String forgotSuccess = '/forgotSuccess';
  static String signupForm = '/signupForm';
  static String signupOTP = '/signupOTP';
  static String signupInfo = "/signupInfo";
  static String signupSuccess = '/signupSuccess';
  static String emergencyCall = '/emergencyCall';
  static String authGuardPage = '/authGuardPage';
  static String detailPackageGroup = '/detailPackageGroup';
  // change password
  static String changePassword = '/changePassword';
  static String changePasswordOtp = '/changePasswordOtp';
  static String changePasswordSuccessPage = '/changePasswordSuccess';
  static String changePasswordSuccess =
      changePassword + changePasswordSuccessPage;

  // end change password

  // Route Appointment
  static String medicalAppointment = "/medicalAppointment";
  static String medicalPackagePage = '/medicalPackage';
  static String doctorInfoPage = '/doctorInfo';
  static String medicalPackageDetailPage = '/medicalPackageDetail';
  static String medicalTimeVisitDoctorPage = '/medicalTimeVisitDoctor';
  static String medicalTimeGetResultTestPage = '/medicalTimeGetSample';
  static String medicalLocationGetSamplePage = '/medicalLocationGetSample';
  static String selectDoctorPage = '/selectDoctor';
  static String searchDoctorPage = '/searchDoctor';
  static String searchMedicalPackage = '/searchMedicalPackage';
  static String packageSearchPage = '/packageSearchPage';
  static String doctorSearchPage = '/doctorSearchPage';
  static String medicalAppointmentTemPage = '/medicalAppointmentTemPage';
  static String confirmAndPaymentPage = '/confirmAndPayment';
  static String confirmAndPaymentSuccessPage = '/confirmAndPaymentSuccess';
  static String covidDeclarationPage = '/covidDeclaration';
  static String getSampleAtHome = '/getSampleAtHome';
  static String postInfoExamAtHome = '/postInfoExamAtHome';
  static String postInfoTestAtHome = '/postInfoTestAtHome';
  static String getSampleAtHomePage = medicalAppointment + getSampleAtHome;
  static String postInfoExamPage = medicalAppointment + postInfoExamAtHome;
  static String postInfoTestPage = medicalAppointment + postInfoTestAtHome;
  static String doctorInfo = medicalAppointment + doctorInfoPage;
  static String medicalPackageDetail =
      medicalAppointment + medicalPackageDetailPage;
  static String medicalTimeVisitDoctor =
      medicalAppointment + medicalTimeVisitDoctorPage;
  static String medicalTimeGetResultTest =
      medicalAppointment + medicalTimeGetResultTestPage;
  static String medicalLocationGetSample =
      medicalAppointment + medicalLocationGetSamplePage;
  static String appointmentConfirmAndPayment =
      medicalAppointment + confirmAndPaymentPage;
  static String selectDoctor = medicalAppointment + selectDoctorPage;
  static String searchDoctor = medicalAppointment + searchDoctorPage;
  static String searchMedical = medicalAppointment + searchMedicalPackage;
  static String packageSearch = medicalAppointment + packageSearchPage;
  static String doctorSearch = medicalAppointment + doctorSearchPage;
  static String medicalConfirmAndSuccess =
      medicalAppointment + confirmAndPaymentSuccessPage;
  static String medicalAppointmentCovidDeclaration =
      medicalAppointment + covidDeclarationPage;

  // end route medical appointment

  static String scheduleDetail = '/scheduleDetail';
  static String electronicMedicalRecords = '/electronicMedicalRecords';
  static String overallIndexPage = '/overallIndex';
  static String overallIndex = electronicMedicalRecords + overallIndexPage;
  static String historyPage = '/electronicMedicalRecords';
  static String history = electronicMedicalRecords + historyPage;
  static String historyDetailPage = '/historyDetailPage';
  static String historyDetail = electronicMedicalRecords + historyDetailPage;
  static String pathologicalRecordsPage = '/pathologicalRecordsPage';
  static String pathologicalRecords =
      electronicMedicalRecords + pathologicalRecordsPage;
  static String prescriptionPage = '/prescriptionPage';
  static String prescription = electronicMedicalRecords + prescriptionPage;
  static String diagnosePage = '/diagnosePage';
  static String diagnose = electronicMedicalRecords + diagnosePage;
  static String diagnoseDetail = electronicMedicalRecords + diagnoseDetailPage;
  static String diagnoseDetailPage = '/diagnoseDetailPage';

  static String cameraPage = '/cameraPage';
  static String camera = electronicMedicalRecords + cameraPage;

  static String displayPicturePage = '/displayPage';
  static String displayPicture = electronicMedicalRecords + displayPicturePage;
  static String formAddHistoryManualExaminationPage =
      '/formAddHistoryManualExamination';
  static String formAddHistoryManualExamination =
      electronicMedicalRecords + formAddHistoryManualExaminationPage;
  static String historyAddManualPage = '/historyAddManual';
  static String historyAddManual =
      electronicMedicalRecords + historyAddManualPage;

  // Prescription
  static String prescriptionModule = '/prescriptionModule';
  static String prescriptionListPage = '/PrescriptionListPage';
  static String prescriptionList = prescriptionModule + prescriptionListPage;
  static String prescriptionQRPage = '/prescriptionQRPage';
  static String prescriptionQR = prescriptionModule + prescriptionQRPage;
  static String prescriptionAwaitCheckPage = '/prescriptionAwaitCheckPage';
  static String prescriptionAwaitCheck =
      prescriptionModule + prescriptionAwaitCheckPage;
  static String prescriptionAddPhotoPage = '/prescriptionAddPhotoPage';
  static String prescriptionAddPhoto =
      prescriptionModule + prescriptionAddPhotoPage;
  static String prescriptionSendSuccessPage = '/prescriptionSendSuccessPage';
  static String prescriptionSendSuccess =
      prescriptionModule + prescriptionSendSuccessPage;

  // Get Presciption
  static String getPrescriptionModule = '/getPrescriptionModule';
  static String prescriptionDetailsPage = '/prescriptionDetailsPage';
  static String prescriptionDetails =
      getPrescriptionModule + prescriptionDetailsPage;
  static String settingDeliveryLocationPage = '/settingDeliveryLocationPage';
  static String settingDeliveryLocation =
      getPrescriptionModule + settingDeliveryLocationPage;
  static String confirmAndPayPage = '/confirmAndPayPage';
  static String confirmAndPay = getPrescriptionModule + confirmAndPayPage;
  static String prescriptionPaymentQRSuccessPage =
      '/prescriptionPaymentQRSuccessPage';
  static String prescriptionPaymentQRSuccess =
      getPrescriptionModule + prescriptionPaymentQRSuccessPage;
  static String prescriptionPaymentSuccessPage =
      '/prescriptionPaymentSuccessPage';
  static String prescriptionPaymentSuccess =
      getPrescriptionModule + prescriptionPaymentSuccessPage;

  // profile
  static String profile = '/profile';
  static String profilePage = '/profilePage';
  static String qrPersonal = '/qrPersonal';
  static String profileMainPage = profile + profilePage;
  static String newEditProfile = '/newEditProfile';
  static String newEditProfilePage = profile + newEditProfile;
  static String addInsurancePage = '/addInsurancePage';
  static String paymentMethodPage = '/paymentMethodPage';
  static String paymentMethod = profile + paymentMethodPage;
  static String debitPage = '/debitPage';
  static String debit = profile + debitPage;
  static String bankListPage = '/bankListPage';
  static String bankList = profile + bankListPage;
  static String addATMPage = '/addATMPage';
  static String addATM = profile + addATMPage;
  static String comingSoonPage = '/comingSoonPage';
  static String comingSoon = profile + comingSoonPage;
  static String profileSettingPage = '/profileSettingPage';
  static String profileSetting = profile + profileSettingPage;
  static String profileStepsFoodPage = '/profileStepFoodPage';
  static String profileStepsFood = profile + profileStepsFoodPage;

  // vaccine
  static String vaccine = '/vaccine';
  static String webView = '/webView';
  static String promotionNewsDetail = '/promoteDetail';
  static const String aboutPage = '/aboutPage';

  // payment
  static String paymentPortal = '/paymentPortal';

  //community
  static const String community = '/community';
  static const String searchQuestion = '/searchQuestion';
  static const String myQuestion = '/myQuestion';
  static const String resultSearchQuestion = '/resultSearchQuestion';
  static const String detailQuestion = '/detailQuestion';
  static const String setUpQuestion = '/setUpQuestion';
  static const String diseases = '/diseases';
  static const String detailAnswer = "/detailAnswer";

  //EHR Page
  static String ehrModule = '/ehrModule';
  static String ehrPage = '/ehrPage';
  static String ehrResult = '/ehrResults';
  static String pdfIndication = '/pdfIndication';
  static String otpSignaturePatient = '/otpSignaturePatient';
  static String ehrResultDetails = ehrModule + ehrResult;

  //staff
  static String nursePage = '/nursePage';
  static String inputPatient = '/inputPatient';
  static String inforPage = '/inforPage';
  static const String photoView = '/photoView';
  static const String qrCode = "/qrCode";
  static const String recordingPage = "/recordingPage";
  static const String electronicSignature = '/electronicSignature';
  static const String detailSignaturePage = '/detailSignaturePage';
  static const String therapyInformation = '/therapyInformation';
  static const String detailTherapy = '/detailTherapy';
  static const String takeCare = "/takeCare";
  static const String createHealthCare = "/createHealthCare";
  static const String command = '/command';
  static const String inputHeathycare = '/inputHeathycare';
  //DocumentPatientPage
  static String documentPatientModule = '/documentPatientModule';
  static const String documentPatientPage = '/documentPatientPage';
  static String pdfDocumentPatient = '/pdfDocumentPatient';
  static String otpdocumentPatient = '/otpdocumentPatient';

  //Specific-patient
  static const String specificPatient = '/specificPatient';
  static const String listSpecific = '/listSpecific';
  static const String checkingSpecific = '/checkingSpecific';

  //Selection_hospital
  static const String selectionHospitalModule = '/selectionHospitalModule';
  static const String selectionHospitalPage = '/selectionHospitalPage';
  static const String detailHospitalPage = '/detailHospitalPage';
  static const String searchHospitalPage = '/searchHospitalPage';
  static const String allReviewHospital = '/allReviewHospital';

  //doctorAppointment
  static const String doctorAppointmentModule = '/doctorAppointmentModule';
  static const String doctorAppointmentPage = '/doctorAppointmentPage';

  //perform-medicine
  static const String perFormMedicineModule = '/perFormMedicineModule';
  static const String perFormMedicinePage = '/perFormMedicinePage';
  static const String perFormMedicineOrderPage = '/perFormMedicineOrderPage';
  static const String performMedicineConfigPage = '/performMedicineConfigPage';

  //Business Page
  static String businessModule = '/businessModule';
  static String businessPage = '/businessPage';
  static String businessLoginPage = '/businessLoginPage';
  static String detailBusinessPage = "/detailBusinessPage";
  static String businessWebViewPdf = '/businessWebViewPdf';
  static String businessRadPreview =
      "https://rad.vduh.org/ris/hisPreview?serviceID=";
  static String resetPasswordBusiness = "/resetPasswordBusiness";
  static String changePasswordBusiness = "/changePasswordBusiness";
}
