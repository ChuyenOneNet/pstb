import 'package:flutter/material.dart';
import 'package:pstb/app/models/business_detail_model.dart';
import '../../../../../../../utils/colors.dart';

/// Xét Nghiệm Type Card Component (expandable)
class XNTypeCard extends StatelessWidget {
  final String typeName;
  final List<XetNghiemInfo> items;
  final bool isExpanded;
  final VoidCallback onToggle;
  final VoidCallback onShowDetails;

  const XNTypeCard({
    Key? key,
    required this.typeName,
    required this.items,
    required this.isExpanded,
    required this.onToggle,
    required this.onShowDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final displayCount = isExpanded ? items.length : 3;

    return GestureDetector(
      onTap: onToggle,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
              colors: [AppColors.primary.withOpacity(0.95), AppColors.primary]),
          boxShadow: [
            BoxShadow(
                color: AppColors.primary.withOpacity(0.2),
                blurRadius: 12,
                offset: const Offset(0, 4))
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(typeName,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                            overflow: TextOverflow.ellipsis),
                        const SizedBox(height: 4),
                        Text('${items.length} chỉ số',
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 12)),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: onShowDetails,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6)),
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        Text('Chi tiết',
                            style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 11)),
                        const SizedBox(width: 2),
                        Icon(Icons.arrow_forward,
                            size: 11, color: AppColors.primary),
                      ]),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                      isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: Colors.white),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12))),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: items.take(displayCount).map((item) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: Text(item.tenChiSo ?? '-',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey[700]),
                                      overflow: TextOverflow.ellipsis)),
                              const SizedBox(width: 12),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                    color: AppColors.primary.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(6)),
                                child: Text(item.giaTri ?? '-',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primary)),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  if (items.length > 3 && !isExpanded)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(color: Colors.grey[200]!))),
                      child: Center(
                          child: Text('Xem thêm ${items.length - 3} chỉ số',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold))),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
