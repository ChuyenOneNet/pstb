import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/routes.dart';
import '../../../../widgets/dropdown/dropdown.dart';
import '../../../../widgets/dropdown/dropdown_filter_with_label.dart';
import '../../../models/perform_medicine/medicine_usage_model.dart';
import '../widget/header_section.dart';
import '../widget/medicine_usage_card.dart';
import 'medicine_usage_store.dart';

class PerformMedicineConfigPage extends StatelessWidget {
  final String patientCode;
  final String patientInfo;
  final String executionDate;
  final String userName;
  final List<MedicineUsageModel> initialData;

  const PerformMedicineConfigPage({
    Key? key,
    required this.patientCode,
    required this.patientInfo,
    required this.executionDate,
    required this.userName,
    required this.initialData,
  });

  String generateMedicineCode() {
    final now = DateTime.now();
    final datePart = DateFormat('ddMMyyyy').format(now);
    final randomPart = (1000 + Random().nextInt(9000)).toString();
    return '$datePart$randomPart';
  }

  @override
  Widget build(BuildContext context) {
    final store = MedicineUsageStore()..setUsages(initialData);
    final String medicineCode = generateMedicineCode();
    store.setUsages(
      initialData
          .map((e) => e
            ..usageTime = DateFormat('HH:mm dd/MM/yyyy').parse(executionDate))
          .toList(),
    );

    return Provider.value(
      value: store,
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
              onTap: () => Modular.to.pop(),
              child: Icon(Icons.arrow_back_ios, color: Colors.white)),
          title: const Text(
            'THỰC HIỆN THUỐC',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              HeaderSection(
                patientCode: patientCode,
                patientInfo: patientInfo,
                executionDate: executionDate,
                userName: userName,
                medicineCode: medicineCode,
              ),
              const SizedBox(height: 12),
              Expanded(
                child: Observer(builder: (context) {
                  return ListView.builder(
                    itemCount: store.usages.length,
                    itemBuilder: (context, index) => MedicineUsageCard(
                      executionDate: executionDate,
                      index: index,
                      usage: store.usages[index],
                      store: store,
                    ),
                  );
                }),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.sub_yellow,
                        // padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text(
                        'Quay lại',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        //padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () async {
                        // TODO: Gửi dữ liệu
                        EasyLoading.show();
                        await Future.delayed(Duration(milliseconds: 500));
                        Modular.to.pushNamed(AppRoutes.perFormMedicinePage);
                        EasyLoading.dismiss();
                      },
                      child: const Text(
                        'Xác nhận',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
