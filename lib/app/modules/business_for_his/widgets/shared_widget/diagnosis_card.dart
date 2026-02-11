import 'package:flutter/material.dart';
import 'package:pstb/app/models/business_detail_model.dart';

/// Diagnosis Card widget
class DiagnosisCard extends StatelessWidget {
  final SinhHieu sinhHieu;

  const DiagnosisCard({
    Key? key,
    required this.sinhHieu,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Chẩn đoán',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 12),
            if (sinhHieu.benhChinh != null) ...[
              _buildDiagnoseRow('Bệnh chính', sinhHieu.benhChinh),
              const SizedBox(height: 8),
            ],
            if (sinhHieu.benhKemTheo != null) ...[
              _buildDiagnoseRow('Bệnh kèm theo', sinhHieu.benhKemTheo),
              const SizedBox(height: 8),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDiagnoseRow(String label, String? value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: ',
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
        ),
        Expanded(
          child: Text(
            value ?? '-',
            style: const TextStyle(fontSize: 13),
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }
}
