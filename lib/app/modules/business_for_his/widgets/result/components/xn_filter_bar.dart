import 'package:flutter/material.dart';
import '../../../../../../../utils/colors.dart';

/// Xét Nghiệm Filter Bar Component
class XNFilterBar extends StatelessWidget {
  final List<(String, String)> filters;
  final String? selectedQuickFilter;
  final Function(String) onFilterTap;

  const XNFilterBar({
    Key? key,
    required this.filters,
    required this.selectedQuickFilter,
    required this.onFilterTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 8,
      children: List.generate(filters.length, (i) {
        final (label, type) = filters[i];
        return Padding(
          padding: EdgeInsets.only(right: i < filters.length - 1 ? 8 : 0),
          child: _buildFilterButton(label, type),
        );
      }),
    );
  }

  Widget _buildFilterButton(String label, String type) {
    final isSelected = selectedQuickFilter == type;
    return InkWell(
      onTap: () => onFilterTap(type),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
          border: !isSelected
              ? Border.all(color: Colors.grey[300]!, width: 1)
              : null,
          boxShadow: isSelected
              ? [
                  BoxShadow(
                      color: AppColors.primary.withOpacity(0.3), blurRadius: 8)
                ]
              : null,
        ),
        child: Text(label,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : Colors.grey[700])),
      ),
    );
  }
}
