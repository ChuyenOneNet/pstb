import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pstb/utils/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../app_store.dart';
import '../../../models/medical_unit/hospital_unit_model.dart';
import '../detail_hospital/detail_hospital_store.dart';
import '../selection_hospital_store.dart';

class ItemHospitalWidget extends StatelessWidget {
  ItemHospitalWidget({
    Key? key,
    required this.hospitalModel,
    required this.store,
  }) : super(key: key);
  final HospitalModel hospitalModel;
  final SelectionHospitalStore store;
  final DetailHospitalStore detailHospitalStore =
      Modular.get<DetailHospitalStore>();
  final AppStore _appStore = Modular.get<AppStore>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await _appStore.getLandingUnit(hospitalModel.id!);
        Modular.to.pushNamed(AppRoutes.detailHospitalPage, arguments: {
          "hospitalModel": hospitalModel,
        });
      },
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.lightSilver),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: CachedNetworkImage(
                      imageUrl: hospitalModel.image ?? '',
                      placeholder: (context, url) => const Center(
                        child: SizedBox(
                            width: 30,
                            height: 30,
                            child: Center(child: CircularProgressIndicator())),
                      ),
                      errorWidget: (context, url, error) => SizedBox(
                        width: 80,
                        height: 80,
                        child: Center(
                          child: Image.asset(ImageEnum.hospitalDefault),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    hospitalModel.shortName ?? '',
                    overflow: TextOverflow.ellipsis,
                    style: Styles.titleItem,
                  ),
                ),
                Row(
                  children: [
                    Text('Giờ mở cửa: ',
                        overflow: TextOverflow.ellipsis,
                        style: Styles.content.copyWith(
                          fontSize: 12.0,
                        )),
                    Text(
                        DateFormat(DateTimeFormatPattern.formatHHmm)
                            .format(hospitalModel.OpenedTime!.toLocal()),
                        overflow: TextOverflow.ellipsis,
                        style: Styles.content.copyWith(
                          fontSize: 12.0,
                        )),
                  ],
                ),
                Row(
                  children: [
                    Text('Giờ đóng cửa: ',
                        overflow: TextOverflow.ellipsis,
                        style: Styles.content.copyWith(
                          fontSize: 12.0,
                        )),
                    Text(
                        DateFormat(DateTimeFormatPattern.formatHHmm)
                            .format(hospitalModel.ClosedTime!.toLocal()),
                        overflow: TextOverflow.ellipsis,
                        style: Styles.content.copyWith(
                          fontSize: 12.0,
                        )),
                  ],
                ),
                (hospitalModel.aveRate == null || hospitalModel.aveRate == 0)
                    ? Text('Chưa có đánh giá và nhận xét',
                        style: Styles.content.copyWith(
                          fontSize: 12.0,
                        ))
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text('Đánh giá: ',
                                  style: Styles.content.copyWith(
                                    fontSize: 12.0,
                                  )),
                              Row(
                                children: [
                                  Text('${hospitalModel.aveRate}',
                                      style: Styles.content.copyWith(
                                        color: AppColors.primary,
                                        fontSize: 12.0,
                                      )),
                                  const Icon(
                                    Icons.star,
                                    size: 12,
                                    color: Colors.orange,
                                  )
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text('Nhận xét: ',
                                  style: Styles.content.copyWith(
                                    fontSize: 12.0,
                                  )),
                              Text('${hospitalModel.reviewCounter ?? 0}',
                                  style: Styles.content.copyWith(
                                    color: AppColors.primary,
                                    fontSize: 12.0,
                                  )),
                            ],
                          ),
                        ],
                      ),
              ],
            ),
          ),
          !hospitalModel.status
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.only(top: 8.0, right: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Container(
                              color: AppColors.primary,
                              child: SvgPicture.asset(
                                IconEnums.check,
                                color: AppColors.background,
                              ))),
                    ],
                  ),
                )
        ],
      ),
    );
  }
}
