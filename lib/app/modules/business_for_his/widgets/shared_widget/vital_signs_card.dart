import 'package:flutter/material.dart';
import 'package:pstb/app/models/business_detail_model.dart';
import '../../../../../utils/colors.dart';

/// Vital Signs Card widget
class VitalSignsCard extends StatelessWidget {
  final SinhHieu? sinhHieu;

  const VitalSignsCard({
    Key? key,
    required this.sinhHieu,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (sinhHieu == null) {
      return const SizedBox.shrink();
    }

    return Card(
      color: AppColors.background,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Các chỉ số sinh tồn',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _buildVitalItem('Mạch', sinhHieu?.mach ?? "-", 'lần/phút'),
                _buildVitalItem('Nhiệt độ', sinhHieu?.nhietDo ?? "-", '°C'),
                _buildVitalItem(
                    'Nhịp thở', sinhHieu?.nhipTho ?? "-", 'lần/phút'),
                _buildVitalItem('SpO2', sinhHieu?.spo2 ?? "-", '%'),
                _buildVitalItem('Cân nặng', sinhHieu?.canNang ?? "-", 'kg'),
                _buildVitalItem('Chiều cao', sinhHieu?.chieuCao ?? "-", 'cm'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVitalItem(String label, String? value, String unit) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.primary.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            '$value $unit',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
