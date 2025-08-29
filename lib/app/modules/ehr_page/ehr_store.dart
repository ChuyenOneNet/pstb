import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:pstb/Keys.dart';
import 'package:pstb/app/models/prescription_model.dart';
import 'package:pstb/app/modules/home/home_store.dart';
import 'package:pstb/app_initlization.dart';
import 'package:pstb/utils/date_time_custom_utils.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/utils/order_by_time_utils_indications.dart';
import 'package:pstb/utils/sessions/session_prefs.dart';
import 'package:pstb/utils/time_util.dart';
import 'package:mobx/mobx.dart';
import '../../../services/api_base_helper.dart';
import '../../../services/api_exception.dart';
import '../../../services/electronic_signature_service.dart';
import '../../../utils/helpers/config_helper.dart';
import '../../../utils/helpers/firebase_config.dart';
import '../../models/all_prescription_model.dart';
import '../../models/electronic_signature_model.dart';
import '../../models/examination_result_model.dart';
import '../../models/medical_record_model.dart';
import '../../models/paging_model.dart';

part 'ehr_store.g.dart';

const String authorizationIntegration = 'sys.admin:1';
const String roleCode = 'BAC_SI';
const String? userName = 'sys.admin';

class EHRStore = EHRStoreBase with _$EHRStore;

abstract class EHRStoreBase with Store {
  final _apiBaseHelper = Modular.get<ApiBaseHelper>();
  final HomeStore homeStore = Modular.get<HomeStore>();
  final electronicSignatureService = Modular.get<ElectronicSignatureService>();

  @observable
  UserStatus isLogin = UserStatus.Checking;

  @observable
  MedicalRecordModel data = MedicalRecordModel();

  @observable
  Patient? patient;
  @observable
  int currentIndexPrescriptions = -1;
  @observable
  int currentIndexIndications = -1;
  @observable
  File? imageFile;

  @observable
  ObservableList<String> prescriptionDate = ObservableList<String>.of([]);
  @observable
  String selectDate = '';

  @observable
  String image = "";

  @observable
  bool loading = true;
  String registrationId = '';
  @observable
  ExaminationResultModel resultsData = ExaminationResultModel();
  @observable
  ObservableList<bool> isListPrescriptionsExpanded =
      ObservableList<bool>.of([]);
  @observable
  List<bool> isListIndicationsExpanded = [];
  @observable
  List<Indications> listIndicationsGroupByDay = [];
  @observable
  ObservableList<Prescription> prescriptionData =
      ObservableList<Prescription>.of([]);
  @observable
  List<Map<String, List<Indications>>> indicationGroupByDate = [];
  @observable
  List<List<PrescriptionModel>> listPrescriptionModel = [[]];
  @observable
  bool isLoading = true;
  @observable
  Uint8List? uint8list;
  @observable
  int pageSolution = 0;
  @observable
  bool isLoadMore = true;
  @observable
  bool showMore = true;
  @observable
  int pageIndex = 0;
  @observable
  String? patientName;
  String urlPdf = '';
  String chiSoBMI = '';

  // tài liệu kí số
  @observable
  bool loadSignature = false;
  @observable
  Paging<DocumentModel> documentPagination = Paging<DocumentModel>();
  @observable
  int dem = 0;
  @observable
  bool isLoadingMoreItem = true;
  @observable
  bool isShowCheckedItem = false;
  @observable
  ObservableList<DocumentModel> listESM = ObservableList<DocumentModel>.of([]);
  @observable
  String? status;
  @observable
  bool checkSigning = false;
  @observable
  bool prepareSign = false;
  @observable
  String? transactionId;
  @observable
  List<bool> selectedDocuments = [];
  @observable
  int? signingStatus;
  @observable
  int start = 60;
  @observable
  int page = 0;
  @observable
  bool enableText = true;
  @observable
  String titleDetailPdf = "";

  // Hồ sơ bệnh nhân
  @observable
  List<Patient> listPatient = ObservableList<Patient>.of([]);

  @action
  void setIsLogin(UserStatus loginStatus) => isLogin = loginStatus;

  @action
  void setDate(String date) => selectDate = date;

  @action
  String getChiSoBMI(InfoExaminations? data) {
    double roundDouble(double value, int places) {
      num mod = pow(10.0, places);
      return ((value * mod).round().toDouble() / mod);
    }

    if (data!.weight != null &&
        data.height != null &&
        data.weight!.isNotEmpty &&
        data.height!.isNotEmpty) {
      String weight = data.weight!.split(' ')[0];
      String height = data.height!.split(' ')[0];
      double w = double.parse(weight);
      double h = double.parse(height) / 100;
      double bmi = w / (h * h);
      chiSoBMI = roundDouble(bmi, 2).toString();
    }
    return chiSoBMI;
  }

  @action
  Future<void> initDetailExaminationState({String? examinationRegisId}) async {
    EasyLoading.show();
    try {
      await loadPrescriptionDate(registrationId);
      await loadDetailExamination(registrationId);
      await getSigner();
      // currentIndexPrescriptions = -1;
      // currentIndexIndications = -1;
      listPrescriptionModel =
          List.generate(prescriptionDate.length, (index) => []);
      pageSolution = 0;
    } catch (e) {
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg: 'Lỗi dữ liệu');
    }
    EasyLoading.dismiss();
  }

  @action
  Future loadPatientRecord() async {
    EasyLoading.show();
    loading = true;
    if (listPatient.isNotEmpty) {
      listPatient.clear();
    }
    try {
      //TODO load with API
      // final response = await _apiBaseHelper.get(
      //   ApiUrl.patient,
      // );
      // final dataResponse = PatientRecordModel.fromJson(response);
      // for (var element in dataResponse.patients!) {
      //   listPatient.add(element);
      // }
      // listPatient = listPatient.reversed.toList();
      final response = await _apiBaseHelper.get(ApiUrl.patient);
      final dataResponse = PatientRecordModel.fromJson(response);
      if (dataResponse.patients?.isNotEmpty == true) {
        listPatient.addAll(dataResponse.patients!);
      } else {
        // Dữ liệu rỗng → dùng fake data
        listPatient.addAll(_fakePatients());
      }
    } catch (e) {
      listPatient.addAll(_fakePatients());
      loading = false;
      print(e);
    }
    loading = false;
    EasyLoading.dismiss();
    // await FireBaseRemoteConfigService.getConfig();
    // initApp();
  }

  List<Patient> _fakePatients() => [
        Patient(
          id: '1',
          name: 'Nguyen Van A',
          dateOfBirth: '01/01/1990',
          code: 'P001',
          phone: '0909123456',
          address: '123 Main St',
        ),
        Patient(
          id: '2',
          name: 'Tran Thi B',
          dateOfBirth: '02/02/1985',
          code: 'P002',
          phone: '0909876543',
          address: '456 Second St',
        ),
      ];
  @action
  Future loadMedicalRecord(String patientId) async {
    EasyLoading.show();
    print('patientId=${patientId}');
    loading = true;
    try {
      // final response = await _apiBaseHelper.get(
      //   ApiUrl.medicalRecord,
      //   {"patientId": patientId},
      // );
      // final dataResponse = MedicalRecordModel.fromJson(response);
      // data = dataResponse;
      final response = await _apiBaseHelper.get(
        ApiUrl.medicalRecord,
        {"patientId": patientId},
      );
      final dataResponse = MedicalRecordModel.fromJson(response);

      if (dataResponse.patient != null) {
        data = dataResponse;
      } else {
        data = _fakeMedicalRecord(patientId);
      }
      patientName = data.patient?.name ?? '';
      selectDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
      loading = false;
    } on AppException catch (e) {
      data = _fakeMedicalRecord(patientId);
      EasyLoading.dismiss();
      loading = false;
      Fluttertoast.showToast(
          msg: e.getMessage(), backgroundColor: AppColors.error500);
    } catch (e) {
      data = _fakeMedicalRecord(patientId);
      loading = false;
    }
    EasyLoading.dismiss();
  }

  MedicalRecordModel _fakeMedicalRecord(String patientId) => MedicalRecordModel(
        patient: Patient(
          id: patientId,
          name: 'Nguyen Van A',
          code: 'P001',
          dateOfBirth: '15:30 01/01/1990',
          phone: '0909123456',
          address: '123 Main St',
        ),
        examinations: [
          Examination(
            registrationId: 'reg1',
            time: '09:10 06/10/2024',
            icd: 'A00',
          ),
          Examination(
            registrationId: 'reg2',
            time: '20:51 06/15/2024',
            icd: 'B01',
          ),
        ],
      );
  @action
  Future loadDetailExamination(String registrationId) async {
    if (registrationId == "") return;
    try {
      // final response = await _apiBaseHelper
      //     .get(ApiUrl.examination, {'registrationId': registrationId});
      // final dataResponse = ExaminationResultModel.fromJson(response);
      final dataResponse = ExaminationResultModel(
        patient: Patient(
          id: 'p123',
          name: 'Nguyễn Văn A',
          code: 'BN001',
          dateOfBirth: '15:30 01/01/1990',
          phone: '0909123456',
          address: '123 Đường ABC, Quận 1, TP.HCM',
        ),
        examination: InfoExaminations(
          pulse: '${Random().nextInt(30) + 60} nhịp/phút',
          temperature: '${(36 + Random().nextDouble()).toStringAsFixed(1)} °C',
          bloodPressure:
              '${100 + Random().nextInt(20)}/${70 + Random().nextInt(10)} mmHg',
          breathing: '${Random().nextInt(5) + 16} lần/phút',
          height: '${150 + Random().nextInt(30)} cm',
          weight: '${50 + Random().nextInt(20)} kg',
          reason: 'Khám tổng quát định kỳ',
          diagnosis: 'Cảm cúm nhẹ, mệt mỏi',
          icdDiseases: 'R53',
          includingDiseases: 'E11',
          solution: 'Theo dõi và nghỉ ngơi',
          doctorName: 'BS. Trần Thị B',
        ),
        indications: List.generate(3, (index) {
          return Indications(
            id: 'ind$index',
            title: 'Xét nghiệm máu ${index + 1}',
            code: 'XN00$index',
            time: '01/07/2025',
          );
        }),
      );
      resultsData.examination = dataResponse.examination;
      await Future.delayed(const Duration(milliseconds: 300)); // giả lập delay

      indicationGroupByDate =
          getListOrderByTimeIndications(listOrders: dataResponse.indications);
      indicationGroupByDate.map((e) {
        List.generate(
            indicationGroupByDate.length,
            (index) => listIndicationsGroupByDay = indicationGroupByDate[index]
                    [indicationGroupByDate[index].keys.toList()[index]] ??
                []);
      }).toList();
    } on AppException catch (e) {
      EasyLoading.dismiss();
      Fluttertoast.showToast(
          msg: e.getMessage(), backgroundColor: AppColors.error500);
    } catch (e) {
      EasyLoading.dismiss();
    }
  }

  @action
  Future<void> loadDetailIndication(int index, bool value) async {
    if (!value) {
      currentIndexIndications = -1;
      listIndicationsGroupByDay = List.empty(growable: true);
      return;
    }
    currentIndexIndications = index;
    final getDatetime = indicationGroupByDate[index].keys.toList()[0];
    listIndicationsGroupByDay = [
      ...indicationGroupByDate[index][getDatetime] ?? []
    ];
  }

  @action
  Future<void> loadListPrescription(String dateTime, int index,
      {bool value = false}) async {
    if (!value) {
      currentIndexPrescriptions = -1;
      listPrescriptionModel[index] = List.empty();
      return;
    }
    try {
      EasyLoading.show();
      final response = await _apiBaseHelper.get(ApiUrl.medicalListByDayV2, {
        'registrationId': registrationId,
        'date': TimeUtil.toBackendString(
            DateTimeCustomUtils.parseDateTimeEhr(dateTime: dateTime))
      });
      final dataResponse = (response as List<dynamic>)
          .map((e) => PrescriptionModel.fromJson(e as Map<String, dynamic>))
          .toList();
      currentIndexPrescriptions = index;
      for (final item in dataResponse) {
        listPrescriptionModel[index] = List.filled(dataResponse.length, item);
      }
      EasyLoading.dismiss();
    } on AppException catch (e) {
      EasyLoading.dismiss();
      Fluttertoast.showToast(
          msg: e.getMessage(), backgroundColor: AppColors.error500);
    } catch (e) {
      currentIndexPrescriptions = -1;
      listPrescriptionModel[index] = List.empty(growable: true);
      EasyLoading.dismiss();
    }
  }

  @action
  Future<void> onChangeIndexSolution(int index) async {
    pageSolution = index;
    currentIndexPrescriptions = -1;
    currentIndexIndications = -1;
  }

  @action
  Future<void> loadPrescriptionDate(String registrationId) async {
    if (registrationId == "") return;
    if (prescriptionDate.isNotEmpty) {
      prescriptionDate.clear();
    }
    try {
      final response = await _apiBaseHelper.get(
          ApiUrl.medicalDayPrescriptionV2, {'registrationId': registrationId});
      for (var item in response) {
        prescriptionDate.add(item);
      }
      prescriptionDate.sort((a, b) => b.compareTo(a));
    } on AppException catch (e) {
      EasyLoading.dismiss();
      Fluttertoast.showToast(
          msg: e.getMessage(), backgroundColor: AppColors.error500);
    } catch (e) {
      prescriptionDate.clear();
    }
  }

  @action
  Future<void> getDetailPrescription(
      {String? medicalInstructionId,
      String? examinationId,
      String? type}) async {
    EasyLoading.show();
    try {
      final response = await _apiBaseHelper.get(ApiUrl.detailPrescriptionV2, {
        'type': type,
        if (medicalInstructionId == null || medicalInstructionId.isEmpty)
          'examinationId': examinationId,
        if (examinationId == null || examinationId.isEmpty)
          'medicalInstructionId': medicalInstructionId
      });
      if (response != null) {
        urlPdf = response['url'];
        if (!urlPdf.contains('http://')) {
          urlPdf = 'http://' + urlPdf;
        }
        print('urlPdf =  $urlPdf');
        // if(urlPdf.contains('2025')){
        //   urlPdf = urlPdf.replaceAll('2025', '3025');
        // }
        // print('urlPdf =  $urlPdf');
      } else {
        urlPdf = '';
      }
    } on AppException catch (e) {
      EasyLoading.dismiss();
      Fluttertoast.showToast(
          msg: e.getMessage(), backgroundColor: AppColors.error500);
    } catch (e) {
      print(e);
    }
    EasyLoading.dismiss();
  }

  Future<void> getDetailIndications({
    String? medicalIndicationId,
    String? code,
  }) async {
    EasyLoading.show();
    try {
      final response = await _apiBaseHelper.get(
          ApiUrl.indication,
          {'id': medicalIndicationId, 'code': code},
          const Duration(seconds: 20));
      if (response != null) {
        int medicalUnitId = await SessionPrefs.getMedicalUnitId() ?? 0;
        urlPdf = response['url'];
        // fix đổi 2025 thành 3025 để xem cận lâm sàng
        if (!urlPdf.contains('http://') &&
            urlPdf.contains('2025') &&
            medicalUnitId == 10) {
          urlPdf = urlPdf.replaceAll('2025', '3025');
          urlPdf = 'http://' + urlPdf;
        } else if (!urlPdf.contains('http://')) {
          urlPdf = 'http://' + urlPdf;
        }
        print('urlPdf =  $urlPdf');
        print('medicalunit = ${medicalUnitId}');
      } else {
        urlPdf = '';
      }
    } on AppException catch (e) {
      EasyLoading.dismiss();
      Fluttertoast.showToast(
          msg: e.getMessage(), backgroundColor: AppColors.error500);
      urlPdf = '';
    } catch (e) {
      print(e);
      urlPdf = '';
    }
    EasyLoading.dismiss();
  }

  @action
  Future reloadData(String patientId, String phone) async {
    EasyLoading.show();
    loading = true;
    try {
      final response = await _apiBaseHelper.get(ApiUrl.medicalRecord, {
        "phone": phone,
        'fromDate': selectDate,
        'toDate': TimeUtil.format(DateTime.now(), TimeUtil.DDMMYYYY),
      });
      final dataResponse = MedicalRecordModel.fromJson(response);
      data = dataResponse;
      patientName = data.patient?.name ?? '';
    } on AppException catch (e) {
      EasyLoading.dismiss();
      loading = false;
      Fluttertoast.showToast(
          msg: e.getMessage(), backgroundColor: AppColors.error500);
    } catch (e) {
      loading = false;
    }
    loading = false;
    EasyLoading.dismiss();
  }

  @action
  Future<void> getSigner() async {
    isLoading = true;
    listESM.clear();
    headers['AuthorizationIntegration'] = authorizationIntegration;
    try {
      final response = await _apiBaseHelper.get(
        ApiUrl.getPatientDocuments,
        {'pageIndex': 0, 'pageSize': 10},
      );
      final documentPaging = Paging<DocumentModel>.fromJson(response, (item) {
        return DocumentModel.fromJson(item);
      });
      listESM.addAll(documentPaging.items!);
    } on AppException catch (e) {
      EasyLoading.dismiss();
      isLoading = false;
      Fluttertoast.showToast(
          msg: e.getMessage(), backgroundColor: AppColors.error500);
    } catch (e) {
      isLoading = false;
      documentPagination.items = null;
    }
    isLoading = false;
  }

  @action
  Future<void> onRefreshPage() async {
    isLoading = true;
    listESM.clear();
    page = 0;
    try {
      final response = await _apiBaseHelper.get(
        ApiUrl.getPatientDocuments,
        {'pageIndex': 0, 'pageSize': 10},
      );
      final documentPaging = Paging<DocumentModel>.fromJson(response, (item) {
        return DocumentModel.fromJson(item);
      });
      listESM.addAll(documentPaging.items!);
    } on AppException catch (e) {
      EasyLoading.dismiss();
      isLoading = false;
      Fluttertoast.showToast(
          msg: e.getMessage(), backgroundColor: AppColors.error500);
    } catch (e) {
      isLoading = false;
      documentPagination.items = null;
    }
    isLoading = false;
  }

  @action
  Future<void> loadMoreSignature() async {
    page++;
    try {
      isLoadingMoreItem = true;
      final response = await _apiBaseHelper.get(
        ApiUrl.getPatientDocuments,
        {'pageIndex': page, 'pageSize': 10},
      );
      final documentPaging = Paging<DocumentModel>.fromJson(response, (item) {
        return DocumentModel.fromJson(item);
      });
      if (documentPaging.items != null) {
        listESM.addAll(documentPaging.items!);
        isLoadingMoreItem = false;
      }
      if (documentPagination.items!.isEmpty) {
        isLoadingMoreItem = false;
        return;
      }
    } on AppException catch (e) {
      EasyLoading.dismiss();
      isLoading = false;
      Fluttertoast.showToast(
          msg: e.getMessage(), backgroundColor: AppColors.error500);
    } catch (e) {
      //state.stateLoadMore.value = LoadMoreState.error;
    }
  }

  @action
  Future<void> prepareSignPatient(String id, String documentTypeCode) async {
    isLoading = true;
    EasyLoading.show();
    try {
      final data = await electronicSignatureService.patientPrepare(
          ids: <String>[id], documentTypeCode: documentTypeCode);
      if (data.transactionId != null && data.transactionId!.isNotEmpty) {
        transactionId = data.transactionId;
        prepareSign = true;
      } else {
        prepareSign = false;
      }
    } on AppException catch (e) {
      EasyLoading.dismiss();
      isLoading = false;
      Fluttertoast.showToast(
          msg: e.getMessage(), backgroundColor: AppColors.error500);
    } catch (e) {
      prepareSign = false;
      isLoading = false;
      print(e);
    }
    isLoading = false;
    EasyLoading.dismiss();
  }

  @action
  Future<void> patientVerifyOtp(
    String otp,
    String transactionId,
    DocumentModel documentModel,
  ) async {
    isLoading = true;
    EasyLoading.show();
    try {
      final data = await _apiBaseHelper.put(
        ApiUrl.verifyOTPSigning,
        jsonEncode({
          "otp": otp,
          "transactionId": transactionId,
        }),
      );
      if (data != null) {
        checkSigning = true;
        documentModel.setSigned();
        Modular.to.pop();
        Fluttertoast.showToast(
            msg: 'Ký thành công', toastLength: Toast.LENGTH_LONG);
      } else {
        status = 'Sai mã OTP. Vui lòng nhập lại.';
      }
    } on AppException catch (e) {
      EasyLoading.dismiss();
      isLoading = false;
      Fluttertoast.showToast(
          msg: e.getMessage(),
          backgroundColor: AppColors.error500,
          toastLength: Toast.LENGTH_LONG);
    } catch (e) {
      EasyLoading.dismiss();
      isLoading = false;
    }
    EasyLoading.dismiss();
    isLoading = false;
  }

  @action
  Future<void> onRefreshPDF(DocumentModel documentModel) async {
    urlPdf =
        'http://${ApiUrl.baseUrl}${ApiUrl.getPDFDocuments}/${documentModel.id}';
    try {
      // final statusSigning = DocumentModel.fromJson(
      //         await Modular.get<ApiBaseHelper>()
      //             .get('${ApiUrl.getDetailDocuments}/${documentModel.id}'))
      //     .signingStatus;
      // if (statusSigning == null) {
      //   if (signingStatus == 0) {
      //     checkSigning = false;
      //   } else {
      //     checkSigning = true;
      //   }
      // } else if (statusSigning == 0) {
      //   checkSigning = false;
      //   documentModel.signingStatus = signingStatus;
      // } else {
      //   checkSigning = true;
      //   documentModel.signingStatus = signingStatus;
      // }
    } on AppException catch (e) {
      Fluttertoast.showToast(
          msg: e.getMessage(), backgroundColor: AppColors.error500);
    }
  }

  String? get supportPhoneNumber => ConfigHelper.instance
      .getConfigByCodeSync(ConfigHelper.supportLine)
      ?.value;

  @observable
  Map<String, String>? headerForPdf;

  @action
  Future getHeaderForPdf() async {
    headerForPdf = await ApiBaseHelper.getHeaderWithMedicalUnitId();
    print("get header:${headerForPdf}");
    headerForPdf?.addAll(
        {HttpHeaderNames.authorizationIntegration: Keys.signAuthorizationKey});
  }
}
