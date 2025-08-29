import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pstb/app/models/electronic_signature_model.dart';
import 'package:pstb/app/modules/ehr_page/ehr_store.dart';
import 'package:pstb/app/modules/ehr_page/pages/pdf_indication/pdf_indication_store.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/app_bar.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../../services/api_base_helper.dart';
import '../../../../../widgets/stateless/app_button.dart';

class PDFIndicationPage extends StatefulWidget {
  final DocumentModel documentModel;

  const PDFIndicationPage({
    Key? key,
    required this.documentModel,
  }) : super(key: key);

  @override
  State<PDFIndicationPage> createState() => _PDFIndicationPageState();
}

class _PDFIndicationPageState
    extends ModularState<PDFIndicationPage, PDFIndicationStore> {
  final ehrStore = Modular.get<EHRStore>();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Scaffold(
        appBar: CustomAppBar(
          title: ehrStore.titleDetailPdf,
          isBack: true,
          actionIcon: ehrStore.pageSolution == 2
              ? const Icon(
                  Icons.refresh,
                  color: AppColors.primary,
                )
              : ehrStore.pageSolution == 1
                  ? const Icon(
                      Icons.share,
                      color: AppColors.primary,
                    )
                  : const SizedBox(),
          actionFunc: ehrStore.pageSolution == 2
              ? () async {
                  EasyLoading.show();
                  await ehrStore.onRefreshPDF(widget.documentModel);
                  await ehrStore.getHeaderForPdf();
                  EasyLoading.dismiss();
                }
              : ehrStore.pageSolution == 1
                  ? () {
                      Share.share(ehrStore.urlPdf);
                    }
                  : null,
        ),
        body: ehrStore.urlPdf.isNotEmpty
            ? Observer(builder: (context) {
                return SfPdfViewer.network(
                  ehrStore.urlPdf,
                  headers: ehrStore.headerForPdf,
                  enableDoubleTapZooming: true,
                );
              })
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Lỗi hệ thống. Vui lòng quay lại sau !',
                          textAlign: TextAlign.center,
                          style: Styles.content,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
        floatingActionButton: Observer(builder: (context) {
          return ehrStore.pageSolution == 2 && ehrStore.checkSigning == false
              ? FloatingActionButton(
                  elevation: 0.0,
                  child: const Icon(
                    Icons.edit,
                  ),
                  backgroundColor: AppColors.primary,
                  onPressed: () async {
                    await ehrStore.prepareSignPatient(
                      widget.documentModel.id!,
                      widget.documentModel.documentTypeCode!,
                    );
                    if (ehrStore.prepareSign == true) {
                      Modular.to
                          .pushNamed(AppRoutes.otpSignaturePatient, arguments: {
                        'transactionId': ehrStore.transactionId,
                        'documentModel': widget.documentModel,
                      });
                      Modular.to.pop();
                    } else {
                      Fluttertoast.showToast(
                          msg: 'Lỗi hệ thống. Vui lòng quay lại sau.',
                          backgroundColor: AppColors.error500);
                    }
                  })
              : const SizedBox();
        }),
      );
    });
  }
}
