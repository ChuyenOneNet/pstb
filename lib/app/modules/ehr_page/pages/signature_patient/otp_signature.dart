import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pstb/app/models/electronic_signature_model.dart';
import 'package:pstb/app/modules/ehr_page/ehr_store.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../../utils/colors.dart';
import '../../../../../utils/helper.dart';
import '../../../../../utils/images.dart';
import '../../../../../utils/l10n.dart';
import '../../../../../utils/styles.dart';

class OtpSignaturePatient extends StatefulWidget {
  final String transactionId;
  final DocumentModel documentModel;

  const OtpSignaturePatient({
    Key? key,
    required this.transactionId,
    required this.documentModel,
  }) : super(key: key);

  @override
  State<OtpSignaturePatient> createState() => _OtpSignaturePatientState();
}

class _OtpSignaturePatientState extends State<OtpSignaturePatient> {
  final TextEditingController _textEditingController = TextEditingController();

  final EHRStore ehrStore = Modular.get<EHRStore>();

  late Timer _timer = Timer.periodic(
    const Duration(seconds: 1),
    (Timer timer) {},
  );

  void startTimer() {
    ehrStore.start = 60;
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (ehrStore.start == 0) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return CupertinoAlertDialog(
                content: Text(
                  "Mã xác thực OTP đã hết hiệu lực.\nVui lòng nhấn gửi lại để thực hiện phiên giao dịch mới.",
                  textAlign: TextAlign.center,
                  style: Styles.subtitleSmallest,
                ),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: const Text(
                      "Đồng ý",
                      style: TextStyle(color: AppColors.error700),
                    ),
                    onPressed: () {
                      Modular.to.pop();
                    },
                  )
                ],
              );
            },
          );
          timer.cancel();
        } else {
          ehrStore.start--;
        }
      },
    );
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Xác thực OTP',
      ),
      body: SingleChildScrollView(
        child: Container(
          // key: _key,
          width: widthConvert(context, 375),
          padding: EdgeInsets.symmetric(horizontal: widthConvert(context, 16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                ImageEnum.logo_otp_2,
                width: widthConvert(context, 200),
                height: heightConvert(context, 200),
                fit: BoxFit.contain,
              ),
              Text(
                'Nhập mã xác thực',
                textAlign: TextAlign.center,
                style: Styles.heading4.copyWith(color: AppColors.black),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 16.0,
                  top: 8.0,
                ),
                child: Observer(builder: (context) {
                  return Text(
                    "${ehrStore.start % 60 < 10 ? "0${ehrStore.start % 60}" : ehrStore.start % 60}",
                    style: Styles.heading4.copyWith(
                      fontSize: 25.0,
                      color: AppColors.error500,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  );
                }),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  'Vui lòng nhập mã OTP được gửi tới số điện thoại của bạn',
                  textAlign: TextAlign.center,
                  style:
                      Styles.subtitleSmallest.copyWith(color: AppColors.black),
                ),
              ),
              Observer(builder: (context) {
                if (ehrStore.start == 0) {
                  ehrStore.enableText = false;
                } else {
                  ehrStore.enableText = true;
                }
                return Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width / 2,
                  child: PinCodeTextField(
                    enabled: ehrStore.enableText,
                    appContext: context,
                    length: 4,
                    autoDismissKeyboard: false,
                    autoFocus: true,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 42,
                      fieldWidth: 42,
                      activeColor: AppColors.primary,
                      activeFillColor: AppColors.lightSilver,
                      inactiveColor: AppColors.lightSilver,
                      inactiveFillColor: AppColors.lightSilver,
                      selectedColor: AppColors.primary,
                      selectedFillColor: AppColors.lightSilver,
                    ),
                    animationDuration: const Duration(milliseconds: 300),
                    backgroundColor: AppColors.background,
                    enableActiveFill: true,
                    controller: _textEditingController,
                    textStyle: Styles.bodyRegular
                        .copyWith(fontWeight: FontWeight.w600),
                    keyboardType: TextInputType.number,
                    onCompleted: (value) async {
                      if (value.isEmpty) {
                        Fluttertoast.showToast(msg: 'Hãy nhập mã OTP');
                      } else {
                        if (value.contains(' ')) {
                          Fluttertoast.showToast(
                              msg: 'Sai mã OTP. Vui lòng nhập lại.');
                        } else {
                          await ehrStore.patientVerifyOtp(value,
                              ehrStore.transactionId!, widget.documentModel);
                        }
                      }
                      _textEditingController.clear();
                    },
                    onChanged: (value) {},
                    beforeTextPaste: (text) {
                      // ("Allowing to paste $text");
                      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                      //but you can show anything you want here, like your pop up saying wrong paste format or etc
                      return true;
                    },
                  ),
                );
              }),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    l10n(context)!.otp_title_again,
                    style: Styles.subtitleSmallest,
                  ),
                  Observer(builder: (context) {
                    if (ehrStore.start == 0) {
                      return InkWell(
                        onTap: () async {
                          await ehrStore.prepareSignPatient(
                              widget.documentModel.id!,
                              widget.documentModel.documentTypeCode!);
                          startTimer();
                        },
                        child: Text(
                          l10n(context)!.otp_btn_again,
                          style: Styles.subtitleSmallest.copyWith(
                            color: AppColors.primary,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
