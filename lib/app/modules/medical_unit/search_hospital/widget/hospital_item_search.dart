import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

import '../../../../../utils/colors.dart';
import '../../../../../utils/constants.dart';
import '../../../../../utils/images.dart';
import '../../../../../utils/routes.dart';
import '../../../../../utils/styles.dart';
import '../../../../models/medical_unit/hospital_unit_model.dart';

class HospitalItemSearch extends StatelessWidget {
  final HospitalModel hospitalModel;

  const HospitalItemSearch({Key? key, required this.hospitalModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Modular.to.pushNamed(AppRoutes.detailHospitalPage, arguments: {
          "hospitalModel": hospitalModel,
        });
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.lightSilver),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 80,
              width: 80,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: CachedNetworkImage(
                  imageUrl: hospitalModel.image ?? '',
                  placeholder: (context, url) => const Center(
                    child: SizedBox(
                        width: 30,
                        height: 30,
                        child: Center(child: CircularProgressIndicator())),
                  ),
                  errorWidget: (context, url, error) => SizedBox(
                    width: 80,
                    height: 80,
                    child: Center(
                      child: Image.asset(ImageEnum.hospitalDefault),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hospitalModel.name ?? '',
                    overflow: TextOverflow.ellipsis,
                    style: Styles.heading4.copyWith(color: AppColors.black),
                  ),
                  const SizedBox(width: 4),
                  Text(
                      'Giờ làm việc: '
                          '${DateFormat(DateTimeFormatPattern.formatHHmm).format(hospitalModel.OpenedTime!.toLocal())} - ${DateFormat(DateTimeFormatPattern.formatHHmm).format(hospitalModel.ClosedTime!.toLocal())}',
                      overflow: TextOverflow.ellipsis,
                      style: Styles.subtitleSmall),
                  const SizedBox(width: 4),
                ],
              ),
            ),
            const Icon(Icons.keyboard_arrow_right,size: 28, color: AppColors.lightSilver,)
          ],
        ),
      ),
    );
  }
}
