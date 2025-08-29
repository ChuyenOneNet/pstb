import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pstb/app/modules/business/business_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/images.dart';
import '../../../../widgets/stateless/app_bar.dart';

class ChangePasswordBusinessScreen extends StatefulWidget {
  const ChangePasswordBusinessScreen({Key? key});

  @override
  State<ChangePasswordBusinessScreen> createState() =>
      _ChangePasswordBusinessScreenState();
}

class _ChangePasswordBusinessScreenState
    extends State<ChangePasswordBusinessScreen> {
  final usernameController = TextEditingController();
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final store = Modular.get<BusinessStore>();

  bool _obscureOld = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;
  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }

  void _loadSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final maYte = prefs.getString('maYte') ?? '';
    final password = prefs.getString('passwordBusiness') ?? '';
    usernameController.text = maYte;
    oldPasswordController.text = password;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Đặt lại mật khẩu',
        isBack: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            SizedBox(
              height: 140,
              width: 140,
              child: Image.asset(
                ImageEnum.logopstbColor,
                // color: AppColors.primary,
              ),
            ),
            const Icon(Icons.lock, size: 60, color: AppColors.primary),
            const SizedBox(height: 12),
            const Text(
              "ĐỔI MẬT KHẨU",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal),
            ),
            const SizedBox(height: 6),
            // Username
            _buildTextField(
              controller: usernameController,
              label: "Mã",
              icon: Icons.person,
            ),
            const SizedBox(height: 12),

            // Mật khẩu cũ
            _buildTextField(
              controller: oldPasswordController,
              label: "Mật khẩu cũ",
              icon: Icons.lock_outline,
              obscureText: _obscureOld,
              toggleObscure: () {
                setState(() {
                  _obscureOld = !_obscureOld;
                });
              },
            ),
            const SizedBox(height: 12),

            // Mật khẩu mới
            _buildTextField(
              controller: newPasswordController,
              label: "Nhập mật khẩu mới",
              icon: Icons.lock,
              obscureText: _obscureNew,
              toggleObscure: () {
                setState(() {
                  _obscureNew = !_obscureNew;
                });
              },
            ),
            const SizedBox(height: 12),

            // Nhập lại mật khẩu mới
            _buildTextField(
              controller: confirmPasswordController,
              label: "Nhập lại mật khẩu mới",
              icon: Icons.lock,
              obscureText: _obscureConfirm,
              toggleObscure: () {
                setState(() {
                  _obscureConfirm = !_obscureConfirm;
                });
              },
            ),
            const SizedBox(height: 24),

            // Nút xác nhận
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                ),
                onPressed: _onConfirmPressed,
                child: const Text("Xác Nhận",
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
    VoidCallback? toggleObscure,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        suffixIcon: toggleObscure != null
            ? IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: toggleObscure,
              )
            : null,
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        filled: true,
        fillColor: Colors.grey.shade100,
      ),
    );
  }

  Future<void> _onConfirmPressed() async {
    final username = usernameController.text.trim();
    final oldPass = oldPasswordController.text;
    final newPass = newPasswordController.text;
    final confirmPass = confirmPasswordController.text;

    if (username.isEmpty ||
        oldPass.isEmpty ||
        newPass.isEmpty ||
        confirmPass.isEmpty) {
      Fluttertoast.showToast(msg: "Vui lòng nhập đầy đủ thông tin");
      return;
    }

    if (newPass != confirmPass) {
      Fluttertoast.showToast(msg: "Mật khẩu mới không khớp");
      return;
    }

    final success = await store.changePassword(
      userName: username,
      oldPassword: oldPass,
      newPassword: newPass,
    );

    if (success) {
      Fluttertoast.showToast(msg: "Đổi mật khẩu thành công");
      Modular.to.pop();
    }
  }
}
