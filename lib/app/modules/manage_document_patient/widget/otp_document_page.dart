import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pstb/app/modules/manage_document_patient/document_patient_store.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/helper.dart';
import '../../../../utils/images.dart';
import '../../../../utils/l10n.dart';
import '../../../../utils/styles.dart';
import '../../../../widgets/stateless/app_bar.dart';
import '../../../models/electronic_signature_model.dart';

class OtpDocumentPage extends StatefulWidget {
  final String transactionId;
  final List<DocumentModel> documents;

  const OtpDocumentPage(
      {Key? key, required this.transactionId, required this.documents})
      : super(key: key);

  @override
  State<OtpDocumentPage> createState() => _OtpDocumentPageState();
}

class _OtpDocumentPageState extends State<OtpDocumentPage>
    with TickerProviderStateMixin {
  final TextEditingController _textEditingController = TextEditingController();

  final DocumentPatientStore documentPatientStore =
      Modular.get<DocumentPatientStore>();

  late Timer _timer = Timer.periodic(
    const Duration(seconds: 1),
    (Timer timer) {},
  );

  void startTimer() {
    documentPatientStore.start = 60;
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (documentPatientStore.start == 0) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return CupertinoAlertDialog(
                content: Text(
                  "Mã xác thực OTP đã hết hiệu lực.\nVui lòng nhấn gửi lại để thực hiện phiên giao dịch mới.",
                  textAlign: TextAlign.center,
                  style: Styles.titleItem,
                ),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: const Text(
                      "Đồng ý",
                      style: TextStyle(color: AppColors.error700),
                    ),
                    onPressed: () async {
                      Modular.to.pop();
                    },
                  )
                ],
              );
            },
          );
          timer.cancel();
        } else {
          documentPatientStore.start--;
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
    documentPatientStore.documents.clear();
    documentPatientStore.ids.clear();
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
                    "${documentPatientStore.start % 60 < 10 ? "0${documentPatientStore.start % 60}" : documentPatientStore.start % 60}",
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
                if (documentPatientStore.start == 0) {
                  documentPatientStore.enableText = false;
                } else {
                  documentPatientStore.enableText = true;
                }
                return Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width / 2,
                  child: PinCodeTextField(
                    enabled: documentPatientStore.enableText,
                    appContext: context,
                    length: 4,
                    autoDismissKeyboard: false,
                    autoFocus: true,
                    obscureText: false,
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
                      disabledColor: AppColors.lightSilver,
                    ),
                    animationDuration: const Duration(milliseconds: 300),
                    backgroundColor: AppColors.background,
                    enableActiveFill: true,
                    errorAnimationController: null,
                    controller: _textEditingController,
                    textStyle: Styles.bodyRegular
                        .copyWith(fontWeight: FontWeight.w600),
                    keyboardType: TextInputType.number,
                    onCompleted: (value) async {
                      if (value.isEmpty) {
                        Fluttertoast.showToast(
                          msg: 'Hãy nhập mã OTP',
                        );
                      } else {
                        if (value.contains(' ')) {
                          Fluttertoast.showToast(
                            msg: 'Sai mã OTP. Vui lòng nhập lại.',
                          );
                        } else {
                          await documentPatientStore.documentsVerifyOtp(
                            value,
                            documentPatientStore.transactionId!,
                            widget.documents,
                          );
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
                    if (documentPatientStore.start == 0) {
                      return InkWell(
                        onTap: () async {
                          await documentPatientStore.prepareSignDocuments(
                              documentPatientStore.ids,
                              documentPatientStore.documentTypeCode!);
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
