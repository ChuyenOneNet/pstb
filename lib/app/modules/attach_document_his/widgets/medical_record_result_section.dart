import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pstb/app/modules/business/business_store.dart';

import '../../../../constant/color.dart';
import '../../business/page/patient_infomation.dart';
import 'medical_visit_filter_bar.dart';
import 'medical_visit_history_list.dart';

class MedicalRecordResultSection extends StatelessWidget {
  final BusinessStore store;

  const MedicalRecordResultSection({
    Key? key,
    required this.store,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        // Nếu store có state loading riêng thì dùng, còn không thì chỉ render list
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thông tin bệnh nhân (bạn đã có)
            PatientInformation(),

            const SizedBox(height: 10),
            Text(
              'Thông tin khám bệnh',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: AppColors.primaryColor,
              ),
            ),
            // Filter bar (from/to + nút search)
            // MedicalVisitFilterBar(
            //   onSearch: (from, to) async {
            //     await store.loadHistoryRecord(fromDate: from, toDate: to);
            //   },
            // ),
            //
            const SizedBox(height: 10),

            // List lịch sử
            const MedicalVisitHistoryList(),
          ],
        );
      },
    );
  }
}
