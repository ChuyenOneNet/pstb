import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/images.dart';
import '../../../../utils/routes.dart';
import '../../../../widgets/stateless/app_bar.dart';
import '../business_store.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController usernameController = TextEditingController();

  final store = Modular.get<BusinessStore>();
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Logo + title
            SizedBox(
              height: 140,
              width: 140,
              child: Image.asset(
                ImageEnum.logopstbColor,
                // color: AppColors.primary,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                children: const [
                  Icon(Icons.lock_reset, size: 60, color: Colors.green),
                  SizedBox(height: 10),
                  Text(
                    "ĐẶT LẠI MẬT KHẨU",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal),
                  ),
                  SizedBox(height: 6),
                ],
              ),
            ),

            _buildInputField(
              controller: usernameController,
              label: "Mã",
              icon: Icons.person,
            ),
            const SizedBox(height: 16),

            // Confirm button
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                ),
                onPressed: () async {
                  final username = usernameController.text.trim();

                  if (username.isEmpty) {
                    Fluttertoast.showToast(
                        msg: "Vui lòng điền đầy đủ thông tin");
                    return;
                  }

                  final success = await store.resetPassword(
                    userName: username,
                  );

                  if (success) {
                    Modular.to.pop(); // trở về màn trước
                  }
                  // Gọi API reset tại đây
                },
                child: const Text("Xác Nhận",
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: Colors.grey.shade100,
      ),
    );
  }
}
