import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:pstb/utils/main.dart';

import '../../../user_app_store.dart';

class ScheduleDetailBasic extends StatelessWidget {
  final UserAppStore _appStore = Modular.get<UserAppStore>();
  final String title, doctor, username;
  final bool? isUpcoming;

  ScheduleDetailBasic({
    Key? key,
    required this.username,
    required this.title,
    required this.doctor,
    this.isUpcoming,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: widthConvert(context, 12),
      ),
      child: Container(
        padding: EdgeInsets.only(
          top: heightConvert(context, 16),
          bottom: heightConvert(context, 16),
        ),
        decoration: const BoxDecoration(
          color: AppColors.background,
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: AppColors.neutral200,
            ),
          ),
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              // const ImageLeft(),
              BasicInfo(
                username: _appStore.getUserName,
                title: title,
                doctor: doctor,
                isUpcoming: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ImageLeft extends StatelessWidget {
  const ImageLeft({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: Styles.cardShadow.copyWith(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              width: 4,
              color: AppColors.background,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              ImageEnum.batTinh,
              height: widthConvert(context, 75),
              width: widthConvert(context, 75),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(8),
                topLeft: Radius.circular(8),
              ),
            ),
            child: SvgPicture.asset(IconEnums.medicalStethoscope),
          ),
        )
      ],
    );
  }
}

class BasicInfo extends StatelessWidget {
  final String? username;
  final String? title;
  final String? doctor;
  final DateTime? timeGetSample;
  final String? status;
  final bool? isUpcoming;

  const BasicInfo({
    Key? key,
    this.username,
    this.title,
    this.doctor,
    this.status,
    this.isUpcoming,
    this.timeGetSample,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          username == null || username!.isEmpty
              ? const SizedBox()
              : Text(
                  username!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: Styles.content.copyWith(
                    color: AppColors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
          doctor == null || doctor!.isEmpty
              ? const SizedBox()
              : Column(
                  children: [
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      l10n(context)!.select_doctor_dr! + doctor,
                      style: Styles.titleItem.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 13),
                    ),
                  ],
                ),
          const SizedBox(
            height: 4,
          ),
          title == null
              ? const SizedBox()
              : Text(
                  title!,
                  style: Styles.content,
                ),
          timeGetSample == null
              ? const SizedBox()
              : Column(
                  children: [
                    const SizedBox(
                      height: 4,
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Thời gian lấy mẫu: ',
                        style: Styles.content.copyWith(color: AppColors.black),
                        children: [
                          TextSpan(
                            text: DateFormat(
                                    DateTimeFormatPattern.hh_mm_NGAY_dd_MM_yyyy)
                                .format(timeGetSample!.toLocal()),
                            style: Styles.content
                                .copyWith(color: AppColors.primary),
                          )
                        ],
                      ),
                    ),
                    // Text(
                    //   'Thời gian lấy mãu: ' +
                    //       DateFormat(
                    //               DateTimeFormatPattern.hh_mm_NGAY_dd_MM_yyyy)
                    //           .format(timeGetSample!.toLocal()),
                    //   style: Styles.subtitleSmallest,
                    // ),
                  ],
                ),
          const SizedBox(
            height: 4,
          ),
          status == null
              ? const SizedBox()
              : Row(
                  children: [
                    Text(
                      'Trạng thái: ',
                      style: Styles.content.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                    Text(
                      status!,
                      style: Styles.content.copyWith(
                        color: Colors.red,
                      ),
                    ),
                  ],
                )
        ],
      ),
    );
  }
}
