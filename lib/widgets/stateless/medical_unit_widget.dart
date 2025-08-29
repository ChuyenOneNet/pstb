import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:pstb/widgets/stateless/app_snack_bar.dart';
import '../../app/modules/home/home_store.dart';
import '../../utils/colors.dart';
import '../../utils/images.dart';
import '../../utils/map_utils.dart';
import '../../utils/styles.dart';

class MedicalUnitWidget extends StatelessWidget {
  MedicalUnitWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final HomeStore controller;

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Text(
          'Bệnh Viện Phụ Sản Thái Bình',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Styles.content.copyWith(color: AppColors.background),
        ),
      );
    });
  }
}
