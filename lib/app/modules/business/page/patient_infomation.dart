import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/utils/main.dart';
import 'package:intl/intl.dart';

import '../business_store.dart';

class PatientInformation extends StatelessWidget {
  final BusinessStore store = Modular.get<BusinessStore>();

  PatientInformation({Key? key}) : super(key: key);

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
            Row(
              children: [
                Expanded(
                  child:
                      Text('I. Thông tin người bệnh', style: Styles.titleItem),
                ),
                TextButton.icon(
                  onPressed: () {
                    Modular.to.pushNamed(AppRoutes.changePasswordBusiness);
                  },
                  icon: const Icon(Icons.lock_outline, size: 18),
                  label: const Text('Đổi mật khẩu'),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.primary,
                  ),
                ),
              ],
            ),
            const Divider(
              color: AppColors.primary,
            ),
            _renderValueInformation(
                "Họ và tên: ", store.userBusiness.hoTen ?? '', context),
            _renderValueInformation(
                "Mã: ", store.userBusiness.ma ?? '', context),
            _renderValueInformation("Ngày sinh: ",
                formatDateSafe(store.userBusiness.ngaySinh), context),
            _renderValueInformation(
                "Điện thoại: ", store.userBusiness.dienThoai ?? '', context),
            _renderValueInformation(
                "Địa chỉ: ", store.userBusiness.diaChiLienHe ?? '', context),
          ],
        ),
      );
    });
  }

  String formatDateSafe(String? rawDate) {
    if (rawDate == null || rawDate.isEmpty) return 'Không rõ';
    try {
      final date = DateTime.parse(rawDate);
      return DateFormat('dd/MM/yyyy').format(date);
    } catch (_) {
      return 'Không rõ';
    }
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
