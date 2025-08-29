import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:pstb/utils/colors.dart';

import '../../utils/styles.dart';
import 'dropdown_theme.dart';

class DropdownData<T> {
  String id;
  String displayName;
  String? svgAsset;
  T? originModel;

  DropdownData({
    required this.id,
    required this.displayName,
    this.originModel,
    this.svgAsset,
  });

  DropdownData copyWith({
    String? id,
    String? displayName,
    String? svgAsset,
    T? originModel,
  }) {
    return DropdownData(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      svgAsset: svgAsset ?? this.svgAsset,
      originModel: originModel ?? this.originModel,
    );
  }
}

class Dropdown extends StatelessWidget {
  final List<DropdownData> items;
  final DropdownData? selectedItem;
  final Function(DropdownData?) onChanged;
  final String hintText;
  final bool enabled;
  final FormFieldValidator<DropdownData?>? validator;
  final Widget? prefixIcon;
  final DropdownSearchPopupItemBuilder<DropdownData>? popupPropsItemBuilder;

  const Dropdown({
    required this.items,
    required this.selectedItem,
    required this.onChanged,
    required this.hintText,
    this.enabled = true,
    this.validator,
    this.prefixIcon,
    this.popupPropsItemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = AppColors.black;
    return DropdownSearch<DropdownData>(
      validator: validator,
      dropdownDecoratorProps: DropdownTheme(context).dropdownDecoratorProps(),
      selectedItem: selectedItem,
      items: items,
      enabled: enabled,
      dropdownBuilder: (context, selectedItem) {
        final isHintText = selectedItem == null;
        late Widget label;
        if (isHintText) {
          label = Text(
            hintText,
            style: Styles.styleHintText,
          );
        } else {
          label = Text(
            selectedItem?.displayName ?? '-',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
          );
        }
        return Row(
          children: [
            if (prefixIcon != null) prefixIcon!,
            label,
          ],
        );
      },
      itemAsString: (item) => item.displayName,
      onChanged: onChanged,
      dropdownButtonProps: DropdownButtonProps(
        icon: Icon(
          Icons.keyboard_arrow_down,
          size: 24,
          color: textColor,
        ),
      ),
      popupProps: PopupProps.menu(
        fit: FlexFit.loose,
        itemBuilder: popupPropsItemBuilder,
      ),
    );
  }
}
