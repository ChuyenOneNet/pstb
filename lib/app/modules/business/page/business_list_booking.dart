import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:pstb/app/modules/business/page/patient_infomation.dart';
import '../../../../utils/colors.dart';
import '../../business/business_store.dart';
import '../widget/booking_history_item.dart';
import 'package:intl/intl.dart';

class BusinessListBooking extends StatefulWidget {
  BusinessListBooking({Key? key}) : super(key: key);

  @override
  State<BusinessListBooking> createState() => _BusinessListBookingState();
}

class _BusinessListBookingState extends State<BusinessListBooking> {
  final BusinessStore store = Modular.get<BusinessStore>();
  DateTime? _fromDate;
  DateTime? _toDate;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PatientInformation(),
          const SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Icon(Icons.calendar_month, color: AppColors.primary),
                    SizedBox(width: 6),
                    Text(
                      'LỊCH SỬ KHÁM, CHỮA BỆNH',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    // From date
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          final picked = await showDateRangePicker(
                            context: context,
                            firstDate: DateTime(2000),
                            lastDate: DateTime.now(),
                            initialDateRange:
                                _fromDate != null && _toDate != null
                                    ? DateTimeRange(
                                        start: _fromDate!, end: _toDate!)
                                    : null,
                          );

                          if (picked != null) {
                            setState(() {
                              _fromDate = picked.start;
                              _toDate = picked.end;
                            });
                          }
                        },
                        child: Container(
                          height: 45,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  _fromDate != null
                                      ? DateFormat('dd-MM-yyyy')
                                          .format(_fromDate!)
                                      : 'Từ ngày',
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                              const Icon(Icons.calendar_today, size: 18),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    // To date
                    Expanded(
                      child: Container(
                        height: 45,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                _toDate != null
                                    ? DateFormat('dd-MM-yyyy').format(_toDate!)
                                    : 'Đến ngày',
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                            const Icon(Icons.calendar_today, size: 18),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    // Search button
                    SizedBox(
                      height: 45,
                      width: 45,
                      child: ElevatedButton(
                        onPressed: () {
                          store.loadHistoryRecord(
                            fromDate: _fromDate,
                            toDate: _toDate,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          backgroundColor: Colors.white,
                          side: BorderSide(color: AppColors.primary),
                        ),
                        child:
                            const Icon(Icons.search, color: AppColors.primary),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Danh sách lịch sử
          Observer(builder: (_) {
            if (store.listBusiness.isEmpty) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text("Không có kết quả"),
                ),
              );
            }

            return ListView.builder(
              itemCount: store.listBusiness.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final exam = store.listBusiness[index];
                return BookingHistoryItem(business: exam);
              },
            );
          }),
        ],
      ),
    );
  }
}
