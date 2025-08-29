import 'package:flutter/material.dart';
import 'package:pstb/utils/main.dart';

class ProcedureWidget extends StatelessWidget {
  const ProcedureWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quy trình khám và xét nghiệm gồm 4 bước:',
            style: Styles.heading4.copyWith(
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: 8),
          _renderField("Bước 1: Điều dưỡng đến tận nhà",
              "Lấy mẫu xét nghiệm và mang đến trung tâm phân tích."),
          _renderField("Bước 2: Nhận kết quả",
              "Được trả về tài khoản của bệnh nhân thông qua hệ thống website và ứng dụng pstb."),
          _renderField("Bước 3: Khám cận lâm sàng",
              "Tại Bệnh viện hoặc phòng khám của pstb trong hệ thống qua ngày hẹn, quy trình nhanh chóng tiết kiệm."),
          _renderField("Bước 4: Tư vấn 24/7",
              "Đội ngũ bác sĩ, chuyên gia sẵn sàng giải đáp và tư vấn sức khoẻ cho bệnh nhân."),
        ],
      ),
    );
  }

  Widget _renderField(String title, String description) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Styles.subtitleSmallest.copyWith(
              fontSize: 14,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 16),
            child: Text(
              description,
              style: Styles.subtitleSmallest,
            ),
          )
        ],
      ),
    );
  }
}
