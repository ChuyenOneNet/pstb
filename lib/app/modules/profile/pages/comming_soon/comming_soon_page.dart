import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateful/stateful_widget.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';

class ComingSoonPage extends StatelessWidget {
  const ComingSoonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: TouchableOpacity(
          onTap: () => Modular.to.pop(),
          // Modular.to.popUntil(ModalRoute.withName("${AppRoutes.main}/")),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.primary,
                  maxRadius: 64,
                  child: Image.asset(
                    ImageEnum.logopstbColor,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  l10n(context)!.coming_soon_title!.toString().toUpperCase(),
                  style: Styles.content.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  l10n(context)!.coming_soon_description!,
                  style: Styles.content.copyWith(
                    color: AppColors.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
                Container(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromRGBO(194, 198, 201, 0.3),
                                  offset: Offset(0, 5),
                                ),
                              ],
                              color: AppColors.primary,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20))),
                          padding: const EdgeInsets.all(10),
                          child: SvgPicture.asset(
                            IconEnums.yellowArrow,
                            color: AppColors.background,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(194, 198, 201, 0.3),
                                offset: Offset(4, 4),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            'QUAY LẠI TRANG CHỦ',
                            style: Styles.titleItem
                                .copyWith(color: AppColors.primary),
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BuildBtn extends StatelessWidget {
  final Function() onClickPrescription;

  const BuildBtn({
    Key? key,
    required this.onClickPrescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heightConvert(context, 812),
      width: widthConvert(context, 375),
      padding: EdgeInsets.symmetric(horizontal: widthConvert(context, 16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 16,
                ),
                child: AppButtonOutline(
                  text: l10n(context)!.back_to_home!,
                  onClick: onClickPrescription,
                  color: AppColors.primary500,
                  buttonSize: 48,
                  borderRadius: BorderRadius.circular(24),
                  labelStyle: Styles.titleButton.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary500,
                    height: 1,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: heightConvert(context, 44)),
                child: AppButtonOutline(
                  text: l10n(context)!.hotline.toString().toUpperCase(),
                  phoneNumber: Constants.contactPhone,
                  buttonSize: 40,
                  labelStyle: Styles.titleButton.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.error900,
                    height: 1,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
