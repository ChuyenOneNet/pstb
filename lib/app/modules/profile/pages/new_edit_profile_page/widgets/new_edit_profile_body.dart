import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/profile/pages/new_edit_profile_page/widgets/dob_edit_profile.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/divider_custom_widget.dart';
import '../../../../../../utils/icons.dart';
import '../../../../../user_app_store.dart';
import '../../edit_profile_page/edit_profile_store.dart';
import 'edit_profile_gender.dart';
import 'new_edit_profile_tf.dart';

class NewEditProfileBodyWidget extends StatelessWidget {
  final UserAppStore _appStore = Modular.get<UserAppStore>();
  final EditProfileStore _controller = Modular.get<EditProfileStore>();

  NewEditProfileBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 8,
        ),
        NewEditProfileTextField(
            textCapitalization: TextCapitalization.words,
            onChangeValue: _controller.onChangeFullName,
            readOnly: false,
            hintText: 'Nhập họ và tên',
            icon: Icon(Icons.person, color: Colors.black.withOpacity(0.4)),
            labelText: _appStore.user.fullName ?? ""),
        const DividerCustomWidget(
          colorDivider: AppColors.transparent,
        ),
        NewEditProfileTextField(
            isEnable: false,
            readOnly: false,
            hintText: 'Nhập số điện thoại',
            keyboardType: TextInputType.phone,
            onChangeValue: _controller.onChangePhone,
            icon: Icon(Icons.phone, color: Colors.black.withOpacity(0.4)),
            labelText: _appStore.user.phone ?? ""),
        const DividerCustomWidget(
          colorDivider: AppColors.transparent,
        ),
        NewEditProfileTextField(
            hintText: 'Nhập địa chỉ email',
            readOnly: false,
            onChangeValue: _controller.onChangeEmail,
            icon: Icon(Icons.email, color: Colors.black.withOpacity(0.4)),
            labelText: _appStore.user.email ?? ""),
        const DividerCustomWidget(
          colorDivider: AppColors.transparent,
        ),
        DobEditProfile(),
        const DividerCustomWidget(
          colorDivider: AppColors.transparent,
        ),
        NewEditProfileTextField(
            onChangeValue: _controller.onChangeAddress,
            readOnly: false,
            hintText: "Nhập địa chỉ thường trú",
            icon: Icon(Icons.location_on, color: Colors.black.withOpacity(0.4)),
            labelText: _appStore.user.address ?? ""),
        const DividerCustomWidget(
          colorDivider: AppColors.transparent,
        ),
        const EditGenderUserProfile(),
        const DividerCustomWidget(
          colorDivider: AppColors.transparent,
        ),
        NewEditProfileTextField(
            hintText: 'Nhập số CMTND/CCCD',
            readOnly: false,
            keyboardType: TextInputType.number,
            onChangeValue: _controller.onChangePersonalId,
            icon: SizedBox(
                height: 24,
                width: 24,
                child: Image.asset(IconEnums.iconCitizenId)),
            labelText: _appStore.user.personalId ?? ''),
        const DividerCustomWidget(
          colorDivider: AppColors.transparent,
        ),
        NewEditProfileTextField(
            keyboardType: TextInputType.number,
            readOnly: false,
            onChangeValue: _controller.onChangeInsuranceNumber,
            hintText: 'Nhập số bảo hiểm y tế',
            icon: SizedBox(
                height: 24,
                width: 24,
                child: Image.asset(IconEnums.iconInsuranceId)),
            labelText: _appStore.user.insuranceNumber ?? ''),
        const DividerCustomWidget(
          colorDivider: AppColors.transparent,
        ),
      ],
    );
  }
}
