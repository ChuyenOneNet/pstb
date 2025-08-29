import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobx/mobx.dart';

import '../../utils/colors.dart';
import '../../utils/icons.dart';
import '../../utils/styles.dart';

class CustomAutocompleteBasic extends StatelessWidget {
  const CustomAutocompleteBasic(
      {Key? key,
      required this.store,
      required this.keywordSearch,
      required this.onSubmitted,})
      : super(key: key);
  final Store store;
  final List<String> keywordSearch;
  final Function(String)? onSubmitted;

  static String _displayStringForOption(String value) => value;

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      displayStringForOption: _displayStringForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }
        return keywordSearch.where((String option) {
          return option
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        });
      },
      fieldViewBuilder: (BuildContext context,
          TextEditingController textEditingController,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted) {
        return Padding(
          padding: const EdgeInsets.only(left: 32.0),
          child: CupertinoSearchTextField(
            autofocus: true,
            placeholder: 'Tìm kiếm gói dịch vụ',
            placeholderStyle:
                Styles.titleItem.copyWith(color: AppColors.lightSilver),
            controller: textEditingController,
            focusNode: focusNode,
            style: Styles.content,
            onSubmitted: onSubmitted,
          ),
        );
      },
      optionsViewBuilder: (context, onSelected, options) => Align(
        alignment: Alignment.topLeft,
        child: Material(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(0.0)),
          ),
          child: Container(
            color: AppColors.background,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: options.length,
              shrinkWrap: false,
              itemBuilder: (BuildContext context, int index) {
                final String option = options.elementAt(index);
                return itemList(context, option, onSelected);
              },
            ),
          ),
        ),
      ),
      onSelected: (String selection) {
        var valueSearch = _displayStringForOption(selection);
      },
    );
  }

  Widget itemList(
      BuildContext context, String option, Function(String) onSelected) {
    return InkWell(
      onTap: () => onSelected(option),
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0, left: 32.0, right: 32.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                children: [
                  SizedBox(
                      height: 20,
                      width: 20,
                      child: SvgPicture.asset(
                        IconEnums.iconClockSearch,
                        fit: BoxFit.fill,
                      )),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    option,
                    style: Styles.content,
                  )
                ],
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_right,
              size: 28,
              color: AppColors.black,
            ),
          ],
        ),
      ),
    );
  }
}
