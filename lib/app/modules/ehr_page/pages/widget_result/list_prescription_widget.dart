import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/ehr_page/ehr_store.dart';
import 'package:pstb/utils/date_time_custom_utils.dart';

import 'item_date_prescriptions_widget.dart';

class ListPrescriptionWidget extends StatelessWidget {
  ListPrescriptionWidget({Key? key, required this.length}) : super(key: key);
  final store = Modular.get<EHRStore>();
  final int length;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: Key(store.currentIndexPrescriptions.toString()),
      itemBuilder: (_, index) {
        final date = store.prescriptionDate[index];
        final GlobalKey expansionTileKey = GlobalKey();
        return Observer(builder: (context) {
          return ItemDatePrescriptionWidget(
            expansionTileKey: expansionTileKey,
            currentIndex: index,
            initiallyExpanded: store.currentIndexPrescriptions == index,
            onExpansionChanged: (value) async {
              EasyLoading.show();
              await store.loadListPrescription(date, index, value: value);
              EasyLoading.dismiss();
              // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
              //   final keyContext = expansionTileKey.currentContext;
              //   if (keyContext != null) {
              //     await Future.delayed(timeStamp);
              //     await Scrollable.ensureVisible(keyContext, duration: timeStamp);
              //   }
              // });
            },
            prescriptionsDay: DateTimeCustomUtils.parseDateIso(dateTime: date),
          );
        });
      },
      itemCount: length,
      shrinkWrap: true,
      primary: false,
      padding: const EdgeInsets.only(bottom: 8),
    );
  }
}
