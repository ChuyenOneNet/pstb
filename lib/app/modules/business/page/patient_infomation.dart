import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pstb/app/modules/business/page/business_login_page.dart';
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
            Text(
              'Thông tin người bệnh',
              style: Styles.titleItem
                  .copyWith(fontSize: 18, fontWeight: FontWeight.w600),
            ),

            // 🔹 Hai nút bên phải
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton.icon(
                  onPressed: () {
                    Modular.to.pushNamed(AppRoutes.changePasswordBusiness);
                  },
                  icon: const Icon(Icons.lock_outline, size: 18),
                  label: const Text('Đổi mật khẩu'),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    textStyle: const TextStyle(fontSize: 14),
                  ),
                ),
                Spacer(),
                TextButton.icon(
                  onPressed: () async {
                    const secure = FlutterSecureStorage();
                    await secure.delete(key: "passwordBusiness");
                    ;
                    Modular.to.pushNamedAndRemoveUntil(
                      AppRoutes.businessModule,
                      (route) => false, // Xóa hết stack
                    );
                  },
                  icon: const Icon(Icons.logout, size: 18),
                  label: const Text('Đăng xuất'),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.error500,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    textStyle: const TextStyle(fontSize: 14),
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
        children: [
          Expanded(flex: 2, child: Text(title, style: Styles.content)),
          Expanded(
              flex: 3,
              child: Text(value,
                  textAlign: TextAlign.end, style: Styles.titleItem)),
        ],
      ),
    );
  }
}
