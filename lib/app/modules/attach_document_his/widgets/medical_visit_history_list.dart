import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/business/business_store.dart';
import 'package:pstb/utils/routes.dart';

import '../../../models/kham_chua_benh_model.dart';
import '../medical_results_tab_view.dart';
import 'medical_visit_history_item.dart';

class MedicalVisitHistoryList extends StatelessWidget {
  const MedicalVisitHistoryList({Key? key}) : super(key: key);

  DateTime _parseDate(String? iso) {
    if (iso == null || iso.isEmpty) return DateTime(1900);
    return DateTime.tryParse(iso) ?? DateTime(1900);
  }

  DateTime _getVisitTime(KhamChuaBenhModel v) {
    return _parseDate(v.dateModified);
  }

  @override
  Widget build(BuildContext context) {
    final store = Modular.get<BusinessStore>();

    return Observer(
      builder: (_) {
        if (store.listBusiness.isEmpty ||
            store.listBusiness.first.khamChuaBenhs.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: Text('Không có kết quả')),
          );
        }

        final List<KhamChuaBenhModel> items = List<KhamChuaBenhModel>.from(
          store.listBusiness.first.khamChuaBenhs,
        );

        // ✅ Sort gần -> xa
        items.sort((a, b) => _getVisitTime(b).compareTo(_getVisitTime(a)));

        // ✅ CHỈ LẤY LẦN KHÁM GẦN NHẤT
        final latestVisit = items.first;

        return MedicalVisitHistoryItem(
          visit: latestVisit,
          onTap: () {
            final id = latestVisit.dangKyId;
            if (id == null || id.isEmpty) return;

            final business = store.userBusiness;

            Modular.to.push(
              MaterialPageRoute(
                builder: (_) => AdminInfoWithAttachmentPage(
                  userBusiness: business,
                  dangKyId: id,
                  benhNhanId: latestVisit.benhNhanId,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
