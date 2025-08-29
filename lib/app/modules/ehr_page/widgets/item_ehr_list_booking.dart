import 'package:flutter/material.dart';
import 'package:pstb/utils/date_time_custom_utils.dart';
import 'package:pstb/utils/main.dart';
import '../../../models/medical_record_model.dart';

class EHRItemBooking extends StatelessWidget {
  final Examination examination;
  final int index;
  final Function()? onTap;
  const EHRItemBooking(
      {Key? key, required this.examination, required this.index, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Image.asset(ImageEnum.imageEhr),
                      // const SizedBox(
                      //   width: 4,
                      // ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "Thời gian: ${DateTimeCustomUtils.parseStringEhr(dateTime: examination.time)}",
                                style: Styles.titleItem),
                            const SizedBox(
                              height: 4,
                            ),
                            Text('ICD: ${examination.icd ?? ""}',
                                maxLines: 2, style: Styles.content),
                          ],
                        ),
                      ),
                      // const SizedBox(width:4,),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: AppColors.lightSilver,
            ),
          ],
        ),
      ),
    );
  }
}
