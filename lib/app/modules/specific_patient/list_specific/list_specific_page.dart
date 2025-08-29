import 'package:flutter/material.dart';
import 'package:pstb/app/modules/specific_patient/list_specific/widget/detail_specific_patient_widget.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';

class ListSpecificPatientPage extends StatelessWidget {
  const ListSpecificPatientPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: 'Thông tin chi tiết',
        ),
        body: const DetailSpecificPatientWidget());
  }
}
