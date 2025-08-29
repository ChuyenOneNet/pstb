import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/home/offer_detail/promotion_detail_store.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';

class PromotionDetailPage extends StatefulWidget {
  final dynamic id;
  const PromotionDetailPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _PromotionDetailPageState createState() => _PromotionDetailPageState();
}

class _PromotionDetailPageState
    extends ModularState<PromotionDetailPage, PromotionDetailStore> {
  @override
  void initState() {
    controller.initialScreen(
      offerId: widget.id,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: CustomAppBar(
            textStyle: Styles.heading5.copyWith(
              color: AppColors.background,
              fontWeight: FontWeight.w600,
            ),
            title: controller.promoteNews.title ?? "",
          ),
          body: controller.loading
              ? const SizedBox()
              : Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: widthConvert(context, 12),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            top: heightConvert(context, 8),
                            bottom: heightConvert(context, 4),
                          ),
                          height: widthConvert(context, 180),
                          width: widthConvert(context, 351),
                          child: AppImageNetwork(
                            borderRadius: 8,
                            imageUri: controller.promoteNews.image,
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.symmetric(
                            vertical: heightConvert(context, 4),
                          ),
                          child: Text(
                            controller.promoteNews.title ?? "",
                            style: Styles.heading4.copyWith(
                              color: AppColors.neutral900,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.symmetric(
                              vertical: heightConvert(context, 8),
                            ),
                            child: Html(
                                data: controller.promoteNews.description ?? ""))
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
