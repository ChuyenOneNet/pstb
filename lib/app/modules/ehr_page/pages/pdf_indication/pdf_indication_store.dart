import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pstb/app/models/all_prescription_model.dart';
import 'package:mobx/mobx.dart';

part 'pdf_indication_store.g.dart';

class PDFIndicationStore = PDFIndicationStoreBase with _$PDFIndicationStore;

abstract class PDFIndicationStoreBase with Store {
  @observable
  String urlPdf = '';

  @action
  Future<void> initState(String url) async {
    urlPdf = url;
  }

  @action
  Future<void> getImagePdfPrescription(Prescription prescription) async {
    try {
      // EasyLoading.show();
      // // final data = await ApiBaseHelper().get(ApiUrl.detailPrescription,{
      // //   'id': prescription.id??'',
      // //   'doctorId': prescription.doctorId ??'',
      // // });
      // // final pdf = ResultPdfModel.fromJson(data);
      // urlPdf = pdf.url??'';
    } catch (e) {
      EasyLoading.dismiss();
    }
    EasyLoading.dismiss();
  }
}
