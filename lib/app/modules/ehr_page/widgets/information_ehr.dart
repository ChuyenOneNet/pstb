import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/ehr_page/ehr_store.dart';
import 'package:pstb/utils/main.dart';

class EHRInformation extends StatelessWidget {
  final EHRStore store = Modular.get<EHRStore>();

  EHRInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Container(
        decoration: BoxDecoration(
          color: AppColors.background,
          border: Border.all(
            color: AppColors.lightSilver,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('I. Thông tin người bệnh', style: Styles.titleItem),
            const Divider(
              color: AppColors.primary,
            ),
            _renderValueInformation(
                "Họ và tên: ", store.data.patient?.name ?? '', context),
            _renderValueInformation(
                "Mã Y tế: ", store.data.patient?.code ?? '', context),
            _renderValueInformation(
                "Ngày sinh: ", store.data.patient?.dateOfBirth ?? '', context),
            _renderValueInformation(
                "Điện thoại: ", store.data.patient?.phone ?? '', context),
            _renderValueInformation(
                "Địa chỉ: ", store.data.patient?.address ?? '', context),
          ],
        ),
      );
    });
  }

  Widget _renderValueInformation(
      String title, String value, BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width / 3),
              child: Text(title, style: Styles.content),
            ),
            Flexible(
              child: Text(
                value,
                textAlign: TextAlign.end,
                style: Styles.titleItem,
              ),
            )
          ],
        ));
  }
}
