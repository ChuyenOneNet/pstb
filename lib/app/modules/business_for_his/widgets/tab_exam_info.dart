import 'package:flutter/material.dart';
import 'package:pstb/app/models/business_detail_model.dart';
import 'package:pstb/app/modules/business_for_his/widgets/shared_widget/diagnosis_card.dart';
import 'package:pstb/app/modules/business_for_his/widgets/shared_widget/expandable_section.dart';
import 'package:pstb/app/modules/business_for_his/widgets/shared_widget/info_card.dart';
import 'package:pstb/app/modules/business_for_his/widgets/shared_widget/vital_signs_card.dart';

import '../../../../../utils/colors.dart';

/// TAB 2: THÔNG TIN KHÁM
class TabExamInfo extends StatefulWidget {
  final BusinessDetailModel detail;

  const TabExamInfo({Key? key, required this.detail}) : super(key: key);

  @override
  State<TabExamInfo> createState() => _TabExamInfoState();
}

class _TabExamInfoState extends State<TabExamInfo> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: [
          // InfoCard(
          //   children: [
          //     _buildInfoRow('Vào viện', widget.detail.ngayVaoVien),
          //     _buildInfoRow('Ra viện', widget.detail.ngayRaVien),
          //   ],
          // ),
          // const SizedBox(height: 12),
          VitalSignsCard(sinhHieu: widget.detail.sinhHieu),
          const SizedBox(height: 12),
          if (widget.detail.sinhHieu?.benhChinh != null)
            DiagnosisCard(sinhHieu: widget.detail.sinhHieu!),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String? value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 13,
            color: Colors.grey[600],
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            value ?? '-',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: Colors.grey[900],
            ),
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
