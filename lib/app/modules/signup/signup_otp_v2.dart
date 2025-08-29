import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/signup/signup_store.dart';
import 'package:pstb/app/modules/signup/widgets/signup_process.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateful/firebase_otp_widget.dart';

import '../../../widgets/stateful/firebase_otp_widget_v2.dart';

class SignupOtpV2 extends StatefulWidget {
  const SignupOtpV2({Key? key}) : super(key: key);

  @override
  _SignupOtpV2State createState() => _SignupOtpV2State();
}

class _SignupOtpV2State extends State<SignupOtpV2> {
  final SignupStore _controller = Modular.get<SignupStore>();
  String? secretKey;
  @override
  void initState() {
    super.initState();
    final data = Modular.args?.data;
    if (data != null && data['secretKey'] != null) {
      secretKey = data['secretKey'] as String;
      // Nếu bạn muốn truyền vào widget con, hoặc controller thì truyền tại đây
      // Ví dụ nếu widget OTP hoặc store cần:
      // _controller.secretKey = secretKey;
    }
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: widthConvert(context, 16), vertical: 16.0),
                  child: SignUpProcess(
                    currentProcess: SignUpProcessEnum.Step2,
                  ),
                ),
                SoftOtpScreen(secretKey: secretKey),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
