import 'package:flutter/material.dart';
import 'package:pstb/utils/main.dart';
import 'gradient_button_widget.dart';

class InformationInputTextWidget extends StatelessWidget {
  const InformationInputTextWidget(
      {Key? key,
      this.value,
      required this.data,
      this.onChanged,
      this.onTapField,
      this.onChangedContent,
      this.postQuestion})
      : super(key: key);
  final String? value;
  final List<String> data;
  final Function(String?)? onChanged;
  final Function()? onTapField;
  final Function(String)? onChangedContent;
  final Function()? postQuestion;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: heightConvert(context, 550),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                AppColors.gradientTextField,
              ])),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: widthConvert(context, 16),
            ),
            child: Container(
              margin: const EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(12),
              child: DropdownButton<String>(
                  onTap: onTapField,
                  value: value,
                  isExpanded: true,
                  underline: const SizedBox.shrink(),
                  items: data.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  hint: Text(
                    l10n(context).get_group,
                    style: const TextStyle(color: AppColors.grayLight),
                  ),
                  onChanged: onChanged),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(32),
              ),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Hãy nhập nội dung cần giải đáp';
                  }
                  return null;
                },
                maxLines: 5,
                onChanged: onChangedContent,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: l10n(context).hint_input_question + ':',
                  hintStyle: const TextStyle(color: AppColors.grayLight),
                ),
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                const Spacer(),
                Expanded(
                  flex: 3,
                  child: GradientButtonWidget(
                    titleButton: l10n(context).text_button_set_question,
                    onTap: postQuestion,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
