import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/utils/format_util.dart';
import 'package:pstb/utils/main.dart';

class BuildPaymentPrice extends StatefulWidget {
  final String title;
  final String? iconLeft;
  final String? iconRight;
  final bool isDisable;
  final int realPrice;
  final int? cost;
  final String? discountLabel;
  final String? methodPayment;
  final int discount;
  final int? point;
  final Function? onPressed;
  final String? routeName;

  const BuildPaymentPrice(
      {Key? key,
      required this.isDisable,
      required this.cost,
      required this.discount,
      required this.realPrice,
      required this.title,
      required this.onPressed,
      this.discountLabel,
      this.point,
      this.iconLeft,
      this.iconRight,
      this.routeName, this.methodPayment})
      : super(key: key);

  const BuildPaymentPrice.next(
      {Key? key,
      required this.isDisable,
      required this.cost,
      required this.discount,
      required this.realPrice,
      required this.title,
      this.discountLabel,
      this.onPressed,
      this.point,
      this.iconLeft,
      this.iconRight,
      required this.routeName, this.methodPayment})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BuildPaymentPriceState();
  }
}

class _BuildPaymentPriceState extends State<BuildPaymentPrice> {
  late Function _callback;

  Widget? _pointWidget;

  @override
  Widget build(BuildContext context) {
    if (widget.routeName != null) {
      _callback = () {
        Modular.to.pushNamed(widget.routeName!);
      };
    } else {
      _callback = widget.onPressed!;
    }

    if (widget.point != null) {
      _pointWidget = _buildRowView(
          title: l10n(context)!.comfirm_and_payment_point,
          content:
              '${widget.point != null && widget.point! > 0 ? "-" : ""}${formatCurrency(widget.point.toString())} ${Constants.vietnameseCurrencyUnit}');
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Thanh toán',
              style: Styles.titleItem,
            ),
            Text(widget.methodPayment ?? 'Tại Cơ sở y tế',style: Styles.titleItem,),
          ],
        ),
        const Divider(
          color: AppColors.primary,
        ),
        _buildRowView(
            title: l10n(context)!.comfirm_and_payment_cost,
            content:
                '${FormatUtil.formatMoney(widget.cost)} ${Constants.vietnameseCurrencyUnit}'),
        if (_pointWidget != null) _pointWidget!,
        _buildRowView(
            title: widget.discountLabel == null
                ? l10n(context)!.comfirm_and_payment_discount
                : l10n(context)!.comfirm_and_payment_voucher,
            content:
                '${widget.discount > 0 ? "-" : ""}${formatCurrency(widget.discount.toString())} ${Constants.vietnameseCurrencyUnit}'),
        // _buildRowView(
        //     title: l10n(context)!.comfirm_and_payment_real_price,
        //     content:
        //         '${formatCurrency(widget.realPrice.toString())} ${Constants.vietnameseCurrencyUnit}',
        //     isTextBold: true),
        // AppButton(
        //   isDisable: widget.isDisable,
        //   iconLeft: widget.iconLeft,
        //   iconRight: widget.iconRight,
        //   title: widget.title,
        //   onPressed: () => _callback(),
        //   isLeftGradient: true,
        // )
      ],
    );
  }

  Widget _buildRowView(
      {required String title,
      required String content,
      bool isTextBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: isTextBold
                ? Styles.content.copyWith(color: AppColors.primary)
                : Styles.content,
          ),
          Text(
            content,
            style: isTextBold
                ? Styles.content.copyWith(color: AppColors.primary)
                : Styles.titleItem,
          )
        ],
      ),
    );
  }
}
