import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pstb/widgets/stateless/item_text_row.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/icons.dart';
import '../../../../utils/l10n.dart';
import '../../../../utils/styles.dart';
import '../schedule_detail_store.dart';

class ScheduleExaminationPackageInfo extends StatelessWidget {
  final ScheduleDetailStore _scheduleDetailStore =
      Modular.get<ScheduleDetailStore>();
  final String? medical;
  final String? facility;

  ScheduleExaminationPackageInfo({
    Key? key,
    this.medical,
    this.facility,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
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
            Image.network(
              _scheduleDetailStore.bookingDetail?.packageImage ?? "",
              errorBuilder: (_, __, ___) {
                return const Center(child: Icon(Icons.error));
              },
              // loadingBuilder: (BuildContext context, Widget child,
              //     ImageChunkEvent? loadingProgress){
              //   if (loadingProgress == null) return child;
              //   return const Center(child: AppCircleLoading());
              // },
              height: 120,
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
            const SizedBox(
              height: 8.0,
            ),
            ItemTextRow(
              title: 'Tên dịch vụ',
              content: _scheduleDetailStore.bookingDetail?.packageName ?? '',
            ),
            ItemTextRow(
              title: 'Người khám',
              content: _scheduleDetailStore.bookingDetail?.doctorName ??
                  'Bác sĩ chỉ định',
            ),
          ],
        ),
      );
    });
  }
}
