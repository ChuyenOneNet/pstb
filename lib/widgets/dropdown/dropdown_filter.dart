import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import '../../utils/styles.dart';
import 'dropdown.dart';

class DropdownFilter extends StatelessWidget {
  final List<DropdownData> items;
  final DropdownData? selectedItem;
  final Function(DropdownData?) onChanged;
  final String hintText;
  final String searchHintText;
  final DropdownSearchOnFind<DropdownData> asyncItems;
  final bool enabled;
  final bool showSearchBox;
  final FormFieldValidator<DropdownData?>? validator;
  final bool isFilterOnline;

  const DropdownFilter({
    required this.items,
    required this.selectedItem,
    required this.onChanged,
    required this.hintText,
    required this.searchHintText,
    required this.asyncItems,
    this.enabled = true,
    this.showSearchBox = true,
    this.validator,
    this.isFilterOnline = true,
  });

  @override
  Widget build(BuildContext context) {
    const textColor = Color(0xFF17181C);
    const borderColor = Color(0xFFD8DDE4);
    const disableBorderColor = Color(0xFFBEBEBE);
    const double borderRadius = 8;

    const border = OutlineInputBorder(
      borderSide: BorderSide(color: borderColor, width: 1),
      borderRadius: BorderRadius.all(
        Radius.circular(borderRadius),
      ),
    );
    const disableBorder = OutlineInputBorder(
      borderSide: BorderSide(color: disableBorderColor, width: 1),
      borderRadius: BorderRadius.all(
        Radius.circular(borderRadius),
      ),
    );

    final inputDecoration = InputDecoration(
      contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      filled: true,
      fillColor: enabled ? Colors.white : const Color(0xFFE9ECF1),
      focusedErrorBorder: border,
      errorBorder: border,
      focusedBorder: border,
      enabledBorder: border,
      disabledBorder: disableBorder,
      labelStyle: Styles.style15grey.copyWith(
        color: textColor,
        fontSize: 14,
      ),
    );
    final dropDownDecoratorProps = DropDownDecoratorProps(
      dropdownSearchDecoration: inputDecoration,
      baseStyle: Styles.style15grey.copyWith(
        color: textColor,
        fontSize: 14,
      ),
    );

    return DropdownSearch<DropdownData>(
      dropdownDecoratorProps: dropDownDecoratorProps,
      validator: validator,
      selectedItem: selectedItem,
      items: items,
      asyncItems: asyncItems,
      enabled: enabled,
      popupProps: _buildPopupProps(
        context,
        textColor: textColor,
      ),
      dropdownBuilder: (context, selectedItem) {
        final isHintText = selectedItem == null;
        if (isHintText) {
          return Text(
            hintText,
            style: Styles.styleHintText,
          );
        }
        return Text(
          selectedItem?.displayName ?? '-',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
        );
      },
      itemAsString: (item) => item.displayName,
      compareFn: (item1, item2) => item1.id == item2.id,
      onChanged: onChanged,
      dropdownButtonProps: const DropdownButtonProps(
        icon: Icon(
          Icons.keyboard_arrow_down,
          size: 24,
          color: textColor,
        ),
      ),
    );
  }

  PopupProps<DropdownData> _buildPopupProps(
    BuildContext context, {
    required Color textColor,
  }) {
    final searchFieldProps = TextFieldProps(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: searchHintText,
        hintStyle: Styles.style15grey.copyWith(
          color: const Color(0xFF8D97B0),
          fontSize: 14,
        ),
      ),
      style: Styles.style15grey.copyWith(
        color: textColor,
        fontSize: 14,
      ),
    );

    Widget itemBuilder(DropdownData item) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          item.displayName,
          style: Styles.style15grey.copyWith(
            color: textColor,
            fontSize: 14,
          ),
        ),
      );
    }

    return PopupProps<DropdownData>.modalBottomSheet(
      searchFieldProps: searchFieldProps,
      isFilterOnline: isFilterOnline,
      showSearchBox: showSearchBox,
      itemBuilder: (context, item, _) {
        return itemBuilder(item);
      },
    );
  }
}
