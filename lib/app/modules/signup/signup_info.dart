import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:pstb/app/modules/signup/signup_store.dart';
import 'package:pstb/app/modules/signup/widgets/signup_process.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/utils/time_util.dart';
import 'package:pstb/widgets/stateful/stateful_widget.dart';
import 'package:pstb/widgets/stateless/app_button.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';

class SignupInfo extends StatefulWidget {
  const SignupInfo({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SignupInfoState();
  }
}

class SignupInfoState extends State<SignupInfo> {
  final SignupStore _store = Modular.get<SignupStore>();
  final _formKey = GlobalKey<FormState>();

  void buildMaterialDatePicker(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ))!;
    _store.onChangeBirthday(TimeUtil.format(picked, TimeUtil.ViewDateFormat));
  }

  void buildCupertinoDatePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height / 3,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (picked) {
                //print(TimeUtil.format(picked, TimeUtil.ViewDateFormat));
                // if (TimeUtil.format(picked, TimeUtil.ViewDateFormat) !=
                //     _store.birthday) {
                _store.onChangeBirthday(
                    TimeUtil.format(picked, TimeUtil.ViewDateFormat));
                // }
              },
              initialDateTime: DateTime.now(),
              minimumYear: 1900,
              maximumYear: DateTime.now().year,
            ),
          );
        });
  }

  void handleDatePicker(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    switch (theme.platform) {
      case TargetPlatform.android:
        return buildMaterialDatePicker(context);
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
      case TargetPlatform.iOS:
        return buildCupertinoDatePicker(context);
      case TargetPlatform.macOS:
    }
  }

  @override
  void initState() {
    _store.changeBuildContext(context);
    super.initState();
  }

  void onSubmit() {
    _store.onAddInfo();
  }

  void onBackHome() {
    Modular.to.pop();
  }

  @override
  Widget build(BuildContext context) {
    var route = ModalRoute.of(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: WillPopScope(
        onWillPop: () {
          return Future.value(false);
        },
        child: Scaffold(
          // resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Observer(
                builder: (_) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: widthConvert(context, 16),
                            vertical: 16.0),
                        child: SignUpProcess(
                          currentProcess: SignUpProcessEnum.Step3,
                          onBackStep3: route!.settings.arguments == "form_home"
                              ? onBackHome
                              : null,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            Align(
                              child: Text(
                                l10n(context)!
                                    .sign_up_information_your_information,
                                style: Styles.heading2
                                    .copyWith(color: AppColors.primary),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 8.0),
                              child: Text(
                                l10n(context)!.sign_up_information_subtitle,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Form(
                              key: _formKey,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      AppInput(
                                        onChangeValue: _store.onChangeFullName,
                                        hintText:
                                            l10n(context)!.sign_up_full_name,
                                        iconLeft: IconEnums.user,
                                        // iconRight: IconEnums.close,
                                        validationError:
                                            _store.validateFullName,
                                      ),
                                      // AppInput(
                                      //   isDisable: false,
                                      //   value: _store.birthday,
                                      //   hintText:
                                      //       l10n(context)!.sign_up_birthday,
                                      //   iconLeft: IconEnums.cake,
                                      //   iconRight: IconEnums.calendar,
                                      //   onTapIconRight: () {
                                      //     handleDatePicker(context);
                                      //   },
                                      //   onChangeValue: _store.onChangeBirthday,
                                      //   validationError:
                                      //       _store.validateBirthday,
                                      // ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 6.0),
                                        child: TextFormField(
                                          onChanged: _store.onChangeBirthday,
                                          controller: _store.dobController,
                                          inputFormatters: [
                                            MaskTextInputFormatter(
                                                mask: '##/##/####',
                                                filter: {"#": RegExp(r'[0-9]')})
                                          ],
                                          decoration:
                                              Styles.dobDecoration.copyWith(
                                            suffixIcon: IconButton(
                                                onPressed: () {
                                                  handleDatePicker(context);
                                                },
                                                icon: SvgPicture.asset(
                                                  IconEnums.calendar,
                                                  width: 16,
                                                  height: 16,
                                                  color: AppColors.primary,
                                                  fit: BoxFit.contain,
                                                )),
                                            hintText:
                                                l10n(context)!.sign_up_birthday,
                                            hintStyle: Styles.bodyRegular
                                                .copyWith(
                                                    color: AppColors.grayLight),
                                          ),
                                        ),
                                      ),
                                      AppInput(
                                        onChangeValue: _store.onChangeEmail,
                                        hintText: l10n(context)!.sign_up_email,
                                        iconLeft: IconEnums.mail,
                                        // iconRight: IconEnums.close,
                                        validationError: _store.validateEmail,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(36.0),
                                        child: Text(l10n(context)!
                                            .sign_up_information_select_gender),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            TouchableOpacity(
                                              child: Opacity(
                                                child: Column(
                                                  children: [
                                                    Image.asset(
                                                      ImageEnum.maleImage,
                                                      width: 105,
                                                      fit: BoxFit.contain,
                                                    ),
                                                    Text(
                                                      l10n(context)!.male,
                                                      style: Styles.bodyBold
                                                          .copyWith(
                                                              color: AppColors
                                                                  .neutral600),
                                                    )
                                                  ],
                                                ),
                                                opacity:
                                                    _store.isMale ? 1 : 0.5,
                                              ),
                                              onTap: () =>
                                                  _store.onSelectGenderMale(),
                                            ),
                                            TouchableOpacity(
                                              child: Opacity(
                                                  opacity:
                                                      _store.isFemale ? 1 : 0.5,
                                                  child: Column(
                                                    children: [
                                                      Image.asset(
                                                        ImageEnum.femaleImage,
                                                        width: 105,
                                                        fit: BoxFit.contain,
                                                      ),
                                                      Text(
                                                        l10n(context)!.female,
                                                        style: Styles.bodyBold
                                                            .copyWith(
                                                                color: AppColors
                                                                    .neutral600),
                                                      )
                                                    ],
                                                  )),
                                              onTap: () =>
                                                  _store.onSelectGenderFemale(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  AppButton(
                                    title:
                                        l10n(context)!.sign_up_create_account,
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        onSubmit();
                                      }
                                    },
                                    isLeftGradient: true,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
