import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

class CustomDropdown<T> extends StatelessWidget {
  final String label;
  final List<T> items;
  final String Function(T) itemLabel;
  final T? selectedItem;
  final ValueChanged<T?> onChanged;
  final bool Function(T, String)? filterFn;
  final bool enabled;
  final Color? borderColor;

  const CustomDropdown({
    Key? key,
    required this.label,
    required this.items,
    required this.itemLabel,
    this.selectedItem,
    required this.onChanged,
    this.filterFn,
    this.enabled = true,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderClr = borderColor ?? Colors.grey[300]!;

    return DropdownSearch<T>(
      items: items,
      selectedItem: selectedItem,
      enabled: enabled,
      filterFn: filterFn ??
          (item, filter) =>
              itemLabel(item).toLowerCase().contains(filter.toLowerCase()),
      popupProps: PopupProps.menu(
        menuProps: MenuProps(
          borderRadius: BorderRadius.circular(12),
          backgroundColor: Colors.white,
          elevation: 4,
        ),
        showSearchBox: true,
        searchFieldProps: TextFieldProps(
          decoration: InputDecoration(
            hintText: "Tìm kiếm...",
            hintStyle: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
              fontWeight: FontWeight.w400,
            ),
            filled: true,
            fillColor: Colors.grey[50],
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: borderClr, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: borderClr, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.blue.shade700, width: 2),
            ),
          ),
          style: const TextStyle(fontSize: 14, color: Colors.black87),
        ),
        itemBuilder: (context, item, _) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              itemLabel(item),
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
                fontWeight: FontWeight.w400,
              ),
            ),
          );
        },
      ),
      dropdownBuilder: (context, item) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Text(
            item != null ? itemLabel(item) : "Chọn $label",
            style: TextStyle(
              fontSize: 14,
              color: item != null ? Colors.black87 : Colors.grey[500],
              fontWeight: FontWeight.w400,
            ),
          ),
        );
      },
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[50],
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: borderClr, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: borderClr, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.blue.shade700, width: 2),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: borderClr.withOpacity(0.5), width: 1),
          ),
        ),
      ),
      clearButtonProps: const ClearButtonProps(isVisible: false),
      onChanged: onChanged,
    );
  }
}
