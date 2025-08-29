import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/nurse_page/therapy_information/detail_therapy/health_care_patient/healthcare_store.dart';
import 'package:pstb/app/modules/nurse_page/widgets/input_field_patient_widget.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';

class HealthCarePage extends StatefulWidget {
  const HealthCarePage({Key? key}) : super(key: key);

  @override
  State<HealthCarePage> createState() => _HealthCarePageState();
}

class _HealthCarePageState extends State<HealthCarePage> {
  final _form = GlobalKey<FormState>();
  final store = Modular.get<HealthCareStore>();
  @override
  void initState() {
    store.id = Modular.args?.data["id"];
    store.getDetailHealthCare();
    super.initState();
  }

  @override
  void dispose() {
    Modular.dispose<HealthCareStore>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Thông tin chăm sóc",
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          Observer(builder: (context) {
            return Form(
                key: _form,
                child: InputFieldPatientWidget(
                  takeCare: store.nurseModel?.progression,
                  textBreath: store.nurseModel?.breathing.toString(),
                  textTemperature: store.nurseModel?.temperature.toString(),
                  textMax: store.nurseModel?.bloodPressureMax,
                  textMin: store.nurseModel?.bloodPressureMin,
                  developments: store.nurseModel?.disease,
                ));
          }),
          Row(
            children: [
              const Spacer(),
              Flexible(
                flex: 2,
                child: AppButton(
                    title: "Thêm chăm sóc mới",
                    onPressed: () async {
                      Modular.to.pushNamed(AppRoutes.createHealthCare);
                    }),
              ),
              const Spacer(),
            ],
          )
        ],
      ),
    );
  }
}
