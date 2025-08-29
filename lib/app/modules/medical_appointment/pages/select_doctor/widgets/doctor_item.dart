import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pstb/utils/icon_tabbar.dart';
import 'package:pstb/utils/main.dart';

class DoctorItemWidget extends StatelessWidget {
  final String? name, avatar;
  final String? position;
  // final SelectDoctorStore controller;
  const DoctorItemWidget({
    Key? key,
    this.name,
    this.avatar,
    this.position,
    // required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          // item left side
          Column(
            children: [
              // avatar
              Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      right: widthConvert(context, 16),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      height: widthConvert(context, 64),
                      width: widthConvert(context, 64),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(64),
                        color: AppColors.background,
                      ),
                      child: avatar != null
                          ? const SizedBox()
                          : Center(
                              child: SvgPicture.asset(
                                TabIcon.userInactive,
                                color: AppColors.background,
                                height: widthConvert(context, 24),
                                width: widthConvert(context, 24),
                              ),
                            ),
                    ),
                  ),
                  avatar == null
                      ? const SizedBox()
                      : Positioned(
                          child: Container(
                            height: widthConvert(context, 64),
                            width: widthConvert(context, 64),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(64),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(14),
                              child: CachedNetworkImage(
                                imageUrl: avatar ?? '',
                                placeholder: (context, url) => const SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: Center(
                                        child: CircularProgressIndicator(
                                      strokeWidth: 1.0,
                                    ))),
                                errorWidget: (context, url, error) =>
                                    Image.asset(ImageEnum.avatarDefault),
                              ),
                            ),
                          ),
                          bottom: 0,
                          left: 0,
                        ),
                ],
              ),
            ],
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    l10n(context)!.select_doctor_dr! + name!,
                    style: Styles.titleItem.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    position!,
                    style: Styles.content,
                  )
                ]),
              ],
            ),
          ),
          const Icon(
            Icons.keyboard_arrow_right,
            size: 28,
            color: AppColors.lightSilver,
          )
        ],
      ),
    );
  }
}
