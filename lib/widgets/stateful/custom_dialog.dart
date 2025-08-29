import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/utils/styles.dart';
import 'package:pstb/widgets/stateless/app_button.dart';

class CustomDialog extends StatefulWidget {
  const CustomDialog(
      {Key? key,
      required this.title,
      required this.content,
      required this.titleButton,
      required this.onPressed,
      this.iconRight})
      : super(key: key);

  final String title;
  final Widget content;
  final String titleButton;
  final Function() onPressed;
  final String? iconRight;

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // To make the card compact
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                    onTap: () {
                      Modular.to.pop();
                    },
                    child: const Icon(
                      Icons.close,
                      color: Colors.red,
                    ))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.title,
                  style: Styles.titleItem,
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            widget.content,
            const SizedBox(height: 24.0),
            Row(
              children: [
                const Spacer(),
                Expanded(
                  flex: 2,
                  child: AppButton(
                    title: widget.titleButton,
                    onPressed: widget.onPressed,
                    iconRight: widget.iconRight,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
