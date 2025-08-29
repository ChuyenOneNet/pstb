import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/models/electronic_signature_model.dart';
import 'package:pstb/app/modules/nurse_page/electronic_signature/electronic_signature_store.dart';
import 'package:pstb/app/modules/nurse_page/nurse_searching_store.dart';
import 'package:pstb/services/api_base_helper.dart';
import 'package:pstb/services/api_exception.dart';
import 'package:pstb/services/electronic_signature_service.dart';
import 'package:pstb/utils/api_url.dart';
import 'package:mobx/mobx.dart';

part 'detail_signature_store.g.dart';

class DetailSignatureStore = _DetailSignatureStoreBase
    with _$DetailSignatureStore;

abstract class _DetailSignatureStoreBase with Store {
  @observable
  String? linkPdf;
  DocumentModel documentItem = DocumentModel();
  final _nurseController = Modular.get<NurseSearchingStore>();
  final _electricSignatureService = Modular.get<ElectronicSignatureService>();
  final _electricSignatureController = Modular.get<ElectronicSignatureStore>();
  @observable
  String? nameStatus;
  @observable
  String? statusSuccess;
  int? index;
  String? statusError;
  @action
  Future<void> onDetailDocuments(
      {required DocumentModel documentModelSelected,
      required int indexSelected}) async {
    documentItem = documentModelSelected;
    index = indexSelected;
    linkPdf =
        '${ApiUrl.baseUrl}${ApiUrl.getPDFDocuments}/${documentItem.id}';

    if (documentItem.signingStatus == 1) {
      nameStatus = 'Thu hồi ký';
    } else {
      nameStatus = 'Thực hiện ký';
    }
  }

  @action
  Future<void> actionDocument() async {
    if (documentItem.signingStatus == 1) {
      await _revokeDocument();
    } else {
      await _signDocument();
    }
  }

  @action
  Future<void> onRefresh() async {
    linkPdf =
        '${ApiUrl.baseUrl}${ApiUrl.getPDFDocuments}/${documentItem.id}';
    try {
      // documentItem.signingStatus = DocumentModel.fromJson(
      //         await Modular.get<ApiBaseHelper>()
      //             .get('${ApiUrl.getDetailDocuments}/${documentItem.id}'))
      //     .signingStatus;
    } on AppException catch (e) {
      statusError = e.getMessage();
    }
  }

  _revokeDocument() async {
    try {
      final data = await _electricSignatureService.revokeSignatures(
          userName: _nurseController.nurseModel.code,
          ids: <String>[documentItem.id!]);
      if (data.ids!.contains(documentItem.id!)) {
        linkPdf =
            '${ApiUrl.baseUrl}${ApiUrl.getPDFDocuments}/${documentItem.id}';
        statusSuccess = 'Huỷ ký thành công';
        nameStatus = 'Thực hiện ký';
        _electricSignatureController.isLoading = true;
        _electricSignatureController
            .documentPagination.items![index ?? 0].signingStatus = 0;
        _electricSignatureController.isLoading = false;
      } else {
        _electricSignatureController
            .documentPagination.items![index ?? 0].signingStatus = 1;
        nameStatus = 'Thu hồi ký';
        statusSuccess = 'Huỷ ký thất bại';
      }
    } catch (e) {
      nameStatus = 'Thu hồi ký';
      statusSuccess = 'Huỷ ký thất bại';
    }
  }

  _signDocument() async {
    try {
      final data = await _electricSignatureService.signDocument(
          userName: _nurseController.nurseModel.code,
          roleCode: _electricSignatureController.signerRoll?.code,
          ids: <String>[documentItem.id!]);
      if (data.ids!.contains(documentItem.id!)) {
        linkPdf =
            '${ApiUrl.baseUrl}${ApiUrl.getPDFDocuments}/${documentItem.id}';
        statusSuccess = 'Ký thành công';
        nameStatus = 'Thu hồi ký';
        _electricSignatureController.isLoading = true;
        _electricSignatureController
            .documentPagination.items![index ?? 0].signingStatus = 1;
        _electricSignatureController.isLoading = false;
      }
      // else {
      //   nameStatus = 'Thực hiện ký';
      //   _electricSignatureController
      //       .documentPagination.items![index ?? 0].signingStatus = 0;
      //   statusSuccess = 'Ký thất bại';
      // }
    } catch (e) {
      linkPdf =
      '${ApiUrl.baseUrl}${ApiUrl.getPDFDocuments}/${documentItem.id}';
      statusSuccess = 'Ký thành công';
      nameStatus = 'Thu hồi ký';
      _electricSignatureController.isLoading = true;
      _electricSignatureController
          .documentPagination.items![index ?? 0].signingStatus = 1;
      _electricSignatureController.isLoading = false;
      //nameStatus = 'Thực hiện ký';
      //statusSuccess = 'Ký thất bại';
    }
  }
}
