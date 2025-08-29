import 'package:flutter/material.dart';

import '../../../../../../utils/colors.dart';
import '../../../../../../utils/styles.dart';

class NoteWidget extends StatelessWidget {
  const NoteWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Các lưu ý trước khi xét nghiệm:',
            style: Styles.heading4.copyWith(
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.0),
            child: Text(
              '- Nhịn đói trước khi lấy mẫu ít nhất là 6-8 tiếng, chỉ được uống nước lọc',
              style: Styles.subtitleSmallest,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.0),
            child: Text(
              '- Không ăn sáng, không uống nước ngọt, nước hoa quả, sữa, rượu... để đảm bảo kết quả chính xác',
              style: Styles.subtitleSmallest,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.0),
            child: Text(
              '- Với trường hợp đã chuẩn bị sẵn, trước khi siêu âm ổ bụng, bệnh nhân nên nhịn ăn ít nhất 6-8 giờ. Nên siêu âm vào buổi sáng.',
              style: Styles.subtitleSmallest,
            ),
          ),
        ],
      ),
    );
  }
}
