import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/forgot_password/forgot_store.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateful/firebase_otp_widget.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';

class ForgotOtp extends StatefulWidget {
  final Map<String, dynamic> data;

  const ForgotOtp({Key? key, required this.data}) : super(key: key);

  @override
  _ForgotOtpState createState() => _ForgotOtpState();
}

class _ForgotOtpState extends State<ForgotOtp> {
  final ForgotStore _forgotStore = Modular.get<ForgotStore>();

  @override
  void initState() {
    _forgotStore.changePhoneNumber(widget.data['phoneNumber']);
    super.initState();
  }

  void onAgain() {}

  void onCompleted() {
    Modular.to.pushNamed(AppRoutes.forgotPage);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (EasyLoading.isShow) {
          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },
      child: Scaffold(
          backgroundColor: AppColors.background,
          appBar: CustomAppBar(
              icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.grayLight,
            size: Constants.iconBackSize,
          )),
          body: FireBaseOTPWidget(
            onAgain: onAgain,
            onCompleted: onCompleted,
            phoneNumber: widget.data['phoneNumber'],
          )),
    );
  }
}
