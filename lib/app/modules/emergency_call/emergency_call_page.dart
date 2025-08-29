import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/emergency_call/emergency_call_store.dart';
import 'package:pstb/utils/main.dart';

import 'widgets/call_animated.dart';

class EmergencyCallPage extends StatefulWidget {
  final String title;
  const EmergencyCallPage({this.title = "EmergencyCallPage", Key? key})
      : super(key: key);

  @override
  _EmergencyCallPageState createState() => _EmergencyCallPageState();
}

class _EmergencyCallPageState
    extends ModularState<EmergencyCallPage, EmergencyCallStore> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: heightConvert(context, 129),
            ),
            child: const Center(
              child: SpriteDemo(),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: heightConvert(context, 34),
            ),
            child: Text(
              l10n(context).emergency_call_connecting!,
              style: Styles.paragraph.copyWith(
                color: AppColors.neutral700,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: heightConvert(context, 99),
                  left: widthConvert(context, 25),
                  right: widthConvert(context, 25),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n(context)!.emergency_call_description!,
                      style: Styles.paragraph.copyWith(
                        color: AppColors.neutral700,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: heightConvert(context, 8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            children: [
                              Text(
                                l10n(context)!.emergency_call_1!,
                                style: Styles.bodyBold.copyWith(
                                  color: AppColors.error500,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.start,
                              )
                            ],
                          ),
                          Wrap(
                            children: [
                              Text(
                                l10n(context).emergency_call_2!,
                                style: Styles.bodyBold.copyWith(
                                  color: AppColors.error500,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.start,
                              )
                            ],
                          ),
                          Wrap(
                            children: [
                              Text(
                                l10n(context).emergency_call_3!,
                                style: Styles.bodyBold.copyWith(
                                  color: AppColors.error500,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.start,
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
