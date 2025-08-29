class ApiUrl {
  // static String apiBaseUrl = "http://10.0.2.2:5243";
  // static const String baseUrl = "http://192.168.1.123:5245"; // url on truong-lx
  // static String baseUrl = "http://192.168.1.123:5245"; // url on truong-lx
  // static String baseUrl = "http://192.168.1.3:5245";
  //static String baseUrl = "http://116.97.240.210:5244";
  // static String baseUrl = "http://115.146.126.203:5243"; // url on HYH - 1
  //  static String baseUrl = "http://115.146.126.203:5244"; // url on HYH - 2
  static String baseUrl = "http://192.168.1.57:5245";
  ////static String baseUrl = "http://116.97.240.210:55";
  static String baseUrlDocs = "http://192.168.1.11:8190";
  static String baseUrlVDUH = "https://tracuuketqua.vduh.org";
  static const String config = '/api/config';
  static const String token = "/api/account/login/";
  static String tokenV2 = "/api/account/login/v2";
  static const String refreshToken = "/api/account/refresh/";
  static const String regis = "/api/account/regis/";
  static const String regisV2 = "/api/account/register/v2";
  static const String checkOtp = "/api/account/register/v2/verify-otp";
  static const String getAccountInfo = "/api/account/detail";
  static const String isExistAccount = "/api/account/isExist";
  static const String deleteAccount = "/api/account/delete-account/";
  static const String updateAccountInfo = "/api/account";
  static const String uploadAvatar = "/api/account/upload-avatar";
  static const String uploadDocument = "/api/nursing/push-document";
  static const String category = "/api/category/search/";
  static const String packages = "/api/packages/";
  static const String packageDetail = '/api/packages/';
  static const String news = "/api/news/";
  static const String tags = "/api/news/tags/";
  static const String doctors = "/api/doctor/";
  static String prominentDoctor = "/api/doctor/out-standing";
  static String medicalServiceDoctor = "/api/packages/byDoctor";
  static const String userAppointment = "/api/appointment/user";
  static const String loginBySocial = "/api/account/login-social/";
  static const String registerNotification = "api/user/register_notification";
  static const String appointment = "/api/appointment/";
  static const String changePassword = "/api/account/change-password";
  static const String updateTokenFirebase =
      "/api/account/update-firebase-token";
  static const String promotion = "/api/promotion/";
  static const String userAddress = "/api/user/address/";
  static const String advisory = "/api/advisory/";
  static const String tutorials = "/api/tutorial/";
  static const String qrcode = "/api/user/qrcode/";
  static const String upload = "/api/upload";
  static const String firstAid = "/api/first-aid";
  static const String getOtp = "/api/otp";
  static const String resetPassword = "/api/reset_password/";
  static const String forgotPassword = "/api/account/forgot-password/";
  static const String notifications = "/api/notification/user";
  static const String systemNotifications = "/api/notification/system";
  static const String apiGetCategoryDisease = "/api/social/topic";
  static const String bookmarksUser = "/api/user/bookmarks";
  static const String apiMyQuestion = "/api/social/user-question";
  static const String apiSocialQuestion = "/api/social/question";
  static const String patient = "api/medical-record/patients";
  static const String medicalRecord = "/api/medical-record/record";
  static const String examination = "api/medical-record/examination";
  static const String indication = "/api/medical-record/instruction";
  static const String detailPrescription = "/api/medical-record/prescription";
  static const String packageGroup = "/api/package-group";
  static const String nursingPatient = "/api/nursing/patient";
  static const String nursing = "/api/nursing/create-care";
  static const String nursingGetStaff = '/api/nursing/staff';
  static const String getTreatment = '/api/treatment/treatments';
  static const String getHealthCare = '/api/treatment/detail-healthcare';
  static const String getCommand = '/api/treatment/detail-instruction';

  ///API v2
  static const String medicalListByDayV2 = "api/v2/medical-record/list-by-day";
  static const String medicalDayPrescriptionV2 =
      '/api/v2/medical-record/day-has-prescription';
  static const String detailPrescriptionV2 = '/api/v2/medical-record/detail';
  static const String pdfMedicalRecord = '/api/v2/medical-record/pdf';

  ///sign
  static const String getRoles = '/api/signing/signer-roles';
  static const String getRolesV2 = '/api/usersignaturerole/get-signatureroles/';
  static const String getDocuments = '/api/signing/document';
  static const String getDocumentsV2 =
      '/api/treereference/get-filtered-signbatch?userName=sys.admin.tamnm';
  static const String getPDFDocuments = '/api/signing/document/pdf';
  static const String getPDFDocumentsV2 = '/api/document/view-document-signer';
  static const String getPatientPDFDocument =
      '/api/signing/patient/document/pdf';
  static const String getDetailDocuments = '/api/signing/document/detail';
  static const String sign = '/api/signing/document/sign';
  static const String signV2 = '/api/signxml/sign-batch';
  static const String signPatient = '/api/signing/patient';
  static const String signDepartment = '/api/signing/department';
  static const String revokeSignature =
      '/api/signing/document/revoke-signature';
  static const String revokeSignatureV2 = '/api/document/revoke-signeds';
  static const String documentType = '/api/signing/document/document-type';
  static const String documentTypeV2 = '/api/documenttype/getall';
  static const String patientPrepareSigning = '/api/signing/patient/prepare';
  static const String verifyOTPSigning = '/api/signing/patient/verify-otp';
  static const String getPatientDocuments = '/api/signing/patient/document';

  ///indication
  static const String indicationRegistration =
      '/api/patient/indication/registration';
  static const String registration = '/api/patient/indication';

  ///medical unit
  static const String getMedicalUnit = '/api/medical-unit';
  static const String getUnitProminent = '/api/medical-unit/out-standing';
  static const String detailMedicalUnit = '/api/medical-unit/';

  ///staff
  static const String getStaffInfo = '/api/staff/info';
  static const String staffReferenceAccount = '/api/staff/reference-account';
  static const String getAccountStaff = '/api/staff/staff';
  static const String getUserHisInfo =
      '/api/services/app/User/GetUserByUserName';
  static String staffPatient = "/api/staff/patient";
  static const String staffCare = "/api/staff/create-care";
  static String staffUploadDocument = "/api/staff/push-document";
  static String appointmentDoctor = "/api/appointment/of-doctor";

  //business
  static const String getUserBusiness = "/api/VduhBusiness/signin";
  static const String getBusinessHistory = "/api/VduhBusiness/histories";
  static const String getBusinessDetail = "/api/VduhBusiness/history";
  static const String getVienPhiPdf = "/api/VduhBusiness/medical-fee";
  static const String resetPasswordBusiness =
      "/api/VduhBusiness/reset-password";
  static const String changePasswordBusiness =
      "/api/VduhBusiness/change-password";
}

class ApiConstance {
  static const String changePasswordKey =
      'YjxwIzsrwchb5zvKTLifTzhOqaZByP+Fb8B7uAqDgN8=';
}
