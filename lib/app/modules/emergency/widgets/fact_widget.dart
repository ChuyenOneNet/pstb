import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/button_back.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../emergency_store.dart';

class FactWidget extends StatelessWidget {
  const FactWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final EmergencyStore controller;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Image.asset(
                  ImageEnum.emergency,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        l10n(context).emergency_notice,
                        textAlign: TextAlign.left,
                        style: Styles.titleItem.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          l10n(context)!.emergency_info!,
                          textAlign: TextAlign.left,
                          style: Styles.content,
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        l10n(context)!.emergency_fact!,
                        style: Styles.titleItem.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      DecoratedBox(
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.error300,
                              spreadRadius: -10,
                              blurRadius: 10,
                              offset: Offset(0, 6),
                            ),
                          ],
                        ),
                        child: AppButton(
                          title: l10n(context).emergency_call.toUpperCase(),
                          onPressed: () async {
                            await launchUrlString(
                                "tel://${controller.sosPhoneNumber}");
                            // controller.navigateTo(AppRoutes.emergencyCall);
                          },
                          iconRight: IconEnums.phoneCallWhite,
                          backgroundColor: AppColors.error300,
                          primaryColor: AppColors.error300,
                        ),
                      ),
                      AppButton(
                        title: l10n(context).emergency_tutorial.toUpperCase(),
                        onPressed: () {
                          controller.navigateTo(AppRoutes.firstAid);
                        },
                        iconRight: IconEnums.soCuu,
                        isLeftGradient: true,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const ButtonBackWidget(),
        ],
      ),
    );
  }
}
