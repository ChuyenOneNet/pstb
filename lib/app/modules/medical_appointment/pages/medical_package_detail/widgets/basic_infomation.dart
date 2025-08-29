import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';
import '../../../../../../utils/format_util.dart';
import '../models/medical_model.dart';

class BasicInformation extends StatefulWidget {
  final PackageModel data;
  const BasicInformation({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  _BasicInformationState createState() => _BasicInformationState();
}

class _BasicInformationState extends State<BasicInformation> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(
            top: widthConvert(context, 16),
            bottom: widthConvert(context, 8),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IntrinsicHeight(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: PackagePicture(
                      memCacheWidth: 342,
                      memCacheHeight: 273,
                      imageUri: widget.data.image,
                      iconUri: widget.data.icon,
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                  margin: const EdgeInsets.only(
                    left: 16,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.data.name ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Styles.titleItem,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        widget.data.description ??
                            l10n(context)!.medical_description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Styles.content,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: SvgPicture.asset(
                                    IconEnums.iconPriceMedical,
                                    color: AppColors.primary,
                                  )),
                              const SizedBox(
                                width: 4,
                              ),
                              widget.data.price != null
                                  ? Text(
                                      " ${FormatUtil.formatMoney(widget.data.price)} vnđ",
                                      style: Styles.content,
                                    )
                                  : Text(
                                      " 0 vnđ",
                                      style: Styles.content,
                                    ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: SvgPicture.asset(
                                    IconEnums.iconGift,
                                    color: Colors.amber,
                                  )),
                              widget.data.disCount != null
                                  ? Text(
                                      " ${FormatUtil.formatMoney(widget.data.disCount)} vnđ",
                                      softWrap: true,
                                      style: Styles.content,
                                    )
                                  : Text(
                                      " 0 vnđ",
                                      style: Styles.content,
                                    ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
              ],
            ),
          ),
        ),
        const Divider(
          height: 0,
          color: AppColors.lightSilver,
        )
      ],
    );
  }
}
