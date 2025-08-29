import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pstb/utils/main.dart';

class AppImageNetwork extends StatelessWidget {
  const AppImageNetwork(
      {Key? key,
      this.imageUri,
      this.borderRadius = 8,
      this.size = 48,
      this.memCacheHeight,
      this.memCacheWidth,
      this.fit})
      : super(key: key);
  final String? imageUri;
  final double? borderRadius;
  final double size;
  final int? memCacheWidth;
  final int? memCacheHeight;
  final BoxFit? fit;
  @override
  Widget build(BuildContext context) {
    final sizeConverted = heightConvert(context, size);

    if (imageUri != null) {
      return SizedBox(
        height: sizeConverted,
        width: sizeConverted,
        child: ClipRRect(
          borderRadius: BorderRadius.circular((borderRadius ?? 8.0)),
          child: CachedNetworkImage(
            imageUrl: imageUri!,
            placeholder: (context, url) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 6),
              child: LinearProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppColors.neutral400.withOpacity(0.1),
                ),
                backgroundColor: AppColors.neutral300,
                minHeight: 3,
              ),
            ),
            memCacheWidth: memCacheWidth == null ? null : memCacheWidth!,
            memCacheHeight: memCacheHeight == null ? null : memCacheHeight!,
            errorWidget: (context, url, error) =>
                const SizedBox(child: Center(child: Icon(Icons.error))),
            fit: fit ?? BoxFit.cover,
          ),
        ),
      );
    }
    return const SizedBox();
  }
}
