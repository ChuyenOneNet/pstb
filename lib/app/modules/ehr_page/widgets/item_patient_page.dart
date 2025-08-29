import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pstb/utils/colors.dart';
import 'package:pstb/utils/styles.dart';

import '../../../../utils/icons.dart';
import '../../../../utils/routes.dart';
import '../../../models/medical_record_model.dart';

class ItemPatientPage extends StatelessWidget {
  final Patient patient;
  final int index;

  const ItemPatientPage({Key? key, required this.index, required this.patient})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Modular.to.pushNamed(
          AppRoutes.ehrPage,
          arguments: {'patientId': patient.id, 'phone': patient.phone},
        );
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppColors.lightSilver,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _renderValueInformation(
                      "", patient.name ?? '', context, null),
                  _renderValueInformation(
                      "Mã y tế: ",
                      patient.code ?? '',
                      context,
                      SvgPicture.asset(
                        IconEnums.patientIdentification,
                        width: 20,
                        height: 20,
                      )),
                  _renderValueInformation(
                      "Ngày sinh: ",
                      patient.dateOfBirth ?? '',
                      context,
                      SvgPicture.asset(
                        IconEnums.iconCake,
                        width: 20,
                        height: 20,
                      )),
                  _renderValueInformation(
                    "Địa chỉ: ",
                    patient.address ?? '',
                    context,
                    SvgPicture.asset(
                      IconEnums.iconLocation,
                      width: 20,
                      height: 20,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            const Icon(
              Icons.chevron_right,
              color: AppColors.lightSilver,
            )
          ],
        ),
      ),
    );
  }

  Widget _renderValueInformation(
      String title, String value, BuildContext context, Widget? icon) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                icon != null
                    ? Row(
                        children: [
                          icon,
                          const SizedBox(
                            width: 8.0,
                          ),
                        ],
                      )
                    : const SizedBox(),
                Text(
                  title,
                  style: Styles.content,
                ),
              ],
            ),
            Expanded(
              child: Text(
                value,
                style: Styles.content.copyWith(fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ));
  }
}
