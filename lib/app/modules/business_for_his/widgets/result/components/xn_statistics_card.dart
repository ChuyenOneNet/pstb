import 'package:flutter/material.dart';
import 'package:pstb/app/models/business_detail_model.dart';
import '../../../../../../../utils/colors.dart';

/// Xét Nghiệm Statistics Card Component
class XNStatisticsCard extends StatelessWidget {
  final Map<String, List<XetNghiemInfo>> data;

  const XNStatisticsCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final totalResults =
        data.values.fold<int>(0, (sum, list) => sum + list.length);
    final testTypes = data.values.fold<Set<String>>({}, (set, items) {
      for (final item in items) set.add(item.tenLoaiXetNghiem ?? '');
      return set;
    }).length;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          AppColors.primary.withOpacity(0.1),
          AppColors.primary.withOpacity(0.05)
        ]),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatItem('Kết quả', totalResults.toString()),
          _buildStatItem('Ngày', data.length.toString()),
          _buildStatItem('Loại', testTypes.toString()),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(value,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.primary)),
        const SizedBox(height: 4),
        Text(label,
            style: TextStyle(
                fontSize: 11,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500)),
      ],
    );
  }
}
