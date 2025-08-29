import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pstb/app/models/electronic_signature_model.dart';
import 'package:pstb/app/modules/nurse_page/electronic_signature/detail_signature/detail_signature_store.dart';
import 'package:pstb/app/modules/nurse_page/electronic_signature/electronic_signature_store.dart';
import 'package:pstb/app/modules/nurse_page/electronic_signature/widgets/item_slidable_action_widget.dart';
import 'package:pstb/utils/date_time_custom_utils.dart';
import 'package:pstb/utils/main.dart';

class ItemElectronicSignatureWidget extends StatelessWidget {
  ItemElectronicSignatureWidget(
      {Key? key, required this.index, required this.model, this.enable})
      : super(key: key);
  final _checkItemController = Modular.get<ElectronicSignatureStore>();
  final _detailController = Modular.get<DetailSignatureStore>();
  final int index;
  final DocumentModel model;
  final bool? enable;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black.withOpacity(0.2)),
      ),
      // padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Slidable(
        enabled: enable ?? !_checkItemController.isShowCheckedItem,
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            Builder(builder: (context) {
              return Expanded(
                child: ItemSlidableActionWidget(
                  label: 'Xem',
                  onAction: () async {
                    EasyLoading.show();
                    await _detailController.onDetailDocuments(
                        documentModelSelected: model, indexSelected: index);
                    EasyLoading.dismiss();
                    Modular.to.pushNamed(
                      AppRoutes.detailSignaturePage,
                      arguments: {"documentModel": model},
                    );
                    Slidable.of(context)!.close();
                  },
                  backgroundColor: AppColors.primary,
                ),
              );
            }),
            Builder(builder: (context) {
              return Expanded(
                  child: ItemSlidableActionWidget(
                backgroundColor: model.signingStatus == 1
                    ? AppColors.error500
                    : AppColors.success,
                label: model.signingStatus == 0 ? 'Ký' : 'Thu hồi',
                iconSvg: model.signingStatus == 0
                    ? IconEnums.iconSign
                    : IconEnums.iconUnSign,
                onAction: () async {
                  EasyLoading.show();
                  await _checkItemController.toggleDocumentState(
                      id: model.id ?? '', index: index);
                  Slidable.of(context)!.close();
                  EasyLoading.dismiss();
                  if (_checkItemController.statusSuccess != null) {
                    Fluttertoast.showToast(
                        msg: _checkItemController.statusSuccess!);
                  }
                },
              ));
            })
          ],
        ),
        child: InkWell(
          onLongPress: () {
            if (_checkItemController.isShowCheckedItem) {
              return;
            }
            _checkItemController.onShowCheckedItem(index: index);
          },
          onTap: () async {
            if (!_checkItemController.isShowCheckedItem) {
              EasyLoading.show();
              await _detailController.onDetailDocuments(
                  documentModelSelected: model, indexSelected: index);
              EasyLoading.dismiss();
              Modular.to.pushNamed(
                AppRoutes.detailSignaturePage,
                arguments: {"documentModel": model},
              );
              return;
            }
            _checkItemController.onChangeValue(
              index: index,
            );
            if (_checkItemController.isChangeStatus ?? true) {
              Fluttertoast.showToast(msg: 'Hãy chọn cùng trạng thái');
              return;
            }
          },
          child: Observer(builder: (context) {
            return Row(
              children: [
                if (_checkItemController.isShowCheckedItem)
                  Transform.scale(
                    scale: 1.4,
                    child: Checkbox(
                      checkColor: AppColors.background,
                      value: _checkItemController.selectedDocuments[index],
                      shape: const CircleBorder(),
                      onChanged: (value) {
                        _checkItemController.onChangeValue(index: index);
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              height: 8.0,
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
                              height: 8.0,
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
                      const SizedBox(
                        width: 4,
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget itemRowElectronic(String assets, String value, TextStyle textStyle) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black.withOpacity(0.2)),
      ),
      // padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            assets,
            width: 20,
            height: 20,
            fit: BoxFit.fitWidth,
          ),
          const SizedBox(
            width: 4.0,
          ),
          Flexible(
            child: Text(
              value,
              style: textStyle,
            ),
          ),
        ],
      ),
    );
  }
}
