import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pstb/app/modules/news/page/new_detail/new_detail_store.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateful/stateful_widget.dart';
import 'package:share_plus/share_plus.dart';

class CategoryWidget extends StatelessWidget {
  CategoryWidget({
    Key? key,
  }) : super(key: key);

  final NewsDetailStore controller = Modular.get<NewsDetailStore>();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          children: [
            ShareButton(
              controller: controller,
            ),
            const SizedBox(
              width: 16.0,
            ),
            SvgPicture.asset(
              IconEnums.eye,
              color: AppColors.black,
            ),
            SizedBox(
              width: widthConvert(context, 4),
            ),
            Text(
              controller.news.count != null
                  ? formatCurrency(controller.news.count.toString())
                  : "0",
              style: Styles.content,
            ),
            const SizedBox(
              width: 16.0,
            )
          ],
        )
      ],
    );
  }
}

class ShareButton extends StatelessWidget {
  const ShareButton({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final NewsDetailStore controller;
  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      child: Container(
        margin: EdgeInsets.only(
          left: widthConvert(context, 12),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: widthConvert(context, 9),
          vertical: widthConvert(context, 4),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.share,
              size: 16.0,
            ),
            const SizedBox(
              width: 4.0,
            ),
            Text(
              l10n(context)!.new_share!,
              style: Styles.content,
            ),
          ],
        ),
      ),
      onTap: () {
        Share.share('');
      },
    );
  }
}
