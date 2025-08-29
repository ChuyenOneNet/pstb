import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../../utils/styles.dart';
import 'dropdown.dart';
import 'dropdown_filter.dart';

class DropdownFilterWithLabel extends StatelessWidget {
  final DropdownData? selectedItem;
  final Function(DropdownData?) onChanged;
  final String hintText;
  final String label;
  final String searchHintText;
  final DropdownSearchOnFind<DropdownData> asyncItems;
  final bool enabled;
  final bool showSearchBox;
  final FormFieldValidator<DropdownData?>? validator;
  final bool isFilterOnline;

  const DropdownFilterWithLabel({
    required this.selectedItem,
    required this.onChanged,
    required this.hintText,
    required this.label,
    required this.asyncItems,
    required this.searchHintText,
    this.enabled = true,
    this.showSearchBox = true,
    this.validator,
    this.isFilterOnline = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty) ...[
          Text(
            label,
            style: Styles.style15grey.copyWith(
              color: const Color(0xFF17181C),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
        ],
        DropdownFilter(
          searchHintText: searchHintText,
          asyncItems: asyncItems,
          items: const [],
          selectedItem: selectedItem,
          onChanged: onChanged,
          hintText: hintText,
          enabled: enabled,
          validator: validator,
          isFilterOnline: isFilterOnline,
          showSearchBox: showSearchBox,
        ),
      ],
    );
  }
}
