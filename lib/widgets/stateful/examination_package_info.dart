import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pstb/app/modules/home/home_store.dart';
import 'package:pstb/app/modules/medical_appointment/medical_appointment_store.dart';
import 'package:pstb/app/modules/medical_appointment/pages/confirm_and_payment/models/booking_info.dart';
import 'package:pstb/app/modules/medical_appointment/pages/doctor_info/doctor_info_store.dart';
import 'package:pstb/app/modules/medical_appointment/pages/medical_package_detail/models/medical_model.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/item_text_row.dart';

class ExaminationPackageInfo extends StatelessWidget {
  final MedicalAppointmentStore _medicalAppointmentStore =
      Modular.get<MedicalAppointmentStore>();
  final DoctorInfoStore _doctorInfoStore = Modular.get<DoctorInfoStore>();
  final BookingInfo paymentInfo;
  final String? medical;
  final String? facility;

  ExaminationPackageInfo({
    Key? key,
    required this.paymentInfo,
    this.medical,
    this.facility,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      final PackageModel package = _medicalAppointmentStore.selectedPackage;
      return Container(
        width: double.infinity,
        decoration: Styles.cardShadow.copyWith(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Thông tin gói khám',
                  style: Styles.titleItem,
                ),
              ],
            ),
            const Divider(
              color: AppColors.primary,
            ),
            const SizedBox(
              height: 4.0,
            ),
            Center(
              child: Image.network(
                package.image ?? '',
                errorBuilder: (_, __, ___) {
                  return const Icon(Icons.error);
                },
                height: 120,
                width: double.infinity,
                fit: BoxFit.fitWidth,
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            ItemTextRow(
              title: 'Tên dịch vụ',
              content: paymentInfo.packageName ?? '',
            ),
            ItemTextRow(
              title: 'Người khám',
              content: _doctorInfoStore.doctorData.name ?? 'Bác sĩ chỉ định',
            ),
            if (medical != null && medical!.isNotEmpty)
              Column(
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        IconEnums.iconNurse,
                        width: 24,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        'Triệu chứng',
                        style: Styles.subtitleSmallest,
                      ),
                    ],
                  ),
                  Text(
                    medical!,
                    style: Styles.subtitleSmallest,
                  )
                ],
              ),
          ],
        ),
      );
    });
  }
}
