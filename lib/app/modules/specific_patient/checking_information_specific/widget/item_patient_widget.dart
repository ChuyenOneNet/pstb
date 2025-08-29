import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pstb/app/models/department_model.dart';
import 'package:pstb/app/models/patient_model.dart';
import 'package:pstb/utils/gender_utils.dart';
import 'package:pstb/utils/main.dart';

import '../../../../../utils/date_time_custom_utils.dart';

class ItemPatientWidget extends StatelessWidget {
  const ItemPatientWidget(
      {Key? key, this.onTap, this.department, this.patient, required this.date})
      : super(key: key);
  final Function()? onTap;
  final DepartmentModel? department;
  final PatientQrModel? patient;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('dd/MM/yyyy');
    final date_time_random = formatter.format(date);
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Image.asset(ImageEnum.imageEhr),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          department?.name ?? '',
                          style:
                              Styles.titleItem.copyWith(color: AppColors.black),
                        ),

                        /// Nhầm name vs code của bệnh nhân
                        Text(
                          'Tên BN: ${patient?.name}',
                          style: Styles.content,
                        ),
                        Text(
                          'Mã BN: ${patient?.code}',
                          style: Styles.content,
                        ),
                        Text(
                          'Ngày khám : $date_time_random',
                          style: Styles.content,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right),
          ],
        ),

        // child: ListTile(
        //     onTap: onTap,
        //     leading: Image.asset(ImageEnum.imageEhr),
        //     title: Text(
        //       department?.name ?? '',
        //       style: Styles.titleItem.copyWith(color: AppColors.black),
        //     ),
        //     subtitle: Text(
        //         'Mã BN: ${patient?.code}\n${patient?.name}, ${GenderUtils.parseGender(patient?.gender ?? 0)}',style: Styles.content.copyWith(fontSize: 13),),
        //     trailing: const Icon(Icons.chevron_right),
        //   ),
      ),
    );
  }
}
