import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pstb/app/models/medical_record_model.dart';
import 'package:pstb/app/modules/ehr_page/pages/widget_result/ehr_information_medical_examination.dart';
import 'package:pstb/app/modules/ehr_page/pages/widget_result/ehr_solution.dart';
import 'package:pstb/utils/date_time_custom_utils.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/app_bar.dart';
import '../ehr_store.dart';
import '../widgets/information_ehr.dart';

class EHRResultDetails extends StatefulWidget {
  final Examination examination;

  const EHRResultDetails({Key? key, required this.examination})
      : super(key: key);

  @override
  State<EHRResultDetails> createState() => _EHRResultDetailsState();
}

class _EHRResultDetailsState extends State<EHRResultDetails> {
  final EHRStore store = Modular.get<EHRStore>();
  bool visible = true;

  @override
  void initState() {
    store.getHeaderForPdf();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: "Hồ sơ sức khoẻ chi tiết",
          isBack: true,
        ),
        backgroundColor: AppColors.background,
        body: Column(
          children: [
            Observer(builder: (_) {
              return store.loading
                  ? const SizedBox()
                  : Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          await store.initDetailExaminationState(
                              examinationRegisId: store.registrationId);
                        },
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              EHRInformation(),
                              const SizedBox(
                                height: 16.0,
                              ),
                              InformationMedicalExamination(),
                              const SizedBox(
                                height: 16.0,
                              ),
                              EhrSolution(
                                  examination: widget.examination,
                                  onTap: () {
                                    Modular.to.pushNamed(
                                        AppRoutes.pdfIndication,
                                        arguments: {
                                          "id": '',
                                          "index": 0,
                                        });
                                  }),
                            ],
                          ),
                        ),
                      ),
                    );
            })
          ],
        ));
  }
}
