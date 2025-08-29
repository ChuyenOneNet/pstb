import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateful/stateful_widget.dart';

class DiscountCodeItem extends StatefulWidget {
  final Function onSelect;
  final bool isCheck;
  final bool isOutOfDate;
  final DateTime expiredDate;
  final String title;

  const DiscountCodeItem(
      {Key? key,
      required this.onSelect,
      this.isCheck = false,
      this.isOutOfDate = false,
      required this.expiredDate,
      required this.title})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return DiscountCodeItemState();
  }
}

class DiscountCodeItemState extends State<DiscountCodeItem> {
  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onTap: widget.isOutOfDate ? () {} : widget.onSelect,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.only(bottom: 16),
        decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(
          color: AppColors.neutral200,
        ))),
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                widget.isOutOfDate
                    ? ImageEnum.expriryDiscount
                    : ImageEnum.discount,
                width: 72,
                fit: BoxFit.contain,
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.title,
                        style: Styles.bodyBold,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        '${l10n(context)!.comfirm_and_payment_expired_date}: ${DateFormat(DateTimeFormatPattern.formatddMMyyyy).format(widget.expiredDate)}',
                        style: Styles.subtitleSmall
                            .copyWith(color: AppColors.neutral700),
                      ),
                    ]),
              )),
              Padding(
                  padding: const EdgeInsets.only(right: 16, left: 32),
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
            ],
          ),
        ),
      ),
    );
  }
}
