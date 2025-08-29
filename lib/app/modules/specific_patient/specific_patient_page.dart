import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pstb/app/modules/specific_patient/specific_patient_store.dart';
import 'package:pstb/app/modules/specific_patient/widget/main_checking_widget.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';

class SpecificPatientPage extends StatefulWidget {
  const SpecificPatientPage({Key? key}) : super(key: key);

  @override
  State<SpecificPatientPage> createState() => _SpecificPatientPageState();
}

class _SpecificPatientPageState extends State<SpecificPatientPage> {
  @override
  void dispose() {
    Modular.dispose<SpecificPatientStore>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Tra cứu',
      ),
      body: ListView(
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        children: [
          const MainCheckingWidget(),
          const SizedBox(height: 50,),
          SvgPicture.asset(IconEnums.iconConsent,),
        ],
      ),
    );
  }
}
