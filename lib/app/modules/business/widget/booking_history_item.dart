import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import '../../../../utils/routes.dart';
import '../../../../utils/styles.dart';
import '../../../../utils/colors.dart';
import '../../../models/business_model.dart';

class BookingHistoryItem extends StatelessWidget {
  final BusinessModel business;

  const BookingHistoryItem({
    Key? key,
    required this.business,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final examDate = business.thoiGianRa != null &&
            business.thoiGianRa!.isNotEmpty
        ? DateFormat('dd/MM/yyyy').format(DateTime.parse(business.thoiGianRa!))
        : '';

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.lightSilver),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hàng đầu tiên: ngày khám + nút
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  'Ngày khám: $examDate',
                  style: Styles.content.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  // Xử lý xem kết quả
                  Modular.to
                      .pushNamed(AppRoutes.detailBusinessPage, arguments: {
                    'idBusiness': business.dangKyId,
                  });
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'Xem KQ',
                    style: Styles.content.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Hàng thứ hai: chẩn đoán
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Chuẩn đoán: ',
                style: Styles.content.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
              Expanded(
                child: Text(
                  business.moTaIcd ?? 'Không có chẩn đoán',
                  style: Styles.content.copyWith(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
