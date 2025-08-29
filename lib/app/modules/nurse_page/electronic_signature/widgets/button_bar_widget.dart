import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pstb/app/modules/nurse_page/electronic_signature/electronic_signature_store.dart';
import 'package:pstb/utils/colors.dart';
import 'package:pstb/utils/icons.dart';
import 'package:pstb/widgets/stateless/app_button.dart';

class ButtonBarWidget extends StatelessWidget {
  const ButtonBarWidget({
    Key? key,
    required ElectronicSignatureStore electronicSignatureController,
  })  : _electronicSignatureController = electronicSignatureController,
        super(key: key);

  final ElectronicSignatureStore _electronicSignatureController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: 16.0).copyWith(bottom: 50),
      child: Row(
        children: [
          Expanded(
              child: AppButton(
                  primaryColor: AppColors.error500,
                  iconLeft: IconEnums.iconUnSign,
                  title: 'Thu hồi ký',
                  onPressed: () async {
                    if (_electronicSignatureController.signedDocumentMap.isEmpty) {
                      Fluttertoast.showToast(
                          msg: 'Chưa chọn tài liệu cần huỷ ký');
                      return;
                    }
                    EasyLoading.show();
                    await _electronicSignatureController
                        .revokeSignatures();
                    EasyLoading.dismiss();
                    Fluttertoast.showToast(
                        msg: _electronicSignatureController.statusSuccess ?? '',
                        backgroundColor: _electronicSignatureController.statusSuccess == 'Hủy ký thất bại' ? AppColors.error500 : AppColors.success,);
                  })),
          const SizedBox(
            width: 16,
          ),
          Expanded(
              child: AppButton(
                  primaryColor: AppColors.sub_green,
                  iconLeft: IconEnums.iconSign,
                  title: 'Thực hiện ký',
                  onPressed: () async {
                    if (_electronicSignatureController.unSignedDocumentMap.isEmpty) {
                      Fluttertoast.showToast(msg: 'Chưa chọn tài liệu cần ký');
                      return;
                    }
                    EasyLoading.show();
                    await _electronicSignatureController.signDocuments();
                    EasyLoading.dismiss();
                    Fluttertoast.showToast(
                        msg: _electronicSignatureController.statusSuccess ?? '',
                        backgroundColor: _electronicSignatureController.statusSuccess == 'Ký thất bại' ? AppColors.error500 : AppColors.success);
                  })),
        ],
      ),
    );
  }
}
