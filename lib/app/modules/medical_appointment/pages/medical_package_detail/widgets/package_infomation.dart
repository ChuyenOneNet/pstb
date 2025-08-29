import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pstb/app/modules/medical_appointment/pages/medical_package_detail/models/medical_model.dart';

import '../../../../../../utils/colors.dart';
import '../../../../../../utils/format_util.dart';
import '../../../../../../utils/icons.dart';
import '../../../../../../utils/routes.dart';
import '../../../../../../utils/styles.dart';
import '../../../../../../widgets/stateful/touchable_opacity.dart';
import '../../../medical_appointment_store.dart';

class PackageInformation extends StatelessWidget {
  final MedicalAppointmentStore _appointmentStore =
      Modular.get<MedicalAppointmentStore>();
  final PackageModel data;

  PackageInformation({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
                width: 12,
                height: 12,
                child: SvgPicture.asset(IconEnums.iconPrice)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('TỔNG GÓI',
                    style: TextStyle(fontSize: 7, fontFamily: 'InterLight')),
                Text(FormatUtil.formatMoney(data.price).toString() + "đ",
                    style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'InterExtraBold',
                        color: AppColors.primary)),
              ],
            )
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            data.disCount == 0 || data.disCount == null
                ? const SizedBox()
                : Padding(
                    padding: const EdgeInsets.only(bottom: 2.0),
                    child: Row(
                      children: const [
                        SizedBox(width: 12),
                        Text('TẶNG',
                            style: TextStyle(
                                fontSize: 8, fontFamily: 'InterLight')),
                      ],
                    ),
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                data.disCount == 0 || data.disCount == null
                    ? const SizedBox()
                    : Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 4),
                        decoration: BoxDecoration(
                            gradient: Styles.backgroundGradient,
                            borderRadius: BorderRadius.circular(4)),
                        child: Row(
                          children: [
                            SizedBox(
                                width: 12,
                                height: 12,
                                child: SvgPicture.asset(IconEnums.iconGift)),
                            Text(
                              FormatUtil.formatMoney(data.disCount) + 'đ',
                              softWrap: true,
                              style: TextStyle(
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'InterExtraBold',
                                  color: AppColors.primary),
                            ),
                          ],
                        ),
                      ),
                // Spacer(),
                TouchableOpacity(
                  onTap: () {
                    _appointmentStore.addPackageToShowed(data);
                    _appointmentStore.setPackageDetail(data);
                    Modular.to.pushNamed(AppRoutes.medicalPackageDetail);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: AppColors.primary),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text('Chi tiết',
                        style: TextStyle(
                            fontSize: 8,
                            foreground: Styles.defaultGradientPaint)),
                  ),
                )
              ],
            ),
          ],
        )
      ],
    ));
  }
}
