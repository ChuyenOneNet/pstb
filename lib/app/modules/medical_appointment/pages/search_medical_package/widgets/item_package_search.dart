import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../../utils/colors.dart';
import '../../../../../../utils/format_util.dart';
import '../../../../../../utils/helper.dart';
import '../../../../../../utils/icons.dart';
import '../../../../../../utils/l10n.dart';
import '../../../../../../utils/routes.dart';
import '../../../../../../utils/styles.dart';
import '../../../../../../widgets/stateless/new_package_items/package_picture.dart';
import '../../../medical_appointment_store.dart';
import '../../medical_package/medical_package_store.dart';
import '../../medical_package_detail/models/medical_model.dart';

class ItemMedicalPackageSearch extends StatelessWidget {
  final PackageModel data;

  ItemMedicalPackageSearch({Key? key, required this.data}) : super(key: key);

  final MedicalAppointmentStore _appointmentStore =
      Modular.get<MedicalAppointmentStore>();
  final MedicalPackageStore _medicalPackageStore =
      Modular.get<MedicalPackageStore>();

  @override
  Widget build(BuildContext context) {
    return data.name == null || data.name == ''
        ? SizedBox(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                'Bạn chưa tìm kiếm gần đây.',
                style: Styles.subtitleSmallest,
              ),
            ),
          )
        : InkWell(
            onTap: () {
              _appointmentStore.setPackageDetail(data);
              _appointmentStore.addPackageToShowed(data);
              bool examAtHome = data.examAtHome ?? false;
              bool testAtHome = data.testAtHome ?? false;
              _appointmentStore.setExamAtHome(examAtHome);
              _appointmentStore.setTestAtHome(testAtHome);
              _medicalPackageStore.navigateTo(AppRoutes.medicalPackageDetail);
            },
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: widthConvert(context, 16),
                    bottom: widthConvert(context, 8),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IntrinsicHeight(
                          child: AspectRatio(
                            aspectRatio: 1.4,
                            child: PackagePicture(
                              memCacheWidth: 342,
                              memCacheHeight: 273,
                              imageUri: data.image,
                              iconUri: data.icon,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(
                              left: 16,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.name ?? '',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Styles.heading4
                                      .copyWith(color: AppColors.black),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  data.description ??
                                      l10n(context)!.medical_description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Styles.subtitleSmallest,
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                            width: 16,
                                            height: 16,
                                            child: SvgPicture.asset(
                                              IconEnums.iconPrice,
                                            )),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        data.price != null
                                            ? Text(
                                                " ${FormatUtil.formatMoney(data.price)} vnđ",
                                                style: Styles.subtitleSmallest,
                                              )
                                            : Text(
                                                " 0 vnđ",
                                                style: Styles.subtitleSmallest,
                                              ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                            width: 16,
                                            height: 16,
                                            child: SvgPicture.asset(
                                              IconEnums.iconGift,
                                            )),
                                        data.disCount != null
                                            ? Text(
                                                " ${FormatUtil.formatMoney(data.disCount)} vnđ",
                                                softWrap: true,
                                                style: Styles.subtitleSmallest,
                                              )
                                            : Text(
                                                " 0 vnđ",
                                                style: Styles.subtitleSmallest,
                                              ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(
                  height: 0,
                  color: AppColors.lightSilver,
                )
              ],
            ),
          );
  }
}
