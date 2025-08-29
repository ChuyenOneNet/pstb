import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pstb/app/modules/manage_document_patient/document_patient_store.dart';

import '../../../../utils/api_url.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/date_time_custom_utils.dart';
import '../../../../utils/icons.dart';
import '../../../../utils/routes.dart';
import '../../../../utils/styles.dart';
import '../../../models/electronic_signature_model.dart';
import '../../nurse_page/electronic_signature/widgets/item_slidable_action_widget.dart';

class ItemDocument extends StatelessWidget {
  final int index;
  final DocumentModel model;
  final bool? enabled;

  ItemDocument(
      {Key? key, required this.index, required this.model, this.enabled})
      : super(key: key);

  final DocumentPatientStore documentPatientStore =
      Modular.get<DocumentPatientStore>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black.withOpacity(0.2)),
      ),
      child: Slidable(
        enabled: enabled ?? !documentPatientStore.isShowCheckedItem,
        endActionPane: model.signingStatus == 0
            ? ActionPane(
                motion: const ScrollMotion(),
                children: [
                  Builder(builder: (context) {
                    return Expanded(
                      child: ItemSlidableActionWidget(
                        label: 'Xem',
                        onAction: () {
                          documentPatientStore.signingStatus =
                              model.signingStatus;
                          if (model.signingStatus == 0) {
                            documentPatientStore.checkSigning = false;
                          } else {
                            documentPatientStore.checkSigning = true;
                          }
                          documentPatientStore.urlPdf =
                              '${ApiUrl.baseUrl}${ApiUrl.getPatientPDFDocument}/${model.id}';
                          Modular.to.pushNamed(AppRoutes.pdfDocumentPatient,
                              arguments: {
                                "documentModel": model,
                                "index": index,
                              });
                          Slidable.of(context)!.close();
                        },
                        backgroundColor: AppColors.primary,
                      ),
                    );
                  }),
                  Builder(builder: (context) {
                    return Expanded(
                      child: ItemSlidableActionWidget(
                        backgroundColor: AppColors.success,
                        label: 'Ký',
                        iconSvg: IconEnums.iconSign,
                        onAction: () async {
                          documentPatientStore.documents.add(model);
                          documentPatientStore.ids.add(model.id!);
                          documentPatientStore.documentTypeCode =
                              model.documentTypeCode;
                          await documentPatientStore.prepareSignDocuments(
                              documentPatientStore.ids,
                              documentPatientStore.documentTypeCode!);
                          if (documentPatientStore.prepareSign == true) {
                            Modular.to.pushNamed(AppRoutes.otpdocumentPatient,
                                arguments: {
                                  'transactionId':
                                      documentPatientStore.transactionId,
                                  'documents': documentPatientStore.documents,
                                });
                          } else {
                            // Fluttertoast.showToast(
                            //     msg: 'Lỗi hệ thống. Vui lòng quay lại sau.',
                            //     backgroundColor: AppColors.error500);
                          }
                          Slidable.of(context)!.close();
                        },
                      ),
                    );
                  })
                ],
              )
            : null,
        child: Column(
          children: [
            InkWell(
              onLongPress: model.signingStatus == 0
                  ? () {
                      documentPatientStore.isShowCheckedItem = true;
                      documentPatientStore.documentTypeCode =
                          documentPatientStore.listESM[index].documentTypeCode;
                      documentPatientStore.selectedDocuments[index] = true;
                      documentPatientStore.documents.add(model);
                      documentPatientStore.ids.add(model.id!);
                    }
                  : null,
              onTap: () {
                documentPatientStore.signingStatus = model.signingStatus;
                if (model.signingStatus == 0) {
                  documentPatientStore.checkSigning = false;
                } else {
                  documentPatientStore.checkSigning = true;
                }
                documentPatientStore.urlPdf =
                    '${ApiUrl.baseUrl}${ApiUrl.getPatientPDFDocument}/${model.id}';
                Modular.to.pushNamed(AppRoutes.pdfDocumentPatient, arguments: {
                  "documentModel": model,
                  "index": index,
                });
              },
              child: Row(
                children: [
                  if (documentPatientStore.isShowCheckedItem &&
                      documentPatientStore.listESM[index].signingStatus == 0 &&
                      documentPatientStore.listESM[index].documentTypeCode ==
                          documentPatientStore.documentTypeCode)
                    Transform.scale(
                      scale: 1.4,
                      child: Checkbox(
                        checkColor: AppColors.background,
                        value: documentPatientStore.selectedDocuments[index],
                        shape: const CircleBorder(),
                        onChanged: (value) {
                          documentPatientStore.onChangeValue(index);
                        },
                      ),
                    ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      model.name ?? "",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Styles.titleItem,
                                    ),
                                  ),
                                  model.signingStatus == 0
                                      ? const SizedBox()
                                      : Container(
                                          padding: const EdgeInsets.all(4.0),
                                          width: 25,
                                          height: 25,
                                          decoration: BoxDecoration(
                                              color: AppColors.greenText,
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: SvgPicture.asset(
                                            IconEnums.check,
                                            color: Colors.white,
                                          )),
                                ],
                              ),
                              const SizedBox(
                                height: 4.0,
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    IconEnums.human,
                                    width: 18,
                                    height: 18,
                                    fit: BoxFit.fitWidth,
                                  ),
                                  const SizedBox(
                                    width: 4.0,
                                  ),
                                  Text(
                                    model.patientName ?? '',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Styles.content,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 4.0,
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    IconEnums.iconClockSearch,
                                    width: 18,
                                    height: 18,
                                    fit: BoxFit.fitWidth,
                                  ),
                                  const SizedBox(
                                    width: 4.0,
                                  ),
                                  Text(
                                    DateTimeCustomUtils.parseDateIso(
                                        dateTime: model.createdDate),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Styles.content,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemRowElectronic(String assets, String value, TextStyle textStyle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        assets.isNotEmpty
            ? SvgPicture.asset(
                assets,
                width: 15,
                height: 15,
                fit: BoxFit.fitWidth,
                color: const Color(0xFF053BA2),
              )
            : const SizedBox(
                width: 15,
              ),
        const SizedBox(
          width: 4.0,
        ),
        Flexible(
          child: Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textStyle,
          ),
        ),
      ],
    );
  }
}
