import 'package:flutter/material.dart';

class DetailPatientTherapyWidget extends StatelessWidget {
  const DetailPatientTherapyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Thời gian nhập viên: "),
        Text("Số ngày điều trị: 22000001190"),
        Text("Bệnh chính: "),
        Text("Bệnh kèm theo: "),
      ],
    );
  }
}