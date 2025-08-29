import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  final String patientCode;
  final String patientInfo;
  final String executionDate;
  final String userName;
  final String medicineCode;

  const HeaderSection({
    Key? key,
    required this.patientCode,
    required this.patientInfo,
    required this.executionDate,
    required this.userName,
    required this.medicineCode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$patientCode | $patientInfo',
          style: const TextStyle(fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text('NGÀY THỰC HIỆN THUỐC : $executionDate'),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text('Mã phiếu TH: $medicineCode'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(userName, textAlign: TextAlign.center),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
