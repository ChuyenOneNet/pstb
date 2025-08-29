import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pstb/app/modules/home/home_store.dart';
import 'package:pstb/app/user_app_store.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/utils/sessions/session_prefs.dart';
import 'package:pstb/widgets/stateful/app_input.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';

class LoginHisWidget extends StatefulWidget {
  const LoginHisWidget({Key? key, this.isPushNewPage = false})
      : super(key: key);
  final bool? isPushNewPage;
  @override
  State<LoginHisWidget> createState() => _LoginHisWidgetState();
}

class _LoginHisWidgetState extends State<LoginHisWidget> {
  late TextEditingController _staffCodeController;
  late TextEditingController _passwordController;
  final _formKey = GlobalKey<FormState>();
  final _userAppStore = Modular.get<UserAppStore>();
  final homeStore = Modular.get<HomeStore>();
  String phoneNumber = '';
  @override
  void initState() {
    _staffCodeController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _staffCodeController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height / 3,
      // padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Liên kết với HIS',
                    style: Styles.titleItem
                        .copyWith(color: AppColors.primary, fontSize: 18.0)),
                InkWell(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: AppColors.lightSilver,
                    ),
                    child: SvgPicture.asset(
                      IconEnums.close,
                      width: 24,
                      height: 24,
                      fit: BoxFit.contain,
                      color: AppColors.black,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(
              color: AppColors.primary,
            ),
            const SizedBox(
              height: 16,
            ),
            AppInput(
              controller: _staffCodeController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Hãy hập đủ thông tin';
                }
                return null;
              },
              enabled: true,
              hintText: 'Mã tài khoản HIS',
              iconRight: IconEnums.close,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(
              height: 8,
            ),
            AppInput(
              controller: _passwordController,
              obscureText: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Hãy hập đủ thông tin';
                }
                return null;
              },
              hintText: 'Mật khẩu',
            ),
            const SizedBox(
              height: 32.0,
            ),
            AppButton(
                title: 'Đăng nhập',
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                  await _userAppStore.checkStatusNursing(
                      code: _staffCodeController.text,
                      password: _passwordController.text);
                  if (_userAppStore.isConnectedHis! && !widget.isPushNewPage!) {
                    Navigator.pop(context);
                    await SessionPrefs.isStaff(true);
                    homeStore.isStaff = true;

                    Fluttertoast.showToast(
                        msg: 'Đăng nhập thành công',
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: AppColors.success);
                    await homeStore.refreshToken();
                    return;
                  }
                  // if (_userAppStore.isConnectedHis != null &&
                  //     !_userAppStore.isConnectedHis!) {
                  //   Fluttertoast.showToast(
                  //       msg: _userAppStore.errorMessage ?? 'Không đúng mã nhân viên y tế',
                  //       gravity: ToastGravity.BOTTOM,
                  //       backgroundColor: AppColors.error500);
                  //   return;
                  // }
                  if (_userAppStore.isConnectedHis! && widget.isPushNewPage!) {
                    Navigator.pop(context);
                    Modular.to.pushNamed(AppRoutes.nursePage);
                    return;
                  }
                })
          ],
        ),
      ),
    );
  }
}
