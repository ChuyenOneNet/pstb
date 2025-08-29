import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pstb/Keys.dart';
import 'package:pstb/app/modules/manage_document_patient/document_patient_store.dart';
import 'package:pstb/services/api_base_helper.dart';

import '../../../../utils/api_url.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/routes.dart';
import '../../../../utils/styles.dart';
import '../../../../widgets/stateless/app_bar.dart';
import '../../../../widgets/stateless/app_button.dart';
import '../../../models/electronic_signature_model.dart';

class PdfDocumentPage extends StatefulWidget {
  final DocumentModel documentModel;
  final int index;

  const PdfDocumentPage(
      {Key? key, required this.documentModel, required this.index})
      : super(key: key);

  @override
  State<PdfDocumentPage> createState() => _PdfDocumentPageState();
}

class _PdfDocumentPageState extends State<PdfDocumentPage> {
  final DocumentPatientStore documentPatientStore =
      Modular.get<DocumentPatientStore>();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('document url pdf ${documentPatientStore.urlPdf}');
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.documentModel.name,
        isBack: true,
        actionIcon: const Icon(
          Icons.refresh,
          color: AppColors.primary,
        ),
        actionFunc: () async {
          EasyLoading.show();
          await documentPatientStore.onRefreshPDF(widget.documentModel);
          await documentPatientStore.getHeaderForPdf();
          EasyLoading.dismiss();
        },
      ),
      body: documentPatientStore.urlPdf.isNotEmpty
          ? Column(
              children: [
                Observer(builder: (context) {
                  return Expanded(
                    child: const PDF(
                      swipeHorizontal: true,
                    ).fromUrl(
                      documentPatientStore.urlPdf,
                      headers: documentPatientStore.headerForPdf,
                      placeholder: (progress) {
                        return Center(
                            child: Text(
                          '$progress %',
                          style: Styles.titleItem.copyWith(
                              fontSize: 13, fontWeight: FontWeight.w600),
                        ));
                      },
                      errorWidget: (error) {
                        print('error: $error');
                        documentPatientStore.checkSigning = true;
                        return Center(
                          child: Text('Vui lòng quay lại sau !',
                              textAlign: TextAlign.center,
                              style: Styles.titleItem.copyWith(
                                  fontWeight: FontWeight.w600, fontSize: 13)),
                        );
                      },
                    ),
                  );
                }),
              ],
            )
          : Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Vui lòng quay lại sau !',
                  textAlign: TextAlign.center,
                  style: Styles.titleItem.copyWith(color: AppColors.primary),
                ),
              ),
            ),
      floatingActionButton: Observer(builder: (context) {
        return documentPatientStore.checkSigning == false
            ? FloatingActionButton(
                elevation: 0.0,
                child: const Icon(
                  Icons.edit,
                ),
                backgroundColor: AppColors.primary,
                onPressed: () async {
                  documentPatientStore.documents.add(widget.documentModel);
                  documentPatientStore.ids.add(widget.documentModel.id!);
                  documentPatientStore.documentTypeCode =
                      widget.documentModel.documentTypeCode;
                  await documentPatientStore.prepareSignDocuments(
                      documentPatientStore.ids,
                      documentPatientStore.documentTypeCode!);
                  if (documentPatientStore.prepareSign == true) {
                    Modular.to
                        .pushNamed(AppRoutes.otpdocumentPatient, arguments: {
                      'transactionId': documentPatientStore.transactionId,
                      'documents': documentPatientStore.documents,
                    });
                    Modular.to.pop();
                  }
                })
            : const SizedBox();
      }),
    );
  }
}
