// lib/app/modules/signup/pages/signup_all_in_one.dart
import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:intl/intl.dart'; // nếu chưa có
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;

import 'package:pstb/app/modules/signup/signup_store.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/utils/time_util.dart';

import 'package:pstb/widgets/stateful/stateful_widget.dart';
import 'package:pstb/widgets/stateless/app_button.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';
import '../../../widgets/stateless/build_rules_secure.dart';

class SignupAllInOne extends StatefulWidget {
  const SignupAllInOne({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignupAllInOneState();
}

class _SignupAllInOneState extends State<SignupAllInOne> {
  final SignupStore _store = Modular.get<SignupStore>();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _store.changeBuildContext(context);
    // Reset khi mở màn
    _store.changePhoneNumber("");
    _store.changePassword("");
    _store.changeConfirmPass("");
    _store.onChangeFullName("");
    _store.onChangeBirthday("");
    _store.onChangeEmail("");
    _store.onChangePersonalId("");
    super.initState();
  }

  // DatePicker Material
  Future<void> _buildMaterialDatePicker(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      _store.onChangeBirthday(TimeUtil.format(picked, TimeUtil.ViewDateFormat));
    }
  }

  // DatePicker iOS
  void _buildCupertinoDatePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: MediaQuery.of(context).size.height / 3,
          color: Colors.white,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: (picked) {
              _store.onChangeBirthday(
                TimeUtil.format(picked, TimeUtil.ViewDateFormat),
              );
            },
            initialDateTime: DateTime.now(),
            minimumYear: 1900,
            maximumYear: DateTime.now().year,
          ),
        );
      },
    );
  }

  void _handleDatePicker(BuildContext context) {
    final theme = Theme.of(context);
    switch (theme.platform) {
      case TargetPlatform.android:
        _buildMaterialDatePicker(context);
        break;
      case TargetPlatform.iOS:
        _buildCupertinoDatePicker(context);
        break;
      default:
        _buildMaterialDatePicker(context);
    }
  }

  void _showDobPicker() {
    // Ẩn bàn phím nếu đang focus
    FocusManager.instance.primaryFocus?.unfocus();

    final now = DateTime.now();
    DateTime current =
        DateTime(now.year - 25, now.month, now.day); // mặc định 25 tuổi
    // Lấy giá trị hiện có trong ô Ngày sinh (dd/MM/yyyy) nếu parse được
    final text = _store.dobController.text.trim();
    if (text.isNotEmpty) {
      try {
        current = DateFormat('dd/MM/yyyy').parseStrict(text);
      } catch (_) {}
    }

    picker.DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      // Bạn có thể giữ đúng theo yêu cầu: 2000-01-01. (Sinh trước 2000 thì tăng lên 1900)
      minTime: DateTime(1900, 1, 1),
      maxTime: DateTime.now(),
      currentTime: current,
      locale: picker.LocaleType.vi,
      onConfirm: (date) {
        final s = DateFormat('dd/MM/yyyy').format(date);
        // cập nhật store + UI
        _store.onChangeBirthday(s);
        _store.dobController.text = s;
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final maskDob = MaskTextInputFormatter(
      mask: '##/##/####',
      filter: {"#": RegExp(r'[0-9]')},
    );

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: () async => !EasyLoading.isShow,
        child: Scaffold(
          appBar: CustomAppBar(
            title: "Đăng ký tài khoản",
          ),
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 560),
                      child: Column(
                        children: [
                          const SizedBox(height: 8),
                          // ---------------- Header Gradient (Hero) ----------------
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: _HeaderHero(),
                          ),
                          const SizedBox(height: 16),

                          // ---------------- Form Card ----------------
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Observer(
                              builder: (_) {
                                return Form(
                                  key: _formKey,
                                  child: Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        16, 20, 16, 16),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 24,
                                          spreadRadius: 0,
                                          offset: const Offset(0, 12),
                                          color: Colors.black.withOpacity(0.06),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        _SectionTitle(
                                            title: "Thông tin đăng nhập"),
                                        const SizedBox(height: 12),

                                        // ---- Phone (required)
                                        _FieldLabel(l10n(context)!.phone_number,
                                            isRequired: true),
                                        AppInput(
                                          iconLeft: IconEnums.phone,
                                          hintText: l10n(context)!.phone_number,
                                          validationError:
                                              _store.validatePhoneNumber,
                                          errorText: _store.phoneValidResponse,
                                          onChangeValue:
                                              _store.changePhoneNumber,
                                          keyboardType: TextInputType.phone,
                                        ),

                                        // ---- Password (required)
                                        const SizedBox(height: 10),
                                        _FieldLabel(
                                            l10n(context)!.forgot_hint_pass,
                                            isRequired: true),
                                        AppInput(
                                          maxLine: 1,
                                          iconLeft: IconEnums.lock,
                                          iconRight: IconEnums.eyeOff,
                                          hintText:
                                              l10n(context)!.forgot_hint_pass,
                                          validationError:
                                              _store.validatePassword,
                                          onChangeValue: _store.changePassword,
                                          obscureText: true,
                                          listFormat: [
                                            FilteringTextInputFormatter.deny(
                                                RegExp(r'[ ]')),
                                          ],
                                        ),

                                        // ---- Confirm Password (required)
                                        const SizedBox(height: 10),
                                        _FieldLabel(
                                            l10n(context)!
                                                .forgot_hint_confirm_pass,
                                            isRequired: true),
                                        AppInput(
                                          maxLine: 1,
                                          iconLeft: IconEnums.lock,
                                          iconRight: IconEnums.eyeOff,
                                          hintText: l10n(context)!
                                              .forgot_hint_confirm_pass,
                                          validationError:
                                              _store.validateConfirmPass,
                                          onChangeValue:
                                              _store.changeConfirmPass,
                                          obscureText: true,
                                          listFormat: [
                                            FilteringTextInputFormatter.deny(
                                                RegExp(r'[ ]')),
                                          ],
                                        ),

                                        const SizedBox(height: 20),
                                        _Divider(),

                                        // ---- Personal info
                                        _SectionTitle(
                                            title: "Thông tin cá nhân"),
                                        const SizedBox(height: 12),

                                        // Full name (required)
                                        _FieldLabel(
                                            l10n(context)!.sign_up_full_name,
                                            isRequired: true),
                                        AppInput(
                                          onChangeValue:
                                              _store.onChangeFullName,
                                          hintText:
                                              l10n(context)!.sign_up_full_name,
                                          iconLeft: IconEnums.user,
                                          validationError:
                                              _store.validateFullName,

                                          // ✅ Gợi ý cho field tên
                                          keyboardType: TextInputType.name,
                                          textCapitalization:
                                              TextCapitalization.words,

                                          // ✅ Cho phép mọi chữ cái Unicode (kể cả tiếng Việt) + khoảng trắng + . ' -
                                          listFormat: [
                                            FilteringTextInputFormatter.allow(
                                                RegExp(
                                                    r"[A-Za-z\u00C0-\u024F\u1E00-\u1EFF\u0300-\u036F .'\-]")),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        const _FieldLabel("Căn cước công dân",
                                            isRequired: true),
                                        AppInput(
                                          onChangeValue:
                                              _store.onChangePersonalId,
                                          hintText: "Căn cước công dân",
                                          iconLeft: IconEnums.user,
                                          validationError:
                                              _store.validatePersonalId,
                                          keyboardType: TextInputType.number,
                                          listFormat: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            LengthLimitingTextInputFormatter(
                                                12),
                                          ],
                                        ),
                                        // DOB (optional)
                                        const SizedBox(height: 10),
                                        _FieldLabel(
                                            l10n(context)!.sign_up_birthday,
                                            optional: true),
                                        TextFormField(
                                          controller: _store.dobController,
                                          // Không cần mask nữa nếu chỉ chọn bằng picker; muốn giữ cũng không sao
                                          // inputFormatters: [maskDob],
                                          readOnly:
                                              true, // <- không bật bàn phím
                                          onTap:
                                              _showDobPicker, // <- chạm vào mở picker
                                          decoration:
                                              Styles.dobDecoration.copyWith(
                                            suffixIcon: IconButton(
                                              onPressed:
                                                  _showDobPicker, // <- bấm icon cũng mở picker
                                              icon: SvgPicture.asset(
                                                IconEnums.calendar,
                                                width: 16,
                                                height: 16,
                                                color: AppColors.primary,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            hintText:
                                                l10n(context)!.sign_up_birthday,
                                            hintStyle: Styles.bodyRegular
                                                .copyWith(
                                                    color: AppColors.grayLight),
                                          ),
                                          validator: (_) => null, // optional
                                          keyboardType: TextInputType
                                              .none, // <- đảm bảo không hiện bàn phím
                                        ),

                                        // Email (optional)
                                        const SizedBox(height: 10),
                                        _FieldLabel(
                                            l10n(context)!.sign_up_email,
                                            optional: true),
                                        AppInput(
                                          onChangeValue: _store.onChangeEmail,
                                          hintText:
                                              "${l10n(context)!.sign_up_email} (không bắt buộc)",
                                          iconLeft: IconEnums.mail,
                                          validationError: null, // optional
                                          keyboardType:
                                              TextInputType.emailAddress,
                                        ),

                                        // Personal ID (required)

                                        // Gender (optional)
                                        const SizedBox(height: 14),
                                        Text(
                                          l10n(context)!
                                              .sign_up_information_select_gender,
                                          style: Styles.bodyRegular.copyWith(
                                            color: AppColors.neutral700,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Wrap(
                                          spacing: 12,
                                          children: [
                                            ChoiceChip(
                                              label: Text(
                                                l10n(context)!.male,
                                                style:
                                                    Styles.bodyRegular.copyWith(
                                                  color: _store.isMale
                                                      ? AppColors.primary
                                                      : AppColors.neutral700,
                                                ),
                                              ),
                                              selected: _store.isMale,
                                              selectedColor: AppColors.primary
                                                  .withOpacity(0.12),
                                              backgroundColor: Colors.white,
                                              onSelected: (_) =>
                                                  _store.onSelectGenderMale(),
                                              shape: StadiumBorder(
                                                side: BorderSide(
                                                  color: _store.isMale
                                                      ? AppColors.primary
                                                      : AppColors.neutral200,
                                                ),
                                              ),
                                              materialTapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                            ),
                                            ChoiceChip(
                                              label: Text(
                                                l10n(context)!.female,
                                                style:
                                                    Styles.bodyRegular.copyWith(
                                                  color: _store.isFemale
                                                      ? AppColors.primary
                                                      : AppColors.neutral700,
                                                ),
                                              ),
                                              selected: _store.isFemale,
                                              selectedColor: AppColors.primary
                                                  .withOpacity(0.12),
                                              backgroundColor: Colors.white,
                                              onSelected: (_) =>
                                                  _store.onSelectGenderFemale(),
                                              shape: StadiumBorder(
                                                side: BorderSide(
                                                  color: _store.isFemale
                                                      ? AppColors.primary
                                                      : AppColors.neutral200,
                                                ),
                                              ),
                                              materialTapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                            ),
                                          ],
                                        ),

                                        const SizedBox(height: 20),

                                        // Submit
                                        AppButton(
                                          title: l10n(context)!
                                              .sign_up_create_account,
                                          isLeftGradient: true,
                                          onPressed: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              _store.registerAndUpdateAll();
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                          // --------- Rules & Security ----------
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                            child: BuildRulesSecure(
                              onRule: () {
                                Modular.to.pushNamed(
                                  AppRoutes.webView,
                                  arguments:
                                      'https://onenet.vn/chinh-sach-bao-mat-thong-tin',
                                );
                              },
                              onSecure: () {
                                Modular.to.pushNamed(
                                  AppRoutes.webView,
                                  arguments:
                                      'https://onenet.vn/chinh-sach-bao-mat-thong-tin',
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          bottomNavigationBar: const _BuildHotline2(),
        ),
      ),
    );
  }
}

// ------------------------ UI Helpers ------------------------
class _HeaderHero extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary,
            AppColors.primary.withOpacity(0.85),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            blurRadius: 24,
            spreadRadius: 0,
            offset: const Offset(0, 12),
            color: AppColors.primary.withOpacity(0.25),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.person_add_alt_1_rounded,
              color: Colors.white,
              size: 26,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n(context)!.signup_title,
                  style: Styles.heading.copyWith(
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  l10n(context)!.sign_up_information_subtitle,
                  style: Styles.bodyRegular.copyWith(
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 7,
          height: 7,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: Styles.subtitleLarge.copyWith(
            color: AppColors.neutral800,
          ),
        ),
      ],
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String text;
  final bool optional;
  final bool isRequired;
  const _FieldLabel(
    this.text, {
    this.optional = false,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    final star = TextSpan(
      text: " *",
      style: Styles.bodyBold.copyWith(
        color: Colors.redAccent,
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 6, top: 4),
      child: Row(
        children: [
          Flexible(
            child: RichText(
              text: TextSpan(
                text: text,
                style: Styles.bodyBold.copyWith(color: AppColors.neutral700),
                children: [
                  if (isRequired) star,
                ],
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      color: AppColors.neutral200,
      height: 1,
      thickness: 1,
    );
  }
}

class _BuildHotline2 extends StatelessWidget {
  const _BuildHotline2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 16, top: 8),
            child: Text(
              l10n(context)!.forgot_text_callOut,
              style: Styles.subtitleLarge.copyWith(
                color: AppColors.neutral600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: AppButtonOutline(
              text: l10n(context)!.hotline.toString().toUpperCase(),
              phoneNumber: Constants.contactPhone,
            ),
          )
        ],
      ),
    );
  }
}
