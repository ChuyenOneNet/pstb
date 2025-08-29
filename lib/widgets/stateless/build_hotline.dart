import 'package:flutter/material.dart';
import 'package:pstb/utils/constants.dart';
import 'package:pstb/utils/helper.dart';
import 'package:pstb/utils/l10n.dart';
import 'package:pstb/utils/styles.dart';
import 'package:pstb/widgets/stateless/app_button_outline.dart';

class BuildHotline extends StatelessWidget {
  const BuildHotline({
    Key? key,
    this.hotLine,
  }) : super(key: key);

  final String? hotLine;
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Padding(
        padding: EdgeInsets.only(bottom: heightConvert(context, 20)),
        child: Text(
          l10n(context)!.forgot_text_callOut,
          style: Styles.content.copyWith(fontSize: 13),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(bottom: heightConvert(context, 24)),
        child: AppButtonOutline(
          text: l10n(context)!.hotline.toString().toUpperCase(),
          phoneNumber: hotLine ?? Constants.contactPhone,
        ),
      )
    ]);
  }
}
