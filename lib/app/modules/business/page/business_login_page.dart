import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pstb/app/modules/business/business_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/images.dart';
import '../../../../utils/routes.dart';
import '../../../../widgets/stateless/app_bar.dart';

class BusinessLoginPage extends StatefulWidget {
  const BusinessLoginPage({Key? key});

  @override
  State<BusinessLoginPage> createState() => _BusinessLoginPageState();
}

class _BusinessLoginPageState extends State<BusinessLoginPage> {
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();
  final BusinessStore store = Modular.get<BusinessStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Hồ sơ sức khỏe',
        isBack: true,
        // actionIcon: const Icon(Icons.search, color: AppColors.primary,),
        // actionFunc: () {
        //   // Modular.to.pushNamed(AppRoutes.searchMedical, arguments: false);
        // },
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Banner logo hoặc ảnh nếu cần
            SizedBox(
              height: 140,
              width: 140,
              child: Image.asset(
                ImageEnum.logopstbColor,
                // color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'CỔNG TRA CỨU Y BẠ ĐIỆN TỬ\nBỆNH VIỆN Phụ Sản Thái Bình',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 24),

            // Mã y tế
            TextField(
              controller: _idController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person),
                labelText: 'Mã',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Mật khẩu
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.lock),
                labelText: 'Mật khẩu',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),

            // Nút đăng nhập
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () async {
                  final maYte = _idController.text.trim();
                  final password = _passwordController.text.trim();

                  if (maYte.isEmpty || password.isEmpty) {
                    Fluttertoast.showToast(
                        msg: 'Vui lòng nhập đầy đủ thông tin');
                    return;
                  }

                  try {
                    await store.getUserBusiness(
                      maYte: maYte,
                      password: password,
                    );
                    // final prefs = await SharedPreferences.getInstance();
                    // await prefs.setString('maYte', maYte);
                    // await prefs.setString('passwordBusiness', password);
                    // await store.loadHistoryRecord();
                    //
                    // Modular.to.pushReplacementNamed(AppRoutes.businessPage);
                  } catch (e) {
                    Fluttertoast.showToast(msg: 'Đăng nhập thất bại');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                ),
                child: const Text(
                  'Đăng Nhập',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Đặt lại mật khẩu
            GestureDetector(
              onTap: () {
                // xử lý đặt lại mật khẩu nếu có
                Modular.to.pushNamed(AppRoutes.resetPasswordBusiness);
              },
              child: const Text(
                'Đặt lại mật khẩu',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.blue,
                ),
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              '2025 © Bệnh Viện Phụ Sản Thái Bình\n'
              'Địa chỉ: Số 530 đường Lý Bôn, Thái Bình, Việt Nam\n'
              'Hotline: 0363.832.057 ',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
