import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/utils/main.dart';

import '../../../../../widgets/stateful/touchable_opacity.dart';
import '../../../../models/electronic_signature_model.dart';
import '../../ehr_store.dart';
import '../pdf_indication/pdf_indication_store.dart';

class DialogMedicalWidget extends StatelessWidget {
  DialogMedicalWidget({Key? key}) : super(key: key);

  final EHRStore store = Modular.get<EHRStore>();

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
        titlePadding: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              const SizedBox(
                width: 24,
              ),
              Expanded(
                child: Text('Đơn thuốc',
                    textAlign: TextAlign.center,
                    style: Styles.heading4.copyWith(color: AppColors.primary)),
              ),
              TouchableOpacity(
                onTap: () => {Navigator.pop(context)},
                child: SizedBox(
                    height: 24,
                    width: 24,
                    child: Icon(
                      Icons.close,
                      color: AppColors.primary,
                    )),
              ),
            ],
          ),
        ),
        children: [
          Observer(builder: (_) {
            return store.prescriptionData.isEmpty
                ? const Center(
                    child: Text(
                      'Không có đơn thuốc nào.',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  )
                : SizedBox(
                    height: heightConvert(context, 400),
                    child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            store.prescriptionData.length,
                            (index) => GestureDetector(
                              onTap: () async {
                                final pdfStore =
                                    Modular.get<PDFIndicationStore>();
                                await pdfStore.getImagePdfPrescription(
                                    store.prescriptionData[index]);
                                // Modular.to.pop();
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                                Modular.to.pushNamed(AppRoutes.pdfIndication,
                                    arguments: {
                                      "documentModel": DocumentModel(),
                                    });
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: AppColors.primary,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      store.prescriptionData[index].title ??
                                          "Đơn thuốc: $index",
                                      style: TextStyle(
                                          foreground:
                                              Styles.defaultGradientPaint,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )),
                    ),
                  );
          })
        ]);
  }
}
