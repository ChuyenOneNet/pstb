import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/home/home_store.dart';
import 'package:pstb/app/user_app_store.dart';
import 'package:pstb/utils/colors.dart';
import 'package:pstb/utils/helper.dart';
import 'package:pstb/utils/icons.dart';
import 'package:pstb/utils/l10n.dart';
import 'package:pstb/utils/routes.dart';
import 'package:pstb/widgets/stateless/circle_with_icon.dart';

class ShortcutMenuStaff extends StatelessWidget {
  ShortcutMenuStaff({Key? key}) : super(key: key);
  final controller = Modular.get<HomeStore>();

  @override
  Widget build(BuildContext context) {
    final double iconSize = widthConvert(context, 45);
    return Column(
      children: [
        // FirstShortcutStaff(iconSize: iconSize, controller: controller),
        // const SizedBox(height: 16),
        SecondShortcutStaff(iconSize: iconSize, controller: controller),
      ],
    );
  }
}

class FirstShortcutStaff extends StatelessWidget {
  FirstShortcutStaff({
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
            icon: IconEnums.nurseMedical[0],
            title: 'Nhập chăm sóc',
            titleColor: AppColors.black,
            colorIcon: AppColors.primary,
            onTap: () {
              controller.isActiveInputHealthCare = true;
              Modular.to.pushNamed(AppRoutes.inputPatient);
              // Modular.to.pushNamed(AppRoutes.inputPatient);
            },
          ),
        ),
        Expanded(
          child: CircleWithIcon(
            boxSize: iconSize,
            iconSize: iconSize,
            icon: IconEnums.nurseMedical[1],
            colorIcon: AppColors.primary,
            title: 'Gửi tài liệu',
            titleColor: AppColors.black,
            onTap: () {
              controller.isActiveInputHealthCare = false;
              Modular.to.pushNamed(AppRoutes.inputPatient);
            },
          ),
        ),
        Expanded(
          child: CircleWithIcon(
              boxSize: iconSize,
              iconSize: iconSize,
              icon: IconEnums.nurseMedical[3],
              colorIcon: AppColors.primary,
              title: 'Tra cứu TTĐT',
              titleColor: AppColors.black,
              onTap: () {
                controller.isActiveInputHealthCare = true;
                Modular.to.pushNamed(AppRoutes.therapyInformation);
              }),
        ),
      ],
    );
  }
}

class SecondShortcutStaff extends StatelessWidget {
  SecondShortcutStaff({
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
        Expanded(child: SizedBox.shrink()),
        Expanded(
            child: CircleWithIcon(
              colorIcon: AppColors.primary,
              boxSize: iconSize,
              iconSize: iconSize,
              icon: IconEnums.signDoctorIcon,
              title: 'Ký NVYT',
              titleColor: AppColors.black,
              onTap: () {
                Modular.to.pushNamed(AppRoutes.electronicSignature,
                    arguments: {'userName': null, 'rollCode': null});
              },
            ),
            flex: 2),

        Expanded(
          flex: 2,
          child: CircleWithIcon(
            boxSize: iconSize,
            iconSize: iconSize,
            colorIcon: AppColors.primary,
            icon: IconEnums.calendarDoctorIcon,
            title: 'Lịch hẹn',
            titleColor: AppColors.black,
            onTap: () {
              Modular.to.pushNamed(AppRoutes.doctorAppointmentModule);
            },
          ),
        ),

        Expanded(
          child: CircleWithIcon(
            boxSize: iconSize,
            iconSize: iconSize,
            colorIcon: AppColors.primary,
            icon: IconEnums.information,
            title: 'Thông tin',
            titleColor: AppColors.black,
            onTap: () {
              Modular.to.pushNamed(AppRoutes.inforPage);
            },
          ),
          flex: 2,
        ),
        // Expanded(
        //   child: CircleWithIcon(
        //     boxSize: iconSize,
        //     iconSize: iconSize,
        //     colorIcon: AppColors.primary,
        //     icon: IconEnums.iconPerformMedicine,
        //     title: 'Thực hiện thuốc',
        //     titleColor: AppColors.black,
        //     onTap: () {
        //       Modular.to.pushNamed(AppRoutes.perFormMedicinePage);
        //     },
        //   ),
        //   flex: 2,
        // ),
        Expanded(child: SizedBox.shrink()),
      ],
    );
  }
}
