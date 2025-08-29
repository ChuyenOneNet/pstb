import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateful/stateful_widget.dart';

import '../../../app_store.dart';

enum SignUpProcessEnum { Step1, Step2, Step3 }

class SignUpProcess extends StatelessWidget {
  final SignUpProcessEnum currentProcess;
  final AppStore _store = Modular.get<AppStore>();
  final Function? onBackStep3;

  SignUpProcess({
    Key? key,
    this.currentProcess = SignUpProcessEnum.Step1,
    this.onBackStep3,
  }) : super(key: key);

  List<Widget> handleProcess(SignUpProcessEnum step, BuildContext context) {
    bool enableOTP =
        //true;
        _store.enableSignUpOTP;
    print(enableOTP);
    switch (step) {
      case SignUpProcessEnum.Step1:
        return [
          _buildOutlineCircle(AppColors.primary, null, AppColors.grayLight,
              l10n(context)!.sign_up_step1),
          _buildLineProcess(AppColors.grayLight),
          enableOTP
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildOutlineCircle(
                        AppColors.grayLight,
                        AppColors.grayLight,
                        AppColors.grayLight,
                        l10n(context)!.sign_up_step2),
                    //_buildLineProcess(AppColors.grayLight),
                    _buildOutlineCircle(
                        AppColors.grayLight,
                        AppColors.grayLight,
                        null,
                        l10n(context)!.sign_up_step3),
                  ],
                )
              : Row(
                  children: [
                    _buildOutlineCircle(
                        AppColors.grayLight,
                        AppColors.grayLight,
                        null,
                        l10n(context)!.sign_up_step2),
                  ],
                )
        ];
      case SignUpProcessEnum.Step2:
        return [
          _buildCheckCircle(
              null, AppColors.primary, l10n(context)!.sign_up_step1),
          _buildLineProcess(AppColors.primary),
          _buildOutlineCircle(AppColors.primary, AppColors.primary,
              AppColors.grayLight, l10n(context)!.sign_up_step2),
          _buildLineProcess(AppColors.grayLight),
          _buildOutlineCircle(AppColors.grayLight, AppColors.grayLight, null,
              l10n(context)!.sign_up_step3),
        ];
      default:
        return [
          _buildCheckCircle(
              null, AppColors.primary, l10n(context)!.sign_up_step1),
          if (enableOTP)
            _buildCheckCircle(
              AppColors.primary,
              AppColors.primary,
              l10n(context)!.sign_up_step2,
            ),
          _buildLineProcess(AppColors.primary),
          //_buildLineProcess(AppColors.primary),
          _buildOutlineCircle(
              AppColors.primary,
              AppColors.primary,
              null,
              enableOTP
                  ? l10n(context)!.sign_up_step3
                  : l10n(context)!.sign_up_step2),
          // enableOTP
          //     ? Row(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           _buildOutlineCircle(AppColors.primary, AppColors.primary,
          //               null, l10n(context)!.sign_up_step3),
          //         ],
          //       )
          //     : _buildOutlineCircle(AppColors.primary, AppColors.primary, null,
          //         l10n(context)!.sign_up_step2),
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24.0),
      // padding: EdgeInsets.only(right: widthConvert(context, 20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildBackBtn(context),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: handleProcess(currentProcess, context),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBackBtn(BuildContext context) {
    return TouchableOpacity(
      child: Column(
        children: [
          const Icon(
            Icons.arrow_back_ios,
            size: 24,
            color: AppColors.grayLight,
          ),
          Text(
            "",
            style: Styles.subtitleSmall
                .copyWith(color: AppColors.primary, height: 20 / 12),
          )
        ],
      ),
      onTap: () {
        if (currentProcess == SignUpProcessEnum.Step3) {
          onBackStep3 != null
              ? onBackStep3!()
              : Modular.to
                  .popUntil(ModalRoute.withName("${AppRoutes.signup}/"));
        } else {
          Modular.to.pop();
        }
      },
    );
  }

  Widget _buildCheckCircle(
      Color? leftCrossbarColor, Color? rightCrossbarColor, String text) {
    return SizedBox(
      width: 60,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: leftCrossbarColor != null
                    ? Container(
                        color: leftCrossbarColor,
                        height: 2,
                      )
                    : const SizedBox(),
              ),
              Container(
                width: 24,
                height: 24,
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 15,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              Expanded(
                child: rightCrossbarColor != null
                    ? Container(
                        color: rightCrossbarColor,
                        height: 2,
                      )
                    : const SizedBox(),
              ),
            ],
          ),
          Text(
            text,
            style: Styles.subtitleSmall
                .copyWith(color: AppColors.primary, height: 20 / 12),
          )
        ],
      ),
    );
  }

  Widget _buildOutlineCircle(Color outlineColor, Color? leftCrossbarColor,
      Color? rightCrossbarColor, String text) {
    return SizedBox(
      width: 60,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: leftCrossbarColor != null
                    ? Container(
                        color: leftCrossbarColor,
                        height: 2,
                      )
                    : const SizedBox(),
              ),
              Container(
                width: 24,
                height: 24,
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: outlineColor, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: outlineColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              Expanded(
                  child: rightCrossbarColor != null
                      ? Container(
                          color: rightCrossbarColor,
                          height: 2,
                        )
                      : const SizedBox()),
            ],
          ),
          Text(
            text,
            style: Styles.subtitleSmall
                .copyWith(color: outlineColor, height: 20 / 12),
          )
        ],
      ),
    );
  }

  // Widget _buildLineProcess(Color color) {
  //   return SizedBox(
  //     width: _store.enableSignUpOTP ? null : 60,
  //     child: Align(
  //       child: Column(
  //         children: [
  //           Container(
  //             color: color,
  //             height: 2,
  //           ),
  //           Text(
  //             '',
  //             style: Styles.subtitleSmall.copyWith(height: 20 / 12),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }
  Widget _buildLineProcess(Color color) {
    return Expanded(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            color: color,
            height: 2,
            width: _store.enableSignUpOTP ? 60 : null,
          ),
          Text(
            '',
            style: Styles.subtitleSmall.copyWith(height: 20 / 12 + 0.08),
          )
        ],
      ),
    );
  }
}
