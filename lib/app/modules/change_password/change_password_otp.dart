import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/utils/sessions/local_secure.dart';

import '../../../services/soft_otp_service.dart';
import '../../../utils/colors.dart';
import '../../../utils/helper.dart';
import '../../../utils/images.dart';
import '../../../utils/styles.dart';
import '../../../widgets/stateful/touchable_opacity.dart';
import '../../../widgets/stateless/app_button.dart';
import '../../../widgets/stateless/app_snack_bar.dart';
import 'change_password_store.dart';

class ChangePasswordOtpScreen extends StatefulWidget {
  const ChangePasswordOtpScreen({Key? key}) : super(key: key);
  @override
  State<ChangePasswordOtpScreen> createState() =>
      _ChangePasswordOtpScreenState();
}

class _ChangePasswordOtpScreenState extends State<ChangePasswordOtpScreen> {
  final SoftOtpService _otpService = SoftOtpService();
  final ChangePasswordStore _controller = Modular.get<ChangePasswordStore>();
  String? secretKey;
  String? _currentOtp;
  int _timeLeft = 60;
  bool _hasError = false;
  bool _isExpired = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  void _initialize() async {
    await _getSecretKey();

    if (!_hasError) {
      _generateOtpAndStartTimer();
    }
  }

  Future<void> _getSecretKey() async {
    secretKey = await FlutterSecure().readKeyStorage(key: "secretKey");
    if (secretKey == null || secretKey!.isEmpty) {
      setState(() {
        _hasError = true;
      });
      return;
    }
  }

  void _generateOtpAndStartTimer() async {
    final otp = await _otpService.generateOtp(secretKey!, 60, 6);

    setState(() {
      _currentOtp = otp;
      _timeLeft = 60;
      _isExpired = false;
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _timeLeft--;
      });

      if (_timeLeft <= 0) {
        timer.cancel();
        setState(() {
          _isExpired = true;
        });
      }
    });
  }

  void _regenerateOtp() {
    _generateOtpAndStartTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (EasyLoading.isShow) {
          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: widthConvert(context, 16), vertical: 16.0),
                  child: _buildBackBtn(context)),
              _buildBody(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackBtn(BuildContext context) {
    return TouchableOpacity(
      child: Column(
        children: [
          const Icon(
            Icons.arrow_back_ios,
            size: 24,
            color: AppColors.grayLight,
          ),
          Text(
            "",
            style: Styles.subtitleSmall
                .copyWith(color: AppColors.primary, height: 20 / 12),
          )
        ],
      ),
      onTap: () {
        Modular.to.pop();
      },
    );
  }

  Widget _buildBody() {
    if (_hasError) {
      return Center(
        child: Text(
          "Không tìm thấy secretKey để tạo OTP",
          style: TextStyle(color: Colors.red, fontSize: 18),
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
          const Text("Mã OTP hiện tại của bạn:",
              style: TextStyle(fontSize: 18)),
          const SizedBox(height: 20),

          // Hiển thị OTP hoặc thông báo hết hạn
          if (_isExpired) ...[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red.shade200),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.access_time,
                    color: Colors.red,
                    size: 40,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'OTP đã hết hạn',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Vui lòng tạo mã OTP mới',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.red.shade700,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: AppButton(
                title: 'Tạo lại OTP',
                onPressed: _regenerateOtp,
                labelStyle: Styles.titleButton
                    .copyWith(fontSize: 16.0, color: Colors.white),
                primaryColor: Color(0xFF1B7B57),
                borderColor: const Color(0xFAC7C5C5),
              ),
            ),
          ] else ...[
            Text(
              _currentOtp ?? 'Đang tạo...',
              style: const TextStyle(
                fontSize: 40,
                letterSpacing: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Còn $_timeLeft giây',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: AppButton(
                  title: 'Xác nhận',
                  onPressed: () {
                    if (_currentOtp == null) {
                      AppSnackBar.show(
                          context, AppSnackBarType.Error, "Lỗi Otp");
                      return;
                    }
                    _controller.onCheckOtp(secretKey ?? "", _currentOtp ?? "");
                  },
                  labelStyle: Styles.titleButton
                      .copyWith(fontSize: 16.0, color: Colors.white),
                  primaryColor: Color(0xFF1B7B57),
                  borderColor: const Color(0xFAC7C5C5)),
            ),
          ],
        ],
      ),
    );
  }
}
