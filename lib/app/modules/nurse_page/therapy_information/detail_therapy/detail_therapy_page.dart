import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/nurse_page/therapy_information/detail_therapy/detail_therapy_store.dart';
import 'package:pstb/app/modules/nurse_page/therapy_information/detail_therapy/widgets/command_and_care_widget.dart';
import 'package:pstb/app/modules/nurse_page/therapy_information/detail_therapy/widgets/detail_patient_therapy_widget.dart';
import 'package:pstb/app/modules/nurse_page/therapy_information/detail_therapy/widgets/header_patient_widget.dart';
import 'package:pstb/app/modules/nurse_page/therapy_information/therapy_information_store.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/app_bar.dart';

import 'widgets/list_time_therapy_widget.dart';

class DetailTherapyPage extends StatefulWidget {
  const DetailTherapyPage({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<DetailTherapyPage> createState() => _DetailTherapyPageState();
}

class _DetailTherapyPageState extends State<DetailTherapyPage> {
  final store = Modular.get<DetailTherapyStore>();

  @override
  void dispose() {
    Modular.dispose<TherapyInformationStore>();
    Modular.dispose<DetailTherapyStore>();
    super.dispose();
  }

  @override
  void initState() {
    store.id = widget.id;
    store.getScheduleTreatment(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Tra cứu thông tin điều trị',
      ),
      body: RefreshIndicator(
        onRefresh: store.onRefresh,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            HeaderPatientWidget(),
            const SizedBox(
              height: 16.0,
            ),
            Container(
              decoration: Styles.cardShadow.copyWith(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Thông tin điều trị, chăm sóc",
                        style: Styles.titleItem,
                      ),
                    ],
                  ),
                  const Divider(
                    color: AppColors.primary,
                  ),
                  ListTimeTherapyWidget(),
                  Observer(builder: (context) {
                    return CommandAndCareWidget(
                      commands: store.commandData,
                      healthCares: store.healthCareData,
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
