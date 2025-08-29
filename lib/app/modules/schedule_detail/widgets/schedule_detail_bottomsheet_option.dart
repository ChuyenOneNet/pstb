import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pstb/app/models/bottom_sheet_models.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateful/touchable_opacity.dart';

class BottomSheetOption extends StatelessWidget {
  final Function onPressOption;
  final List<BottomSheetOptionModel> listOption;

  const BottomSheetOption({
    Key? key,
    required this.onPressOption,
    required this.listOption,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.background,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: widthConvert(context, 16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Wrap(
                children: List.generate(
                  listOption.length,
                  (index) {
                    final label = listOption[index].label;
                    if (listOption[index].type == OptionType.title) {
                      return TitleBottomSheet(
                        label: label,
                      );
                    }
                    if (listOption[index].type == OptionType.cancel) {
                      return TouchableOpacity(
                        onTap: () => onPressOption(listOption[index]),
                        child: OptionCancelBottomSheet(
                          label: label,
                        ),
                      );
                    }
                    return TouchableOpacity(
                      onTap: () => onPressOption(listOption[index]),
                      child: OptionBottomSheet(
                        label: label,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OptionCancelBottomSheet extends StatelessWidget {
  final String label;
  const OptionCancelBottomSheet({
    Key? key,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
        vertical: widthConvert(context, 16),
      ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: AppColors.neutral200,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(
                  IconEnums.subtractIcon,
                  height: 24,
                  width: 24,
                  fit: BoxFit.cover,),
              const SizedBox(width: 16.0,),
              Text(
                label,
                style: Styles.content.copyWith(
                  color: Colors.red,
                ),
              ),
            ],
          ),
          const Icon(
            Icons.chevron_right,
            color: AppColors.lightSilver,
          ),
        ],
      ),
    );
  }
}

class OptionBottomSheet extends StatelessWidget {
  final String? label;
  const OptionBottomSheet({
    Key? key,
    this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
        vertical: widthConvert(context, 16),
      ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: AppColors.lightSilver,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(IconEnums.iconEdit,
                  fit: BoxFit.cover, color:AppColors.black.withOpacity(0.5)),
              const SizedBox(width: 16.0,),
              Text(
                label!,
                style: Styles.content,
              ),
            ],
          ),
          const Icon(
            Icons.chevron_right,
            color: AppColors.lightSilver,
          ),
        ],
      ),
    );
  }
}

class TitleBottomSheet extends StatelessWidget {
  final String label;
  const TitleBottomSheet({
    Key? key,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: AppColors.lightSilver,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            IconEnums.close,
            width: 24,
            height: 24,
            fit: BoxFit.contain,
            color: AppColors.background,
          ),
          Text(
          label,
          style: Styles.titleItem.copyWith(
          ),
        ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: AppColors.lightSilver,
              ),
              child: SvgPicture.asset(
                IconEnums.close,
                width: 24,
                height: 24,
                fit: BoxFit.contain,
                color: AppColors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
