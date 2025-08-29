import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/image_network.dart';

class AvatarProfile extends StatelessWidget {
  final String? urlNetWork;
  final String? localPath;
  final double size;
  final bool showEditAvatar;

  const AvatarProfile(
      {Key? key,
      this.urlNetWork,
      this.localPath,
      this.size = 120,
      this.showEditAvatar = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(16),
            // BorderRadius.circular(heightConvert(context, size) / 2),
            child: localPath != null && localPath!.isNotEmpty
                ? Image.file(
                    File(localPath!),
                    fit: BoxFit.cover,
                    width: heightConvert(context, size),
                    height: heightConvert(context, size),
                  )
                : urlNetWork != null && urlNetWork!.isNotEmpty
                    ? AppImageNetwork(
                        imageUri: urlNetWork,
                        borderRadius: 0,
                        size: size,
                      )
                    : Image.asset(
                        ImageEnum.avatarDefault,
                        fit: BoxFit.cover,
                        width: heightConvert(context, size),
                        height: heightConvert(context, size),
                      )),
        if (showEditAvatar)
          Positioned(
              bottom: 0,
              right: 0,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                      color: Colors.grey.shade300,
                      child: const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.camera_alt,
                          size: 16,
                        ),
                      ))))
      ],
    );
  }
}
