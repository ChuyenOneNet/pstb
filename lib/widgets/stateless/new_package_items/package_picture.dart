import 'package:flutter/material.dart';
import 'package:pstb/widgets/stateless/image_network.dart';

class PackagePicture extends StatelessWidget {
  const PackagePicture(
      {Key? key,
      this.imageUri,
      this.iconUri,
      this.imagePath,
      this.width,
      this.height,
      this.memCacheWidth,
      this.memCacheHeight
// required this.data,
      })
      : super(key: key);

// final ResultPackage data;
  final String? imageUri, iconUri, imagePath;
  final double? width;
  final double? height;
  final int? memCacheWidth;
  final int? memCacheHeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: AppImageNetwork(
        memCacheWidth: memCacheWidth,
        memCacheHeight: memCacheHeight,
        imageUri: imageUri,
        borderRadius: 10,
        size: 60,
      ),
    );
  }
}
