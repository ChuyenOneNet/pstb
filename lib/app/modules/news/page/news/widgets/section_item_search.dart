import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../utils/colors.dart';
import '../../../../../../utils/helper.dart';
import '../../../../../../utils/icons.dart';
import '../../../../../../utils/styles.dart';
import '../../../../../../widgets/stateful/touchable_opacity.dart';
import '../../../../../../widgets/stateless/image_network.dart';

class SectionItemSearch extends StatelessWidget {
  final String? image, title, shortDescription;
  final int? count;
  final Function? onPress;

  const SectionItemSearch(
      {Key? key,
      this.image,
      this.title,
      this.count,
      this.onPress,
      this.shortDescription})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onTap: () => {onPress != null ? onPress!() : {}},
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.background,
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: AppColors.lightSilver,
            ),
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: heightConvert(context, 16)),
        child: IntrinsicHeight(
          child: Row(
            children: [
              SizedBox(
                height: widthConvert(context, 92),
                width: widthConvert(context, 108),
                child: AppImageNetwork(
                  imageUri: image,
                  memCacheWidth: 369,
                  memCacheHeight: 315,
                  borderRadius: 8,
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(
                      left: widthConvert(context, 13),
                      right: widthConvert(context, 13)),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextContent(
                        text: title ?? '',
                        style: Styles.heading5.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      shortDescription == null
                          ? const SizedBox()
                          : TextContent(
                              text: shortDescription ?? '',
                              style: Styles.subtitleSmallest,
                            ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(IconEnums.eye),
                              TextContent(
                                text:
                                    '${count != null ? "  " + formatCurrency(count.toString()).toString() : 0} lượt xem',
                                style: Styles.descriptionNoti.copyWith(
                                  color: AppColors.grayLight,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const Icon(Icons.keyboard_arrow_right,size: 28, color: AppColors.lightSilver,)
            ],
          ),
        ),
      ),
    );
  }
}

class TextContent extends StatelessWidget {
  const TextContent({Key? key, this.style, this.text}) : super(key: key);

  final TextStyle? style;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            text ?? '',
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: style ??
                Styles.heading4.copyWith(
                  color: AppColors.black,
                ),
          ),
        ),
      ],
    );
  }
}
