import 'package:flutter/material.dart';
//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:pstb/app/modules/ehr_page/widgets/information_ehr.dart';
import 'package:pstb/app/modules/ehr_page/widgets/item_ehr_list_booking.dart';
import 'package:pstb/utils/routes.dart';
import 'package:pstb/utils/styles.dart';
import 'package:pstb/utils/time_util.dart';
import '../../../../utils/colors.dart';
import '../../../models/medical_record_model.dart';
import '../ehr_store.dart';

class EHRListBooking extends StatelessWidget {
  final EHRStore store = Modular.get<EHRStore>();
  final String patientId;
  final String phone;

  EHRListBooking({Key? key, required this.patientId, required this.phone})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // AppInput(
          //   iconLeft: IconEnums.search,
          //   hintText: 'Tìm kiếm đợt khám',
          //   iconRight: IconEnums.iconCalendarColor,
          //   sizeIconRight: 36,
          //   onTapIconRight: () async {
          //     await DatePicker.showDatePicker(
          //       context,
          //       locale: LocaleType.vi,
          //       minTime: DateTime(2000, 1, 1),
          //       maxTime: DateTime.now(),
          //       currentTime: DateFormat('dd/MM/yyyy').parse(store.selectDate),
          //       onConfirm: (date) {
          //         store.setDate(TimeUtil.format(date, TimeUtil.DDMMYYYY));
          //         if (store.selectDate.isEmpty) return;
          //         store.reloadData();
          //       },
          //     );
          //   },
          // ),
          EHRInformation(),
          const SizedBox(
            height: 8.0,
          ),
          Container(
            // height: MediaQuery.of(context).size.height / 2,
            decoration: BoxDecoration(
              color: AppColors.background,
              border: Border.all(
                color: AppColors.lightSilver,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.only(
                left: 16, right: 16, top: 16, bottom: 16.0),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('II. Tất cả đợt khám', style: Styles.titleItem),
                    InkWell(
                        onTap: () async {
                          pickDateTime(context);
                          // await DatePicker.showDatePicker(
                          //   context,
                          //   locale: LocaleType.vi,
                          //   minTime: DateTime(2000, 1, 1),
                          //   maxTime: DateTime.now(),
                          //   currentTime: DateFormat('dd/MM/yyyy')
                          //       .parse(store.selectDate),
                          //   onConfirm: (date) {
                          //     store.setDate(
                          //         TimeUtil.format(date, TimeUtil.DDMMYYYY));
                          //     if (store.selectDate.isEmpty) return;
                          //     store.reloadData(patientId, phone);
                          //   },
                          // );
                          // await DatePicker.showDatePicker(
                          //   context,
                          //   locale: LocaleType.vi,
                          //   minTime: DateTime(2000, 1, 1),
                          //   maxTime: DateTime.now(),
                          //   currentTime: store.selectDate.isNotEmpty
                          //       ? DateFormat('HH:mm dd/MM/yyyy')
                          //           .parse(store.selectDate)
                          //       : DateTime.now(),
                          //   onConfirm: (date) {
                          //     final formatted =
                          //         TimeUtil.format(date, TimeUtil.DDMMYYYY);
                          //     store.setDate(formatted); // Cập nhật ngày đã chọn
                          //
                          //     // Gọi hàm lọc dữ liệu theo ngày
                          //     if (formatted.isNotEmpty) {
                          //       store.reloadData(patientId, phone);
                          //     }
                          //   },
                          // );
                        },
                        child: const Icon(
                          Icons.filter_alt,
                          color: AppColors.primary,
                        )),
                  ],
                ),
                const Divider(
                  color: AppColors.primary,
                ),
                Observer(builder: (_) {
                  return store.data.examinations != null &&
                          store.data.examinations!.isNotEmpty
                      ? ListView.builder(
                          itemCount: store.data.examinations!.length,
                          physics: const ClampingScrollPhysics(),
                          padding: const EdgeInsets.only(top: 8),
                          shrinkWrap: true,
                          // separatorBuilder: (_, index) {
                          //   return const Divider(
                          //     color: AppColors.lightSilver,
                          //   );
                          // },
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                EHRItemBooking(
                                    onTap: () async {
                                      store.registrationId = store
                                              .data
                                              .examinations?[index]
                                              .registrationId ??
                                          '';
                                      await store.initDetailExaminationState(
                                          examinationRegisId:
                                              store.registrationId);
                                      Modular.to.pushNamed(
                                          AppRoutes.ehrResultDetails,
                                          arguments:
                                              store.data.examinations?[index]);
                                    },
                                    index: index + 1,
                                    examination:
                                        store.data.examinations?[index] ??
                                            Examination()),
                              ],
                            );
                          })
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Thời gian: ${store.selectDate}",
                              style: Styles.titleItem,
                            ),
                            Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Không có kết quả',
                                  style: Styles.content,
                                )),
                          ],
                        );
                })
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> pickDateTime(BuildContext context) async {
    // Bước 1: Lấy ngày hiện tại hoặc ngày đang chọn
    final initialDate = store.selectDate.isNotEmpty
        ? DateFormat('dd/MM/yyyy').parse(store.selectDate)
        : DateTime.now();

    // Bước 2: Chọn ngày
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000, 1, 1),
      lastDate: DateTime.now(),
      locale: const Locale('vi'),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.teal,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate == null) return; // Người dùng bấm Cancel

    // Bước 3: Chọn giờ
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initialDate),
    );

    if (pickedTime == null) return;

    // Bước 4: Gộp ngày và giờ lại
    final combinedDateTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    // Format theo yêu cầu
    final formatted = TimeUtil.format(
        combinedDateTime, 'HH:mm dd/MM/yyyy'); // ví dụ HH:mm dd/MM/yyyy
    store.setDate(formatted);

    if (formatted.isNotEmpty) {
      store.reloadData(patientId, phone);
    }
  }
}
