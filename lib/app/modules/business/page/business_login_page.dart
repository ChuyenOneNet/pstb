import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pstb/app/modules/business/business_store.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // ✅ secure password

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

  // ✅ secure storage cho password
  final FlutterSecureStorage _secure = const FlutterSecureStorage();

  // Tránh bấm nhiều lần, giúp hiển thị loading
  bool _isBusy = false;

  // Khóa lưu trữ
  static const _kIdKey = 'maYte';
  static const _kPwKey = 'passwordBusiness';

  @override
  void initState() {
    super.initState();
    _loadAndAutoLogin(); // ✅ đọc & tự đăng nhập nếu có
  }

  Future<void> _loadAndAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final savedId = prefs.getString(_kIdKey);
    final savedPw = await _secure.read(key: _kPwKey);

    if ((savedId ?? '').isNotEmpty && (savedPw ?? '').isNotEmpty) {
      _idController.text = savedId!;
      _passwordController.text = savedPw!;
      await _login(maYte: savedId, password: savedPw!, auto: true);
    }
  }

  Future<void> _saveCredentials(String maYte, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kIdKey, maYte);
    await _secure.write(key: _kPwKey, value: password);
  }

  Future<void> _clearSaved() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kIdKey);
    await _secure.delete(key: _kPwKey);
    Fluttertoast.showToast(msg: 'Đã xoá tài khoản đã lưu');
  }

  Future<void> _login({
    required String maYte,
    required String password,
    bool auto = false,
  }) async {
    if (_isBusy) return;
    setState(() => _isBusy = true);

    try {
      final success =
          await store.getUserBusiness(maYte: maYte, password: password);

      if (!success) throw Exception('Sai tài khoản hoặc mật khẩu');

      await _saveCredentials(maYte, password);

      if (!mounted) return;
      if (!auto) Fluttertoast.showToast(msg: 'Đăng nhập thành công');
      Modular.to.pushReplacementNamed(AppRoutes.businessPage);
    } catch (e) {
      if (!auto) Fluttertoast.showToast(msg: 'Đăng nhập thất bại');
    } finally {
      if (mounted) setState(() => _isBusy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Hồ sơ sức khỏe',
        isBack: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 140,
              width: 140,
              child: Image.asset(ImageEnum.logopstbColor),
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

            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _isBusy
                    ? null
                    : () async {
                        final maYte = _idController.text.trim();
                        final password = _passwordController.text.trim();

                        if (maYte.isEmpty || password.isEmpty) {
                          Fluttertoast.showToast(
                              msg: 'Vui lòng nhập đầy đủ thông tin');
                          return;
                        }
                        await _login(maYte: maYte, password: password);
                      },
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary),
                child: _isBusy
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.white))
                    : const Text('Đăng Nhập',
                        style: TextStyle(color: Colors.white)),
              ),
            ),

            const SizedBox(height: 12),

            GestureDetector(
              onTap: () =>
                  Modular.to.pushNamed(AppRoutes.resetPasswordBusiness),
              child: const Text(
                'Đặt lại mật khẩu',
                style: TextStyle(
                    decoration: TextDecoration.underline, color: Colors.blue),
              ),
            ),

            const SizedBox(height: 8),

            // (tuỳ chọn) Nút xoá thông tin đã lưu
            TextButton(
              onPressed: _clearSaved,
              child: const Text(
                'Xoá tài khoản đã lưu',
                style: TextStyle(color: Colors.red),
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
