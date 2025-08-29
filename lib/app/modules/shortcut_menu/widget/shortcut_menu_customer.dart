import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/home/home_store.dart';
import 'package:pstb/app/modules/medical_appointment/medical_appointment_store.dart';
import 'package:pstb/app/user_app_store.dart';
import 'package:pstb/utils/colors.dart';
import 'package:pstb/utils/helper.dart';
import 'package:pstb/utils/icons.dart';
import 'package:pstb/utils/l10n.dart';
import 'package:pstb/utils/routes.dart';
import 'package:pstb/widgets/stateless/circle_with_icon.dart';

import '../../booking_v2/booking_home_page.dart';

class ShortcutMenuCustomer extends StatelessWidget {
  ShortcutMenuCustomer({Key? key}) : super(key: key);
  final controller = Modular.get<HomeStore>();

  @override
  Widget build(BuildContext context) {
    final double iconSize = widthConvert(context, 45);
    return Column(
      children: [
        FirstShortcutCustomer(iconSize: iconSize, controller: controller),
        const SizedBox(height: 16),
        SecondShortcutCustomer(iconSize: iconSize, controller: controller),
      ],
    );
  }
}

class FirstShortcutCustomer extends StatelessWidget {
  FirstShortcutCustomer({
    Key? key,
    required this.iconSize,
    required this.controller,
  }) : super(key: key);
  final double iconSize;
  final HomeStore controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Expanded(
        //   child: CircleWithIcon(
        //     boxSize: iconSize,
        //     iconSize: iconSize,
        //     icon: IconEnums.electronicHealthRecords,
        //     colorIcon: AppColors.primary,
        //     title: 'Hồ sơ sức khoẻ',
        //     onTap: () {
        //       if (controller.isLogin) {
        //         controller.navigateToPage(
        //             routerName: AppRoutes.ehrModule, arguments: false);
        //       } else {
        //         Modular.to.pushNamed(AppRoutes.authGuardPage, arguments: {
        //           "isNotFromBottomNav": true,
        //           "title": 'Hồ sơ sức khoẻ điện tử',
        //         });
        //       }
        //     },
        //   ),
        // ),
        Expanded(
          child: CircleWithIcon(
            boxSize: iconSize,
            iconSize: iconSize,
            icon: IconEnums.nCalendar,
            title: 'Đăng ký khám',
            colorIcon: AppColors.primary,
            onTap: () {
              if (controller.isLogin) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookingPatientScreen(),
                    ));
              } else {
                Modular.to.pushNamed(AppRoutes.authGuardPage, arguments: {
                  "isNotFromBottomNav": true,
                  "title": 'Đăng ký khám',
                });
              }
              // final MedicalAppointmentStore _appointmentStore =
              //     Modular.get<MedicalAppointmentStore>();
              // _appointmentStore.changeSearchDataAtHome(false);
              // Modular.to.pushNamed(AppRoutes.medicalPackagePage);
            },
          ),
        ),
        //if (controller.isLogin) ...[
        //Expanded(child: SizedBox.shrink()),
        Expanded(
          child: CircleWithIcon(
            boxSize: iconSize,
            iconSize: iconSize,
            icon: IconEnums.electronicHealthRecords,
            colorIcon: AppColors.primary,
            title: 'Hồ sơ sức khoẻ',
            onTap: () {
              if (controller.isLogin) {
                // Modular.to.pushNamed(
                //   AppRoutes.businessModule,
                // );
                // controller.navigateToPage(
                //     routerName: AppRoutes.businessModule, arguments: false);
                controller.navigateToPage(
                    routerName: AppRoutes.ehrModule, arguments: false);
              } else {
                Modular.to.pushNamed(AppRoutes.authGuardPage, arguments: {
                  "isNotFromBottomNav": true,
                  "title": 'Hồ sơ sức khoẻ điện tử',
                });
              }
            },
          ),
        ),
        //],

        // Expanded(child: SizedBox.shrink()),
        Expanded(
          flex: 1,
          child: CircleWithIcon(
            boxSize: iconSize,
            iconSize: iconSize,
            colorIcon: AppColors.primary,
            icon: IconEnums.news,
            title: 'Tin tức',
            onTap: () {
              controller.navigateToPage(
                  routerName: AppRoutes.news, arguments: false);
            },
          ),
        ),
        //Expanded(child: SizedBox.shrink()),
        // Expanded(
        //   flex: 1,
        //   child: CircleWithIcon(
        //     boxSize: iconSize,
        //     iconSize: iconSize,
        //     colorIcon: AppColors.error700,
        //     icon: IconEnums.nSos2,
        //     title: l10n(context).home_shortcut_emergency,
        //     onTap: () {
        //       controller.navigateToPage(
        //           routerName: AppRoutes.emergency, arguments: false);
        //     },
        //   ),
        // ),
        //Expanded(child: SizedBox.shrink())
      ],
    );
  }
}

class SecondShortcutCustomer extends StatelessWidget {
  final UserAppStore _userAppStore = Modular.get<UserAppStore>();

  SecondShortcutCustomer({
    Key? key,
    required this.iconSize,
    required this.controller,
  }) : super(key: key);
  final double iconSize;
  final HomeStore controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: CircleWithIcon(
              boxSize: iconSize,
              iconSize: iconSize,
              icon: IconEnums.iconNurse,
              colorIcon: AppColors.primary,
              title: 'Tra cứu',
              onTap: () {
                // if (controller.isLogin) {
                //   return Modular.to.pushNamed(AppRoutes.commingSoon);
                // } else {
                //    return Modular.to.pushNamed(AppRoutes.authGuardPage);
                // }
                _userAppStore.setVisibleSelectDoctor(false);
                controller.navigateToPage(
                    routerName: AppRoutes.specificPatient, arguments: false);
              }),
        ),
        Expanded(
          child: CircleWithIcon(
            boxSize: iconSize,
            iconSize: iconSize,
            colorIcon: AppColors.error700,
            icon: IconEnums.nSos2,
            title: l10n(context).home_shortcut_emergency,
            onTap: () {
              controller.navigateToPage(
                  routerName: AppRoutes.emergency, arguments: false);
            },
          ),
        ),
        // Expanded(
        //   child: CircleWithIcon(
        //     boxSize: iconSize,
        //     iconSize: iconSize,
        //     icon: IconEnums.certificate,
        //     title: 'Ký BN',
        //     colorIcon: AppColors.primary,
        //     onTap: () {
        //       if (controller.isLogin) {
        //         controller.navigateToPage(
        //             routerName: AppRoutes.documentPatientModule,
        //             arguments: false);
        //       } else {
        //         Modular.to.pushNamed(AppRoutes.authGuardPage, arguments: {
        //           "isNotFromBottomNav": true,
        //           "title": 'Quản lý tài liệu ký số',
        //         });
        //       }
        //     },
        //   ),
        // ),
      ],
    );
  }
}
