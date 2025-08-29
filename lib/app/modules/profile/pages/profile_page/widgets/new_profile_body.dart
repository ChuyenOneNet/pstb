import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pstb/app/modules/profile/pages/profile_page/widgets/profile_gender.dart';
import 'package:pstb/app/modules/profile/pages/profile_page/widgets/tf_profile.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/divider_custom_widget.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';
import '../../../../../user_app_store.dart';
import 'login_his_widget.dart';

class NewProfileBodyWidget extends StatelessWidget {
  NewProfileBodyWidget({Key? key}) : super(key: key);

  final UserAppStore _userAppStore = Modular.get<UserAppStore>();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Column(
        children: [
          itemDisplayInfor(
            "Họ và tên",
            _userAppStore.user.fullName ?? "",
            Icon(Icons.person, color: Colors.black.withOpacity(0.4)),
          ),
          itemDisplayInfor(
            "Số điện thoại",
            _userAppStore.user.phone ?? "",
            Icon(Icons.phone, color: Colors.black.withOpacity(0.4)),
          ),
          itemDisplayInfor(
            "Email",
            _userAppStore.user.email ?? "",
            Icon(Icons.email, color: Colors.black.withOpacity(0.4)),
          ),
          itemDisplayInfor(
            "Sinh nhật",
            ((_userAppStore.user.dob ?? '').split(" "))[0],
            SizedBox(
                height: 24,
                width: 24,
                child: SvgPicture.asset(IconEnums.iconCake)),
          ),
          itemDisplayInfor(
            'Địa chỉ',
            _userAppStore.user.address ?? "",
            Icon(Icons.location_on, color: Colors.black.withOpacity(0.4)),
          ),
          Observer(builder: (_) {
            return GenderUserProfile(isMan: _userAppStore.user.gender == "m");
          }),
          const DividerCustomWidget(
            colorDivider: AppColors.transparent,
          ),
          itemDisplayInfor(
            'Số CCCD/CMTND',
            _userAppStore.user.personalId ?? "",
            SizedBox(
                height: 24,
                width: 24,
                child: Image.asset(
                  IconEnums.iconCitizenId,
                )),
          ),
          itemDisplayInfor(
            'Số bảo hiểm y tế',
            _userAppStore.user.insuranceNumber ?? "",
            SizedBox(
                height: 24,
                width: 24,
                child: Image.asset(
                  IconEnums.iconInsuranceId,
                )),
          ),
        ],
      );
    });
  }

  Widget itemDisplayInfor(String labelText, String content, Widget icon) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: icon,
              ),
              Expanded(
                child: InputDecorator(
                  decoration: InputDecoration(
                    hintText: labelText,
                    hintStyle: Styles.content,
                    labelText: labelText,
                    labelStyle: Styles.content
                        .copyWith(color: AppColors.black.withOpacity(0.5)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide:
                            const BorderSide(color: AppColors.lightSilver)),
                  ),
                  child: Text(content),
                ),
              ),
            ],
          ),
        ),
        const DividerCustomWidget(
          colorDivider: AppColors.transparent,
        ),
      ],
    );
  }
}
