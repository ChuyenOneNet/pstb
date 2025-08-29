import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/models/electronic_signature_model.dart';
import 'package:pstb/app/modules/ehr_page/ehr_store.dart';
import 'package:pstb/app/modules/ehr_page/pages/widget_result/item_date_prescriptions_widget.dart';
import 'package:pstb/app/modules/ehr_page/pages/widget_result/item_prescriotion.dart';
import 'package:pstb/utils/date_time_custom_utils.dart';
import 'package:pstb/utils/main.dart';

class ListIndicationsWidget extends StatefulWidget {
  const ListIndicationsWidget({Key? key}) : super(key: key);

  @override
  State<ListIndicationsWidget> createState() => _ListIndicationsWidgetState();
}

class _ListIndicationsWidgetState extends State<ListIndicationsWidget> {
  final _ehrController = Modular.get<EHRStore>();
  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return ListView.builder(
        key: Key(_ehrController.currentIndexIndications.toString()),
        itemCount: _ehrController.indicationGroupByDate.length,
        shrinkWrap: true,
        primary: false,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          final dateTime =
              _ehrController.indicationGroupByDate[index].keys.toList()[0];
          final GlobalKey expansionTileKey = GlobalKey();
          return ItemDatePrescriptionWidget(
              currentIndex: index,
              expansionTileKey: expansionTileKey,
              initiallyExpanded:
                  _ehrController.currentIndexIndications == index,
              onExpansionChanged: (value) async {
                await _ehrController.loadDetailIndication(index, value);
              },
              childrenExpanded: List.generate(
                  _ehrController.listIndicationsGroupByDay.length, (index) {
                final indication =
                    _ehrController.listIndicationsGroupByDay[index];
                return ItemPrescriptionWidget(
                  prescriptions: indication.title ?? '',
                  onTap: () async {
                    await _ehrController.getDetailIndications(
                        medicalIndicationId: indication.id,
                        code: indication.code);
                    _ehrController.titleDetailPdf = indication.title ?? "";
                    _ehrController.pageSolution = 0;
                    Modular.to.pushNamed(AppRoutes.pdfIndication, arguments: {
                      "documentModel": DocumentModel(),
                    });
                  },
                );
              }),
              prescriptionsDay: DateTimeCustomUtils.parseStringEhr(
                  parseTime: DateTimeFormatPattern.dobddMMyyyy,
                  dateTime: dateTime));
        },
      );
    });
  }
}
