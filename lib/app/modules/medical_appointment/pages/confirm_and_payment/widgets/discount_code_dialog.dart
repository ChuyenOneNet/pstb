import 'package:flutter/material.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateful/stateful_widget.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';

import '../models/discount_code.dart';

class DiscountCodeDialog extends StatefulWidget {
  final Function(String) onSearch;
  final Function onDispose;
  final Function onApply;
  final Function(String) onSave;
  final String discountDialogId;
  final List<DiscountCode> listDiscountActive;
  final List<DiscountCode> listDiscountInActive;

  const DiscountCodeDialog(
      {Key? key,
      required this.onDispose,
      required this.onSearch,
      required this.onApply,
      required this.listDiscountActive,
      required this.listDiscountInActive,
      required this.onSave,
      required this.discountDialogId})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => DiscountCodeDialogState();
}

class DiscountCodeDialogState extends State<DiscountCodeDialog> {
  @override
  void dispose() {
    // ignore: unnecessary_statements
    widget.onDispose;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 16),
          child: _buildContainer()),
    );
  }

  Widget _buildContainer() {
    return Container(
      height: heightConvert(context, 572),
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
          color: AppColors.background, borderRadius: BorderRadius.circular(8)),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, bottom: 48, top: 16),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    l10n(context)!.comfirm_and_payment_choose_a_discount_code!,
                    style: Styles.titleItem,
                  ),
                ),
                AppInput(
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    borderSide: BorderSide(color: AppColors.neutral300Border),
                  ),
                  onChangeValue: (value) => widget.onSearch(value),
                  iconLeft: IconEnums.search,
                  hintText: l10n(context)!.comfirm_and_payment_search,
                ),
                Expanded(
                    child: SingleChildScrollView(
                        child: Column(
                  children: [
                    _buildListDiscountCode(widget.listDiscountActive, false),
                    if (widget.listDiscountInActive.isNotEmpty)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          l10n(context)!
                              .comfirm_and_payment_discount_code_expired,
                          style: Styles.content
                              .copyWith(color: AppColors.neutral900),
                        ),
                      ),
                    _buildListDiscountCode(widget.listDiscountInActive, true)
                  ],
                ))),
              ],
            ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                margin: const EdgeInsets.only(top: 8),
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                alignment: Alignment.topCenter,
                decoration: Styles.cardButtonShadow.copyWith(
                    color: AppColors.background,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8))),
                child: AppButton(
                  title: l10n(context)!.comfirm_and_payment_apply,
                  isLeftGradient: true,
                  onPressed: () {
                    Navigator.pop(context, false);
                    widget.onApply();
                  },
                ),
              ))
        ],
      ),
    );
  }

  Widget _buildListDiscountCode(List<DiscountCode> list, bool isOutOfDate) {
    List<Widget> widgets = list
        .map((item) => DiscountCodeItem(
              onSelect: () => widget.onSave(item.uid),
              expiredDate: item.expiryDate,
              title: item.title,
              isOutOfDate: isOutOfDate,
              isCheck: !isOutOfDate && item.uid == widget.discountDialogId,
            ))
        .toList();
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
      ),
      child: Column(
        children: widgets,
      ),
    );
  }
}
