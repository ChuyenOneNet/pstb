import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/icons.dart';
import '../../../../utils/styles.dart';
import '../../../../widgets/stateful/touchable_opacity.dart';
import '../ehr_store.dart';
import 'item_patient_page.dart';

class PatientInfomation extends StatelessWidget {
  final EHRStore store = Modular.get<EHRStore>();
  PatientInfomation({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: Observer(builder: (_) {
                return store.listPatient.isNotEmpty ? ListView.builder(
                    itemCount: store.listPatient.length ,
                    physics: const ClampingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return ItemPatientPage(
                        index: index + 1,
                        patient: store.listPatient[index],);
                    }) : const SizedBox();
              }),
            ),
          ),
        ],
      ),
    );
  }
}
