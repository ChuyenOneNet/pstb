import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/nurse_page/therapy_information/detail_therapy/detail_therapy_store.dart';
import 'package:pstb/app/modules/nurse_page/therapy_information/detail_therapy/health_care_patient/create_care/create_care_store.dart';
import 'package:pstb/app/modules/nurse_page/widgets/input_field_patient_widget.dart';
import 'package:pstb/widgets/stateless/app_bar.dart';
import 'package:pstb/widgets/stateless/app_button.dart';

class CreateHealthCarePage extends StatefulWidget {
  const CreateHealthCarePage({Key? key}) : super(key: key);

  @override
  State<CreateHealthCarePage> createState() => _CreateHealthCarePageState();
}

class _CreateHealthCarePageState extends State<CreateHealthCarePage> {
  final store = Modular.get<CreateCareStore>();
  final _form = GlobalKey<FormState>();
  late TextEditingController controllerTextBreath;
  late TextEditingController controllerTextTemperature;
  late TextEditingController controllerTextMax;
  late TextEditingController controllerTextMin;
  late TextEditingController controllerTextVessel;
  late TextEditingController controllerDevelopments;
  late TextEditingController controllerTakeCare;
  @override
  void initState() {
    controllerTextBreath = TextEditingController()
      ..addListener(() {
        store.breathing = controllerTextBreath.text;
      });
    controllerTextTemperature = TextEditingController()
      ..addListener(() {
        store.temperature = controllerTextTemperature.text;
      });
    controllerTextMax = TextEditingController()
      ..addListener(() {
        store.max = controllerTextMax.text;
      });
    controllerTextMin = TextEditingController()
      ..addListener(() {
        store.min = controllerTextMin.text;
      });
    controllerTextVessel = TextEditingController()
      ..addListener(() {
        store.pulse = controllerTextVessel.text;
      });
    controllerDevelopments = TextEditingController()
      ..addListener(() {
        store.attentionInformation = controllerDevelopments.text;
      });
    controllerTakeCare = TextEditingController()
      ..addListener(() {
        store.progression = controllerTakeCare.text;
      });
    super.initState();
  }

  @override
  void dispose() {
    controllerTextMax.dispose();
    controllerTextTemperature.dispose();
    controllerTextBreath.dispose();
    controllerTextMin.dispose();
    controllerDevelopments.dispose();
    controllerTextVessel.dispose();
    controllerTakeCare.dispose();
    Modular.dispose<CreateCareStore>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Nhập chăm sóc",
      ),
      body: GestureDetector(
        onTap: () {
          if (FocusScope.of(context).hasFocus) {
            FocusScope.of(context).unfocus();
          }
        },
        child: Padding(
            padding: const EdgeInsets.all(8),
            child: SingleChildScrollView(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  Form(
                    key: _form,
                    child: InputFieldPatientWidget(
                      enableField: true,
                      controllerTextMax: controllerTextMax,
                      controllerTextMin: controllerTextMin,
                      controllerTextVessel: controllerTextVessel,
                      controllerTextBreath: controllerTextBreath,
                      controllerDevelopments: controllerDevelopments,
                      controllerTakeCare: controllerTakeCare,
                      controllerTextTemperature: controllerTextTemperature,
                    ),
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      Flexible(
                        flex: 2,
                        child: AppButton(
                            title: "Hoàn thành",
                            onPressed: () async {
                              if (!_form.currentState!.validate()) {
                                return;
                              }
                              await store.setNursingWithPatient();
                              final detailTherapyStore =
                                  Modular.get<DetailTherapyStore>();
                              detailTherapyStore.getScheduleTreatment(
                                  detailTherapyStore.id!,
                                  getDate: detailTherapyStore.dateTimeSelected);
                              Modular.to.pop();
                              Modular.to.pop();
                            }),
                      ),
                      const Spacer(),
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
}
