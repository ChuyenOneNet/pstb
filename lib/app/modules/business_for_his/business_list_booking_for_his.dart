import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

import 'package:pstb/app/modules/business/page/patient_infomation.dart';
import '../../../../utils/colors.dart';
import '../business/business_store.dart';
import '../business/widget/booking_history_item.dart';

class BusinessListBookingForHis extends StatefulWidget {
  const BusinessListBookingForHis({Key? key}) : super(key: key);

  @override
  State<BusinessListBookingForHis> createState() =>
      _BusinessListBookingForHisState();
}

class _BusinessListBookingForHisState extends State<BusinessListBookingForHis> {
  final BusinessStore store = Modular.get<BusinessStore>();
  DateTime? _fromDate;
  DateTime? _toDate;

  void _pickDate({required bool isFrom}) {
    showDatePicker(
      context: context,
      initialDate:
          isFrom ? (_fromDate ?? DateTime.now()) : (_toDate ?? DateTime.now()),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      helpText: isFrom ? 'Chọn ngày bắt đầu' : 'Chọn ngày kết thúc',
      locale: const Locale('vi', 'VN'),
    ).then((picked) {
      if (picked != null) {
        setState(() {
          if (isFrom) {
            _fromDate = picked;
          } else {
            _toDate = picked;
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PatientInformation(isHis: true),
          const SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Thông tin khám bệnh',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.primary,
                  ),
                ),
                // Row(
                //   children: const [
                //     Icon(Icons.calendar_month, color: AppColors.primary),
                //     SizedBox(width: 6),
                //     Text(
                //       'LỊCH SỬ KHÁM, CHỮA BỆNH',
                //       style: TextStyle(
                //         fontWeight: FontWeight.bold,
                //         fontSize: 16,
                //         color: AppColors.primary,
                //       ),
                //     ),
                //   ],
                // ),
                const SizedBox(height: 8),
                // Row(
                //   children: [
                //     Expanded(
                //       child: GestureDetector(
                //         onTap: () => _pickDate(isFrom: true),
                //         child: Container(
                //           height: 45,
                //           padding: const EdgeInsets.symmetric(horizontal: 12),
                //           decoration: BoxDecoration(
                //             border: Border.all(color: Colors.grey.shade400),
                //             borderRadius: BorderRadius.circular(6),
                //           ),
                //           child: Row(
                //             children: [
                //               Expanded(
                //                 child: Text(
                //                   _fromDate != null
                //                       ? DateFormat('dd-MM-yyyy')
                //                           .format(_fromDate!)
                //                       : 'Từ ngày',
                //                   style: const TextStyle(fontSize: 14),
                //                 ),
                //               ),
                //               const Icon(Icons.calendar_today, size: 18),
                //             ],
                //           ),
                //         ),
                //       ),
                //     ),
                //     const SizedBox(width: 8),
                //     Expanded(
                //       child: GestureDetector(
                //         onTap: () => _pickDate(isFrom: false),
                //         child: Container(
                //           height: 45,
                //           padding: const EdgeInsets.symmetric(horizontal: 12),
                //           decoration: BoxDecoration(
                //             border: Border.all(color: Colors.grey.shade400),
                //             borderRadius: BorderRadius.circular(6),
                //           ),
                //           child: Row(
                //             children: [
                //               Expanded(
                //                 child: Text(
                //                   _toDate != null
                //                       ? DateFormat('dd-MM-yyyy')
                //                           .format(_toDate!)
                //                       : 'Đến ngày',
                //                   style: const TextStyle(fontSize: 14),
                //                 ),
                //               ),
                //               const Icon(Icons.calendar_today, size: 18),
                //             ],
                //           ),
                //         ),
                //       ),
                //     ),
                //     const SizedBox(width: 8),
                //     SizedBox(
                //       height: 45,
                //       width: 45,
                //       child: ElevatedButton(
                //         onPressed: () {
                //           store.loadHistoryRecord(
                //             fromDate: _fromDate,
                //             toDate: _toDate,
                //           );
                //         },
                //         style: ElevatedButton.styleFrom(
                //           padding: EdgeInsets.zero,
                //           shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(6),
                //           ),
                //           backgroundColor: Colors.white,
                //           side: const BorderSide(color: AppColors.primary),
                //         ),
                //         child:
                //             const Icon(Icons.search, color: AppColors.primary),
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),

          // Danh sách lịch sử KHÁM - chỉ hiển thị 1 bản ghi GẦN NHẤT
          Observer(
            builder: (_) {
              final list = store.listBusiness;
              if (list.isEmpty || list.first.khamChuaBenhs.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text("Không có kết quả"),
                  ),
                );
              }

              // 🔥 Sắp xếp giảm dần theo thời gian ra (latest first)
              final sortedList = List.of(list.first.khamChuaBenhs)
                ..sort((a, b) {
                  final aDate =
                      DateTime.tryParse(a.thoiGianRa ?? '') ?? DateTime(1900);
                  final bDate =
                      DateTime.tryParse(b.thoiGianRa ?? '') ?? DateTime(1900);
                  return bDate.compareTo(aDate);
                });

              final latest = sortedList.first;

              return BookingHistoryItem(isHis: true, khamChuaBenhs: latest);
            },
          ),
        ],
      ),
    );
  }
}
