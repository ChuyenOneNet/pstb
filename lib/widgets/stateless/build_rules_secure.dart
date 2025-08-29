import 'package:flutter/material.dart';
import 'package:pstb/utils/colors.dart';
import 'package:pstb/utils/helper.dart';
import 'package:pstb/utils/l10n.dart';
import 'package:pstb/utils/styles.dart';

class BuildRulesSecure extends StatelessWidget {
  const BuildRulesSecure({
    Key? key,
    required this.onRule,
    required this.onSecure,
  }) : super(key: key);

  final Function() onRule;
  final Function() onSecure;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.only(top: heightConvert(context, 20)),
            child: Text(
              l10n(context)!.forgot_text_access,
              style: Styles.subtitleSmall,
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
              child: TextButton(
                  style: TextButton.styleFrom(
                      minimumSize: const Size.square(1),
                      padding: const EdgeInsets.all(1)),
                  onPressed: onRule,
                  child: Text(
                    l10n(context)!.forgot_btnText_rule,
                    style:
                        Styles.subtitleSmall.copyWith(color: AppColors.primary),
                  )),
            ),
            Text(l10n(context)!.forgot_text_and, style: Styles.subtitleSmall),
            SizedBox(
              height: 20,
              child: TextButton(
                  style: TextButton.styleFrom(
                      minimumSize: const Size.square(1),
                      padding: const EdgeInsets.all(1)),
                  onPressed: onSecure,
                  child: Text(l10n(context)!.forgot_btnText_secure,
                      style: Styles.subtitleSmall
                          .copyWith(color: AppColors.primary))),
            ),
          ],
        )
      ],
    );
  }
}
