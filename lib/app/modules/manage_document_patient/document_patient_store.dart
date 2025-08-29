import 'dart:convert';
import 'dart:io';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pstb/services/api_base_helper.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Keys.dart';
import '../../../services/api_exception.dart';
import '../../../services/electronic_signature_service.dart';
import '../../../utils/api_url.dart';
import '../../../utils/colors.dart';
import '../../../utils/helper.dart';
import '../../models/electronic_signature_model.dart';
import '../../models/paging_model.dart';

part 'document_patient_store.g.dart';

const String authorizationIntegration = 'sys.admin:1';

class DocumentPatientStore = DocumentPatientStoreBase
    with _$DocumentPatientStore;

abstract class DocumentPatientStoreBase with Store {
  final _apiBaseHelper = Modular.get<ApiBaseHelper>();
  final electronicSignatureService = Modular.get<ElectronicSignatureService>();

  @observable
  UserStatus isLogin = UserStatus.Checking;
  @observable
  String urlPdf = '';
  @observable
  bool isLoading = true;
  @observable
  bool loadSignature = false;
  @observable
  Paging<DocumentModel> documentPagination = Paging<DocumentModel>();
  @observable
  String? nameRoll;
  @observable
  bool isLoadingMoreItem = true;
  @observable
  bool isShowCheckedItem = false;
  @observable
  int statusSignature = 0;
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
  List<bool> selectedDocuments =
      []; // list biến check trạng thái checkbox đc chọn để kí nhiều
  @observable
  int?
      signingStatus; // biến status nếu document.signingstatus sau khi refresh màn pdf bị null
  @observable
  int start = 60; //tgian nhập otp
  @observable
  int page = 0; //pageIndex loadmore
  @observable
  bool enableText = true; // biến check cho phép nhập ở pinText màn otp
  Map<int, String> signedDocumentMap = {};
  @observable
  String? documentTypeCode;
  @observable
  List<String> ids = []; //list id tài liệu được chọn
  @observable
  List<DocumentModel> documents = []; // list tài liệu đc chọn để kí nhiều

  @action
  void setIsLogin(UserStatus loginStatus) => isLogin = loginStatus;

  @action
  void onChangeValue(int index) {
    isLoading = true;
    selectedDocuments[index] = !selectedDocuments[index];
    if (selectedDocuments[index] == true) {
      ids.add(listESM[index].id ?? '');
      documents.add(listESM[index]);
    }
    if (ids.isNotEmpty && selectedDocuments[index] == false) {
      ids.removeWhere((item) => item == listESM[index].id);
      documents.removeWhere((element) => element.id == listESM[index].id);
    }
    isLoading = false;
  }

  @action
  Future<void> onChooseAllDocument(String documentTypeCode) async {
    isLoading = true;
    for (var element in listESM) {
      if (documentTypeCode == element.documentTypeCode &&
          element.signingStatus == 0) {
        ids.add(element.id ?? '');
        documents.add(element);
        selectedDocuments = List.generate(listESM.length, (index) => true);
      }
    }
    isLoading = false;
  }

  @action
  Future<void> prepareSignDocuments(
      List<String> Ids, String documentTypeCode) async {
    isLoading = true;
    EasyLoading.show();
    try {
      final data = await electronicSignatureService.patientPrepare(
          ids: Ids, documentTypeCode: documentTypeCode);
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
          msg: e.getMessage(),
          backgroundColor: AppColors.error500,
          toastLength: Toast.LENGTH_LONG);
    } catch (e) {
      prepareSign = false;
      isLoading = false;
      print(e);
    }
    isLoading = false;
    ids.clear();
    EasyLoading.dismiss();
  }

  @action
  Future<void> documentsVerifyOtp(
    String otp,
    String transactionId,
    List<DocumentModel> documents,
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
      // TODO : data verifyOTP đang test
      if (data != null) {
        checkSigning = true;
        for (var element in documents) {
          element.setSigned();
        }
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
          gravity: Platform.isIOS ? ToastGravity.TOP : ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG);
    } catch (e) {
      EasyLoading.dismiss();
      isLoading = false;
    }
    isShowCheckedItem = false;
    documents.clear();
    ids.clear();
    EasyLoading.dismiss();
    isLoading = false;
  }

  @action
  Future<void> getSigner() async {
    EasyLoading.show();
    isLoading = true;
    listESM.clear();
    page = 0;
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
      selectedDocuments = List.generate(listESM.length, (index) => false);
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
    EasyLoading.dismiss();
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
      selectedDocuments = List.generate(listESM.length, (index) => false);
    } on AppException catch (e) {
      EasyLoading.dismiss();
      isLoading = false;
      Fluttertoast.showToast(
          msg: e.getMessage(), backgroundColor: AppColors.error500);
    } catch (e) {
      isLoading = false;
      documentPagination.items = null;
    }
    isShowCheckedItem = false;
    documents.clear();
    ids.clear();
    isLoading = false;
  }

  @action
  Future<void> loadMoreSignature() async {
    page++;
    try {
      // isLoadingMoreItem = true;
      final response = await _apiBaseHelper.get(
        ApiUrl.getPatientDocuments,
        {'pageIndex': page, 'pageSize': 10},
      );
      final documentPaging = Paging<DocumentModel>.fromJson(response, (item) {
        return DocumentModel.fromJson(item);
      });
      if (documentPaging.items != null) {
        listESM.addAll(documentPaging.items!);
        selectedDocuments = List.generate(listESM.length, (index) => false);
        // isLoadingMoreItem = false;
      }
      // if (documentPagination.items!.isEmpty) {
      //   isLoadingMoreItem = false;
      //   return;
      // }
    } on AppException catch (e) {
      EasyLoading.dismiss();
      isLoading = false;
      Fluttertoast.showToast(
          msg: e.getMessage(), backgroundColor: AppColors.error500);
    } catch (e) {
      print(e);
    }
  }

  @action
  Future<void> onRefreshPDF(DocumentModel documentModel) async {
    urlPdf =
        '${ApiUrl.baseUrl}${ApiUrl.getPatientPDFDocument}/${documentModel.id}';
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
      //   documentModel.signingStatus = statusSigning;
      // } else {
      //   checkSigning = true;
      //   documentModel.signingStatus = statusSigning;
      // }
    } on AppException catch (e) {
      Fluttertoast.showToast(
          msg: e.getMessage(), backgroundColor: AppColors.error500);
    }
  }

  @observable
  Map<String, String>? headerForPdf;

  @action
  Future getHeaderForPdf() async {
    headerForPdf = await ApiBaseHelper.getHeaderWithMedicalUnitId();
    headerForPdf?.addAll(
        {HttpHeaderNames.authorizationIntegration: Keys.signAuthorizationKey});
  }
}
