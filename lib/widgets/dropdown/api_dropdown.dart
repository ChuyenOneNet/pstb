import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropdown_search/dropdown_search.dart';

typedef ItemAsString<T> = String Function(T item);
typedef SearchApi<T> = Future<List<T>> Function(String filter);

class ApiDropdown<T, C extends StateStreamable<S>, S> extends StatelessWidget {
  final T? selected;
  final ValueChanged<T?> onChanged;
  final String Function(T) itemAsString;
  final bool Function(S) isLoading;
  final bool Function(S) isError;
  final String Function(S) getErrorMessage;
  final List<T> Function(S) getItems;
  final SearchApi<T>? onSearch;
  final String hintText;

  const ApiDropdown({
    Key? key,
    required this.selected,
    required this.onChanged,
    required this.itemAsString,
    required this.isLoading,
    required this.isError,
    required this.getErrorMessage,
    required this.getItems,
    this.onSearch,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<C, S>(
      builder: (context, state) {
        if (isLoading(state) && onSearch == null) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[300]!, width: 1),
            ),
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        if (isError(state) && onSearch == null) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[300]!, width: 1),
            ),
            child: Text(
              "Lỗi: ${getErrorMessage(state)}",
              style: const TextStyle(
                fontSize: 14,
                color: Colors.red,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }

        final items = onSearch == null ? getItems(state) : [];

        return DropdownSearch<T>(
          selectedItem: selected,
          itemAsString: itemAsString,
          asyncItems: onSearch != null
              ? (filter) async {
                  final result = await onSearch!(filter);
                  return result.cast<T>();
                }
              : null,
          items: onSearch == null ? items.cast<T>() : [],
          popupProps: PopupProps.menu(
            showSearchBox: true,
            searchDelay: const Duration(milliseconds: 300),
            menuProps: MenuProps(
              borderRadius: BorderRadius.circular(12),
              backgroundColor: Colors.white,
              elevation: 4,
            ),
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
                  borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      const BorderSide(color: Color(0xFF1E88E5), width: 2),
                ),
              ),
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
            itemBuilder: (context, item, _) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Text(
                  itemAsString(item),
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
                item != null ? itemAsString(item) : hintText,
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
                borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    const BorderSide(color: Color(0xFF1E88E5), width: 2),
              ),
            ),
          ),
          onChanged: onChanged,
          clearButtonProps: const ClearButtonProps(isVisible: false),
        );
      },
    );
  }
}
