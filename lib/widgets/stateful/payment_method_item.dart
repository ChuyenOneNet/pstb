import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pstb/utils/colors.dart';
import 'package:pstb/utils/styles.dart';
import 'package:pstb/widgets/stateful/stateful_widget.dart';

class PaymentMethodItem extends StatefulWidget {
  final String? paymentMethodIconSVG;
  final String paymentMethodName;
  final String? paymentMethodIconPNG;
  final Function onSelect;
  final bool isCheck;

  const PaymentMethodItem(
      {Key? key,
      this.paymentMethodIconSVG,
      required this.paymentMethodName,
      this.isCheck = false,
      this.paymentMethodIconPNG,
      required this.onSelect})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PaymentMethodItemState();
  }
}

class PaymentMethodItemState extends State<PaymentMethodItem> {
  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
        child: Container(
          decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(
            color: AppColors.neutral200,
          ))),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: widget.isCheck
                      ? const Icon(
                          Icons.radio_button_checked,
                          size: 24,
                          color: AppColors.accent700,
                        )
                      : const Icon(
                          Icons.radio_button_off,
                          size: 24,
                          color: AppColors.neutral400,
                        )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: widget.paymentMethodIconPNG != null
                    ? Image.asset(widget.paymentMethodIconPNG!)
                    : SvgPicture.asset(widget.paymentMethodIconSVG!),
              ),
              Text(
                widget.paymentMethodName,
                style: Styles.bodyRegular,
              )
            ],
          ),
        ),
        onTap: widget.onSelect);
  }
}
