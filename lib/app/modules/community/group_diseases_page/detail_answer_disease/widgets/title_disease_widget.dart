import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pstb/app/modules/community/group_diseases_page/detail_answer_disease/detail_answer_disease_store.dart';
import 'package:pstb/utils/colors.dart';
import 'package:pstb/utils/helper.dart';
import 'package:pstb/utils/styles.dart';

class TitleDiseaseWidget extends StatelessWidget {
  const TitleDiseaseWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final DetailAnswerDiseaseStore controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: heightConvert(context, 5),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [
              0.1,
              0.4,
              0.6,
              0.9,
            ],
            colors: [
              Color(0xfff5c230),
              Color(0xfffffa8a),
              Color(0xffddac17),
              Color(0xffffff95),
            ],
          )),
        ),
        Container(
          color: AppColors.primary,
          height: heightConvert(context, 42),
          width: double.infinity,
          padding: EdgeInsets.only(left: widthConvert(context, 20)),
          alignment: Alignment.centerLeft,
          child: Observer(builder: (context) {
            return Text(
              controller.categoryDiseaseModel.name ?? '',
              style: Styles.heading4
                  .copyWith(foreground: Styles.defaultGradientPaint),
            );
          }),
        ),
      ],
    );
  }
}
