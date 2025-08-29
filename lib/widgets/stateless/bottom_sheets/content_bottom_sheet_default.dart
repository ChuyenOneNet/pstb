import 'package:flutter/material.dart';

class ButtonBottomSheetModel {
  String label;
  Color color;
  Function() onPressed;

  ButtonBottomSheetModel(
      {required this.label, required this.color, required this.onPressed});
}

class ContentBottomSheetDefault extends StatelessWidget {
  const ContentBottomSheetDefault(
      {Key? key, required this.title, required this.buttons})
      : super(key: key);

  final String title;
  final List<ButtonBottomSheetModel> buttons;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _titleWidget(context: context, title: title),
          _buildButtons(context),
          const SizedBox(
            height: 8,
          ),
          _cancelButton(context),
          const SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    final buttonWidgets = List<Widget>.generate(
        buttons.length,
        (index) => _buttonItem(context,
            color: buttons[index].color,
            label: buttons[index].label,
            onPressed: buttons[index].onPressed,
            borderBottom: index == buttons.length - 1));
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: buttonWidgets,
    );
  }

  Widget _titleWidget({required BuildContext context, required String title}) {
    return Container(
      height: 60,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(14), topRight: Radius.circular(14))),
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }

  Widget _cancelButton(BuildContext context) {
    return _buttonItem(context,
        borderAll: true,
        isBoldText: true,
        label: 'Hủy bỏ',
        color: Colors.black,
        onPressed: () => Navigator.pop(context));
  }

  Widget _buttonItem(BuildContext context,
      {bool borderTop = false,
      bool borderBottom = false,
      bool borderAll = false,
      bool isBoldText = false,
      required Function() onPressed,
      required String label,
      required Color color}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 58,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: borderTop
                ? const BorderRadius.only(
                    topLeft: Radius.circular(14), topRight: Radius.circular(14))
                : borderBottom
                    ? const BorderRadius.only(
                        bottomLeft: Radius.circular(14),
                        bottomRight: Radius.circular(14))
                    : borderAll
                        ? const BorderRadius.all(Radius.circular(14))
                        : null),
        child: Text(
          label,
          style: TextStyle(
              color: color, fontWeight: isBoldText ? FontWeight.bold : null),
        ),
      ),
    );
  }
}
