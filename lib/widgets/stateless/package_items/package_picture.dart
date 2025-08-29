import 'package:flutter/material.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/image_network.dart';

class PackagePicture extends StatelessWidget {
  const PackagePicture({
    Key? key,
    this.imageUri,
    this.iconUri,
    this.imagePath,
    // required this.data,
  }) : super(key: key);
  // final ResultPackage data;
  final String? imageUri, iconUri, imagePath;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: Styles.cardShadow.copyWith(
            border: Border.all(
              style: BorderStyle.solid,
              color: AppColors.primary,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          padding: const EdgeInsets.all(6),
          margin: const EdgeInsets.only(right: 6, bottom: 6),
          height: widthConvert(context, 72),
          width: widthConvert(context, 72),
          child: AppImageNetwork(
            imageUri: imageUri,
            borderRadius: 4,
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              gradient: const LinearGradient(
                begin: Alignment(-1.0, -3.0),
                end: Alignment(-0.7, 1.0),
                tileMode: TileMode.clamp,
                colors: [AppColors.yellow, AppColors.primary500],
              ),
            ),
            height: widthConvert(context, 24),
            width: widthConvert(context, 24),
            child: AppImageNetwork(
              imageUri: iconUri,
              borderRadius: 4,
            ),
          ),
        )
      ],
    );
  }
}
