import 'dart:io';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:pstb/widgets/stateless/app_bar.dart';

class ImagePreviewPage extends StatelessWidget {
  final File file;

  const ImagePreviewPage({Key? key, required this.file}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Xem tài liệu',
        isBack: true,
      ),
      backgroundColor: Colors.black,
      body: PhotoView(
        imageProvider: FileImage(file),
        minScale: PhotoViewComputedScale.contained,
        maxScale: PhotoViewComputedScale.covered * 2.5,
      ),
    );
  }
}
