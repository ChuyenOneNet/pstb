import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/widgets/stateless/item_text_row.dart';
import '../../../../../utils/colors.dart';
import '../../../../../utils/styles.dart';
import '../../../../models/examination_result_model.dart';
import '../../ehr_store.dart';

class InformationMedicalExamination extends StatelessWidget {
  final EHRStore store = Modular.get<EHRStore>();

  InformationMedicalExamination({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        InfoExaminations? data = store.resultsData.examination;
        return Container(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
          decoration: BoxDecoration(
            color: AppColors.background,
            border: Border.all(color: AppColors.lightSilver),
            borderRadius: BorderRadius.circular(8),
          ),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('II. Thông tin khám bệnh', style: Styles.titleItem),
              const Divider(
                color: AppColors.primary,
              ),
              _renderValueInformation("Mạch:", data!.pulse ?? '', context),
              _renderValueInformation(
                  "Nhiệt độ:", data.temperature ?? '', context),
              _renderValueInformation(
                  "Huyết áp:", data.bloodPressure ?? '', context),
              _renderValueInformation(
                  "Nhịp thở:", data.breathing ?? '', context),
              _renderValueInformation("Chiều cao:", data.height ?? '', context),
              _renderValueInformation("Cân nặng:", data.weight ?? '', context),
              _renderValueInformation(
                  "Chỉ số BMI:", store.getChiSoBMI(data), context),
              _renderValueInformation(
                  "Lý do đến khám:", data.reason ?? '', context),
              _renderValueInformation(
                  "Chuẩn đoán sơ bộ:", data.diagnosis ?? '', context),
              _renderValueInformation(
                  "Bệnh chính theo ICD:", data.icdDiseases ?? '', context),
              _renderValueInformation(
                  "Bệnh kèm theo ICD:", data.includingDiseases ?? '', context),
            ],
          ),
        );
      },
    );
  }

  Widget _renderValueInformation(
      String title, String value, BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width / 3),
              child: Text(title, style: Styles.content),
            ),
            Flexible(
              child: Text(
                value,
                textAlign: TextAlign.end,
                style: Styles.titleItem,
              ),
            ),
          ],
        ));
  }
}
