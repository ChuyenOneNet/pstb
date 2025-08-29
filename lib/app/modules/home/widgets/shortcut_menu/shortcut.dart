import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/home/home_store.dart';
import 'package:pstb/app/user_app_store.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';
import '../../../medical_appointment/medical_appointment_store.dart';

class ShortcutMenu extends StatelessWidget {
  ShortcutMenu({
    Key? key,
  }) : super(key: key);
  final controller = Modular.get<HomeStore>();

  @override
  Widget build(BuildContext context) {
    final double iconSize = widthConvert(context, 45);
    return Column(
      children: [
        FirstRowShortcut(iconSize: iconSize, controller: controller),
        const SizedBox(height: 16),
        SecondRowShortcut(iconSize: iconSize, controller: controller),
      ],
    );
  }
}

class FirstRowShortcut extends StatelessWidget {
  FirstRowShortcut({
    Key? key,
    required this.iconSize,
    required this.controller,
  }) : super(key: key);
  final double iconSize;
  final HomeStore controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: CircleWithIcon(
            boxSize: iconSize,
            iconSize: iconSize,
            icon: IconEnums.nCalendar,
            title: 'Đặt lịch',
            colorIcon: AppColors.primary,
            onTap: () {
              final MedicalAppointmentStore _appointmentStore =
                  Modular.get<MedicalAppointmentStore>();
              _appointmentStore.changeSearchDataAtHome(false);
              Modular.to.pushNamed(AppRoutes.medicalPackagePage);
            },
          ),
        ),
        Expanded(
          child: CircleWithIcon(
            boxSize: iconSize,
            iconSize: iconSize,
            icon: IconEnums.electronicHealthRecords,
            colorIcon: AppColors.primary,
            title: 'Hồ sơ sức khoẻ',
            onTap: () {
              if (controller.isLogin) {
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
        Expanded(
          child: CircleWithIcon(
            colorIcon: AppColors.primary,
            boxSize: iconSize,
            iconSize: iconSize,
            icon: IconEnums.news,
            title: 'Tin tức',
            onTap: () {
              controller.navigateToPage(
                  routerName: AppRoutes.news, arguments: false);
            },
          ),
        ),
      ],
    );
  }
}

class SecondRowShortcut extends StatelessWidget {
  final UserAppStore _userAppStore = Modular.get<UserAppStore>();

  SecondRowShortcut({
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
        Expanded(
          child: CircleWithIcon(
            boxSize: iconSize,
            iconSize: iconSize,
            icon: IconEnums.certificate,
            title: 'Ký BN',
            colorIcon: AppColors.primary,
            onTap: () {
              if (controller.isLogin) {
                controller.navigateToPage(
                    routerName: AppRoutes.documentPatientModule,
                    arguments: false);
              } else {
                Modular.to.pushNamed(AppRoutes.authGuardPage, arguments: {
                  "isNotFromBottomNav": true,
                  "title": 'Quản lý tài liệu ký số',
                });
              }
            },
          ),
        ),
      ],
    );
  }
}
