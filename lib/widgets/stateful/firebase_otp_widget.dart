import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/utils/main.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';

class FireBaseOTPWidget extends StatefulWidget {
  FireBaseOTPWidget(
      {Key? key,
      required this.onCompleted,
      required this.onAgain,
      this.countDown = 60,
      required this.phoneNumber})
      : super(key: key);

  final Function() onCompleted;
  final Function() onAgain;
  final int countDown;
  final String phoneNumber;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  _FireBaseOTPWidgetState createState() => _FireBaseOTPWidgetState();
}

class _FireBaseOTPWidgetState extends State<FireBaseOTPWidget> {
  final TextEditingController _textEditingController = TextEditingController();
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  late Timer _timer = Timer.periodic(
    const Duration(seconds: 1),
    (Timer timer) {},
  );
  late int _start = widget.countDown;
  late int wrongTime;
  late String verificationId;
  late int? resendToken;

  @override
  void initState() {
    sendOTP();
    resetWrongTime();
    super.initState();
  }

  void resetWrongTime() {
    setState(() {
      //TODO : thay đổi về 1 để Test check
      wrongTime = 1;
    });
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void sendOTP() {
    EasyLoading.show();
    final BuildContext screenContext = context;
    widget._firebaseAuth.verifyPhoneNumber(
      phoneNumber: Constants.convertPhone(widget.phoneNumber),
      verificationCompleted: (PhoneAuthCredential credential) {
        _textEditingController.value =
            TextEditingValue(text: credential.smsCode!);
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.code);
        EasyLoading.dismiss();
        AppSnackBar.show(
            screenContext,
            AppSnackBarType.Error,
            e.code == "too-many-requests"
                ? "Bạn đã gửi quá nhiều yêu cầu! Vui lòng thử lại sau ít phút"
                : e.code);
        // l10n(screenContext)!.otp_failed!,);
        Modular.to.pop();
      },
      codeSent: (String verificationIdNew, int? resendTokenNew) {
        startTimer();
        setState(() {
          verificationId = verificationIdNew;
        });
        setState(() {
          resendToken = resendTokenNew;
        });

        EasyLoading.dismiss();
        AppSnackBar.show(
          screenContext,
          AppSnackBarType.Success,
          l10n(screenContext)!.otp_success!,
        );
      },
      timeout: const Duration(seconds: 30),
      codeAutoRetrievalTimeout: (String verificationId) {
        EasyLoading.dismiss();
        AppSnackBar.show(
          screenContext,
          AppSnackBarType.Error,
          'Timed out waiting for SMS.',
        );
      },
    );
  }

  void onCompleted(String otp) {
    if (_start <= 0) {
      AppSnackBar.show(context, AppSnackBarType.Warning,
          l10n(context)!.forgot_otp_warning_out_of_time);
    } else {
      EasyLoading.show();
      widget._firebaseAuth
          .signInWithCredential(PhoneAuthProvider.credential(
              verificationId: verificationId, smsCode: otp))
          .then((result) async {
        widget.onCompleted();
      }).catchError((error) {
        // whenWrongOtp();
        AppSnackBar.show(
            context, AppSnackBarType.Warning, "Sai mã OTP, vui lòng nhập lại");
      }).whenComplete(() => EasyLoading.dismiss());
    }
  }

  void whenWrongOtp() {
    if (wrongTime > 1) {
      setState(() {
        wrongTime--;
      });
      AppSnackBar.show(context, AppSnackBarType.Warning,
          l10n(context)!.forgot_otp_warning_wrong_otp);
    } else {
      setState(() {
        wrongTime--;
      });
      AppSnackBar.show(context, AppSnackBarType.Error,
          l10n(context)!.forgot_otp_banned_wrong_otp);
    }
  }

  void onPressAgain() {
    EasyLoading.show();
    _timer.cancel();
    setState(() {
      _start = widget.countDown;
    });
    final BuildContext screenContext = context;
    widget._firebaseAuth.verifyPhoneNumber(
      forceResendingToken: resendToken,
      phoneNumber: Constants.convertPhone(widget.phoneNumber),
      verificationCompleted: (PhoneAuthCredential credential) {
        final code = credential.smsCode;
        if (code != null) {
          _textEditingController.text = code;
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        EasyLoading.dismiss();
        AppSnackBar.show(
          screenContext,
          AppSnackBarType.Error,
          l10n(screenContext)!.otp_failed!,
        );
      },
      codeSent: (String verificationIdNew, int? resendTokenNew) {
        setState(() {
          verificationId = verificationIdNew;
        });
        setState(() {
          resendToken = resendTokenNew;
        });
        AppSnackBar.show(
          screenContext,
          AppSnackBarType.Success,
          l10n(screenContext)!.otp_success!,
        );
        startTimer();
        resetWrongTime();
        widget.onAgain();
        EasyLoading.dismiss();
      },
      timeout: const Duration(seconds: 60),
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        key: _key,
        width: widthConvert(context, 375),
        padding: EdgeInsets.symmetric(horizontal: widthConvert(context, 16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              l10n(context)!.otp_enter_otp,
              style: Styles.heading2.copyWith(color: AppColors.primary),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: heightConvert(context, 20),
              ),
              child: Image.asset(
                ImageEnum.logo_otp,
                width: widthConvert(context, 160),
                height: heightConvert(context, 160),
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: heightConvert(context, 20),
                bottom: heightConvert(context, 17),
              ),
              child: Text(
                l10n(context)!.otp_title_otp,
                style: Styles.subtitleLarge,
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: 270,
              child: PinCodeTextField(
                enabled: wrongTime > 0,
                appContext: context,
                length: 6,
                obscureText: false,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.circle,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 42,
                  fieldWidth: 42,
                  activeColor: AppColors.primary500,
                  activeFillColor: AppColors.neutral100,
                  inactiveColor: AppColors.neutral600,
                  inactiveFillColor: AppColors.neutral100,
                  selectedColor: AppColors.primary500,
                  selectedFillColor: AppColors.neutral100,
                ),
                animationDuration: const Duration(milliseconds: 300),
                backgroundColor: AppColors.background,
                enableActiveFill: true,
                errorAnimationController: null,
                controller: _textEditingController,
                textStyle:
                    Styles.bodyRegular.copyWith(fontWeight: FontWeight.w600),
                keyboardType: TextInputType.number,
                onCompleted: onCompleted,
                onChanged: (value) {},
                beforeTextPaste: (text) {
                  // ("Allowing to paste $text");
                  //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                  //but you can show anything you want here, like your pop up saying wrong paste format or etc
                  return true;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: heightConvert(context, 0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(l10n(context)!.otp_title_again,
                      style: Styles.subtitleSmall.copyWith(height: 20 / 15)),
                  SizedBox(
                    height: 20,
                    child: TextButton(
                      style: TextButton.styleFrom(
                          minimumSize: const Size.square(1),
                          padding: const EdgeInsets.all(1)),
                      onPressed: _start > 0 ? null : onPressAgain,
                      child: Text(
                        l10n(context)!.otp_btn_again,
                        style: Styles.bodyRegular.copyWith(
                            color: _start > 0 ? null : AppColors.primary),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 40,
              child: Text(
                "${_start ~/ 60} : ${_start % 60 < 10 ? "0${_start % 60}" : _start % 60}",
                style: Styles.subtitleSmall,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
