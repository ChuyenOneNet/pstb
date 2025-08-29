import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/ehr_page/ehr_store.dart';
import 'package:pstb/app/modules/ehr_page/pages/widget_result/item_prescriotion.dart';
import 'package:pstb/utils/colors.dart';
import 'package:pstb/utils/routes.dart';
import 'package:pstb/utils/styles.dart';

import '../../../../models/electronic_signature_model.dart';

class ItemDatePrescriptionWidget extends StatelessWidget {
  ItemDatePrescriptionWidget({
    Key? key,
    required this.prescriptionsDay,
    this.onTap,
    required this.onExpansionChanged,
    this.initiallyExpanded = false,
    this.currentIndex = 0,
    this.childrenExpanded,
    required this.expansionTileKey,
    //this.expansionTileKey
  }) : super(key: key);
  final String prescriptionsDay;
  final Function()? onTap;
  final Function(bool) onExpansionChanged;
  final bool initiallyExpanded;
  final store = Modular.get<EHRStore>();
  final int currentIndex;
  final List<Widget>? childrenExpanded;
  final GlobalKey expansionTileKey;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        key: expansionTileKey,
        initiallyExpanded: initiallyExpanded,
        trailing: const SizedBox(),
        // leading: Container(
        //     height: 24,
        //     width: 24,
        //     color: AppColors.primary,
        //     alignment: Alignment.center,
        //     child: Text(
        //       initiallyExpanded ? '-' : '+',
        //       style: Styles.content.copyWith(color: Colors.white),
        //     )),
        controlAffinity: ListTileControlAffinity.leading,
        title: Text(
          prescriptionsDay,
        ),
        onExpansionChanged: (value) {
          onExpansionChanged(value);
        },
        children: childrenExpanded ??
            List.generate(store.listPrescriptionModel[currentIndex].length,
                (index) {
              final prescription =
                  store.listPrescriptionModel[currentIndex][index];
              return ItemPrescriptionWidget(
                onTap: () async {
                  await store.getDetailPrescription(
                      medicalInstructionId: prescription.ylenhId,
                      examinationId: prescription.khambenhId,
                      type: prescription.loai);
                  store.titleDetailPdf = prescription.tenloai ?? "";
                  store.pageSolution = 1;
                  Modular.to.pushNamed(AppRoutes.pdfIndication, arguments: {
                    "documentModel": DocumentModel(),
                    "index": 0,
                  });
                },
                prescriptions: prescription.tenloai ?? '',
              );
            }),
      ),
    );
  }
}
