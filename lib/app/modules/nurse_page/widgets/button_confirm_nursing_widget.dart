import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pstb/app/modules/nurse_page/nurse_searching_store.dart';
import 'package:pstb/utils/l10n.dart';
import 'package:pstb/widgets/stateless/app_button.dart';
import 'package:pstb/widgets/stateless/app_snack_bar.dart';

class ButtonConfirmNursingWidget extends StatelessWidget {
  const ButtonConfirmNursingWidget({
    Key? key,
    required GlobalKey<FormState> form,
    required NurseSearchingStore nurseStore,
    required TextEditingController controllerInfoPaper,
    required TextEditingController controllerNamePaper,
    required this.controllerPatient,
  })  : _form = form,
        _nurseStore = nurseStore,
        _controllerInfoPaper = controllerInfoPaper,
        _controllerNamePaper = controllerNamePaper,
        super(key: key);

  final GlobalKey<FormState> _form;
  final NurseSearchingStore _nurseStore;
  final TextEditingController _controllerInfoPaper;
  final TextEditingController _controllerNamePaper;
  final TextEditingController controllerPatient;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        Flexible(
          flex: 2,
          child: AppButton(
            title: l10n(context).confirm,
            onPressed: () async {
              if (!_form.currentState!.validate()) {
                return;
              }
              if (!_nurseStore.isActiveSearchLocation) {
                return AppSnackBar.show(context, AppSnackBarType.Error,
                    'Kết quả trả về chưa thành công');
              }
              if (!_nurseStore.isActivePatient) {
                await _nurseStore.pressActivePatient();
                if (!_nurseStore.isActivePatient) {
                  AppSnackBar.show(context, AppSnackBarType.Error,
                      'Không tìm thấy thông tin bệnh nhân');
                  return;
                }
                return;
              }
              if (!_nurseStore.isActivePaper) {
                await _nurseStore.setNursingWithPatient();
                EasyLoading.dismiss();
              } else {
                if (_nurseStore.pickImage != null &&
                    _nurseStore.pickImage!.isNotEmpty) {
                  print('1');
                  await _nurseStore.uploadDocumentImage(
                      _nurseStore.codePatient, _nurseStore.codeNurse);
                } else {
                  await _nurseStore.uploadDocument(
                      _nurseStore.codePatient, _nurseStore.codeNurse);
                }
              }
              if (_nurseStore.isDone) {
                _nurseStore.pickImage = '';
                _nurseStore.displayImage = '';
                _nurseStore.documentPath = '';
                _controllerInfoPaper.clear();
                _controllerNamePaper.clear();
                controllerPatient.clear();
                AppSnackBar.show(context, AppSnackBarType.Success,
                    'Cập nhật thông tin thành công');
                _nurseStore.isDone = false;
                return;
              } else {
                AppSnackBar.show(context, AppSnackBarType.Error,
                    'Cập nhật không thành công');
                return;
              }
            },
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
