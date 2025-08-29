import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/specific_patient/checking_information_specific/checking_specific_patient_store.dart';
import 'package:pstb/app/modules/specific_patient/checking_information_specific/widget/list_patient_widget.dart';
import 'package:pstb/app/modules/specific_patient/list_specific/list_specific_store.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';

class CheckingInformationSpecificPage extends StatefulWidget {
  const CheckingInformationSpecificPage({Key? key}) : super(key: key);

  @override
  State<CheckingInformationSpecificPage> createState() =>
      _CheckingInformationSpecificPageState();
}

class _CheckingInformationSpecificPageState
    extends State<CheckingInformationSpecificPage> {
  final _controller = Modular.get<CheckingSpecificPatientStore>();
  @override
  void initState() {
    _controller.initState();
    super.initState();
  }

  @override
  void dispose() {
    Modular.dispose<ListSpecificStore>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Tra cứu thông tin chỉ định',
      ),
      body: const ListPatientWidget(),
    );
  }
}
