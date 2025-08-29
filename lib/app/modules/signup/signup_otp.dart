import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/signup/signup_store.dart';
import 'package:pstb/app/modules/signup/widgets/signup_process.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateful/firebase_otp_widget.dart';

class SignupOtp extends StatefulWidget {
  const SignupOtp({Key? key}) : super(key: key);

  @override
  _SignupOtpState createState() => _SignupOtpState();
}

class _SignupOtpState extends State<SignupOtp> {
  final SignupStore _controller = Modular.get<SignupStore>();
  @override
  void initState() {
    super.initState();
  }

  void onAgain() {}

  void onCompleted() {
    _controller.onRegister();
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
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: widthConvert(context, 16), vertical: 16.0),
                child: SignUpProcess(
                  currentProcess: SignUpProcessEnum.Step2,
                ),
              ),
              FireBaseOTPWidget(
                onAgain: onAgain,
                onCompleted: onCompleted,
                phoneNumber: _controller.phoneNumber,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
