import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pstb/app/modules/ehr_page/ehr_store.dart';

import '../../../../../utils/api_url.dart';
import '../../../../../utils/colors.dart';
import '../../../../../utils/constants.dart';
import '../../../../../utils/date_time_custom_utils.dart';
import '../../../../../utils/icons.dart';
import '../../../../../utils/routes.dart';
import '../../../../../utils/styles.dart';
import '../../../../models/electronic_signature_model.dart';
import '../../../nurse_page/electronic_signature/widgets/item_slidable_action_widget.dart';

class ItemEhrSignature extends StatelessWidget {
  final DocumentModel model;
  final bool? enabled;

  ItemEhrSignature({
    Key? key,
    required this.model,
    this.enabled,
  }) : super(key: key);

  final EHRStore ehrStore = Modular.get<EHRStore>();

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
        enabled: enabled ?? !ehrStore.isShowCheckedItem,
        endActionPane: model.signingStatus == 0
            ? ActionPane(
                motion: const ScrollMotion(),
                children: [
                  Builder(builder: (context) {
                    return Expanded(
                      child: ItemSlidableActionWidget(
                        label: 'Xem',
                        onAction: () {
                          ehrStore.signingStatus = model.signingStatus;
                          if (model.signingStatus == 0) {
                            ehrStore.checkSigning = false;
                          } else {
                            ehrStore.checkSigning = true;
                          }
                          ehrStore.titleDetailPdf = model.name ?? "";
                          ehrStore.pageSolution = 2;
                          ehrStore.urlPdf =
                              '${ApiUrl.baseUrl}${ApiUrl.getPDFDocuments}/${model.id}';
                          Modular.to
                              .pushNamed(AppRoutes.pdfIndication, arguments: {
                            "documentModel": model,
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
                          await ehrStore.prepareSignPatient(
                              model.id!, model.documentTypeCode!);
                          if (ehrStore.prepareSign == true) {
                            Modular.to.pushNamed(AppRoutes.otpSignaturePatient,
                                arguments: {
                                  'transactionId': ehrStore.transactionId,
                                  'documentModel': model,
                                });
                          } else {
                            Fluttertoast.showToast(
                                msg: 'Lỗi hệ thống. Vui lòng quay lại sau.',
                                backgroundColor: AppColors.error500);
                          }
                          Slidable.of(context)!.close();
                        },
                      ),
                    );
                  })
                ],
              )
            : null,
        child: InkWell(
          onLongPress: () {},
          onTap: () {
            ehrStore.signingStatus = model.signingStatus;
            if (model.signingStatus == 1) {
              ehrStore.checkSigning = false;
            } else {
              ehrStore.checkSigning = true;
            }
            ehrStore.titleDetailPdf = model.name ?? "";
            ehrStore.pageSolution = 2;
            ehrStore.urlPdf =
                '${ApiUrl.baseUrl}${ApiUrl.getPDFDocuments}/${model.id}';
            Modular.to.pushNamed(AppRoutes.pdfIndication, arguments: {
              "documentModel": model,
            });
          },
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            model.name ?? '',
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
                                    borderRadius: BorderRadius.circular(15)),
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
                          'Ngày tạo: ${DateTimeCustomUtils.parseDateIso(dateTime: model.createdDate)}',
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
      ),
    );
  }
}
