import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:pstb/app/modules/home/home_store.dart';
import 'package:pstb/app/user_app_store.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/utils/routes.dart';
import 'package:pstb/utils/sessions/session_prefs.dart';
import 'package:pstb/widgets/stateful/app_input.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';

import '../../../../../../utils/device_util.dart';

class LoginHisWidget extends StatefulWidget {
  const LoginHisWidget({Key? key, this.isPushNewPage = false})
      : super(key: key);

  final bool? isPushNewPage;

  @override
  State<LoginHisWidget> createState() => _LoginHisWidgetState();
}

class _LoginHisWidgetState extends State<LoginHisWidget> {
  late final TextEditingController _staffCodeController;
  late final TextEditingController _passwordController;

  final _formKey = GlobalKey<FormState>();
  final _userAppStore = Modular.get<UserAppStore>();
  final _homeStore = Modular.get<HomeStore>();

  // OTP state
  String? _serverOtp;
  DateTime? _lastOtpTime;
  int _otpAttemptsToday = 0;

  final ValueNotifier<int> _cooldown = ValueNotifier<int>(0);
  Timer? _cooldownTimer;

  static const _kOtpDate = 'otp_date_his_login';
  static const _kOtpAttempts = 'otp_attempts_his_login';

  // API config
  static const String _defaultBaseUrl = 'https://116.97.240.210:6443';

  // Cache (giảm IO, giảm lag)
  SharedPreferences? _prefs;
  String? _baseUrlCache;
  String? _deviceIdCache;

  bool _isBusy = false;

  // ===== logging =====
  void _log(String msg) {
    // ignore: avoid_print
    debugPrint('[HIS_LOGIN] $msg');
  }

  @override
  void initState() {
    super.initState();
    _staffCodeController = TextEditingController();
    _passwordController = TextEditingController();

    // init async nhẹ, không setState (UI không cần hiển thị attempts/deviceId)
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    final sw = Stopwatch()..start();
    _prefs = await SharedPreferences.getInstance();
    await _loadOtpAttemptData(); // đọc attempts/day
    _deviceIdCache = await DeviceUtil.getId(); // best-effort
    _baseUrlCache = await _getBaseUrl(); // cache baseUrl
    sw.stop();
    _log('bootstrap done in ${sw.elapsedMilliseconds}ms '
        '(attempts=$_otpAttemptsToday, device=${_deviceIdCache?.isNotEmpty == true ? "OK" : "NULL"}, baseUrl=${_baseUrlCache ?? "NULL"})');
  }

  @override
  void dispose() {
    _staffCodeController.dispose();
    _passwordController.dispose();
    _cooldownTimer?.cancel();
    _cooldown.dispose();
    super.dispose();
  }

  Future<String> _getBaseUrl() async {
    if (_baseUrlCache != null) return _baseUrlCache!;
    final prefs = _prefs ?? await SharedPreferences.getInstance();
    final raw = (prefs.getString("vduhUrl") ?? _defaultBaseUrl).trim();
    final url = raw.isEmpty ? _defaultBaseUrl : raw;
    _baseUrlCache = url;
    return url;
  }

  // =========================
  // OTP helpers
  // =========================
  Future<void> _loadOtpAttemptData() async {
    final prefs = _prefs ?? await SharedPreferences.getInstance();
    final today = DateTime.now().toIso8601String().substring(0, 10);

    final storedDate = prefs.getString(_kOtpDate) ?? '';
    final attempts = prefs.getInt(_kOtpAttempts) ?? 0;

    if (storedDate == today) {
      _otpAttemptsToday = attempts;
      return;
    }

    await prefs.setString(_kOtpDate, today);
    await prefs.setInt(_kOtpAttempts, 0);
    _otpAttemptsToday = 0;
  }

  Future<void> _incOtpAttempts() async {
    final prefs = _prefs ?? await SharedPreferences.getInstance();
    _otpAttemptsToday += 1;
    await prefs.setInt(_kOtpAttempts, _otpAttemptsToday);
  }

  void _startCooldown(int seconds) {
    _cooldownTimer?.cancel();
    _cooldown.value = seconds;

    _cooldownTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) {
        t.cancel();
        return;
      }
      final v = _cooldown.value;
      if (v > 0) {
        _cooldown.value = v - 1;
      } else {
        t.cancel();
      }
    });
  }

  String _maskPhone(String phone) {
    final p = phone.trim();
    if (p.length < 7) return p;
    return '${p.substring(0, 4)}xxxx${p.substring(p.length - 2)}';
  }

  String _normalizeVietnamPhone84(String phone) {
    final p = phone.trim().replaceAll(' ', '');

    if (p.startsWith('+84')) return p.substring(1);
    if (p.startsWith('0')) return '84${p.substring(1)}';
    if (p.startsWith('84')) return p;

    throw const FormatException('Invalid phone number format');
  }

  // =========================
  // API calls (tối ưu log + đo thời gian)
  // =========================
  Future<String?> _fetchPhoneByHisAccount({
    required String userName,
    required String password,
  }) async {
    final baseUrl = await _getBaseUrl();
    final uri = Uri.parse('$baseUrl/api/App/healthstaff-phone');

    final deviceId = _deviceIdCache ?? await DeviceUtil.getId();
    _deviceIdCache = deviceId;

    final sw = Stopwatch()..start();
    _log(
        'POST healthstaff-phone user=$userName password=$password device=${deviceId}');

    final res = await http.post(
      uri,
      headers: const <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(<String, dynamic>{
        'userName': userName,
        'password': password, // không log
        'device': deviceId ?? '',
      }),
    );

    sw.stop();
    _log(
        'healthstaff-phone status=${res.statusCode} in ${sw.elapsedMilliseconds}ms');

    if (res.statusCode != 200) return null;

    final jsonBody = jsonDecode(res.body);
    final data = jsonBody['data'];

    if (data == null) return null;

    if (data is String) return data.trim();
    if (data is Map && data['phone'] != null)
      return data['phone'].toString().trim();

    return null;
  }

  Future<String?> _sendOtpToPhone(String rawPhone) async {
    late final String phone84;
    try {
      phone84 = _normalizeVietnamPhone84(rawPhone);
    } catch (e) {
      _log('normalize phone fail: $e');
      return null;
    }

    final baseUrl = await _getBaseUrl();
    final uri = Uri.parse('$baseUrl/api/User/send-sms');

    final sw = Stopwatch()..start();
    _log('POST send-sms phone=${_maskPhone(rawPhone)}');

    final res = await http.post(
      uri,
      headers: const {'Content-Type': 'application/json'},
      body: jsonEncode({'Phone': phone84}),
    );

    sw.stop();
    _log('send-sms status=${res.statusCode} in ${sw.elapsedMilliseconds}ms');

    if (res.statusCode != 200) return null;

    final jsonBody = jsonDecode(res.body);
    final otp = jsonBody['data']?.toString().trim();
    if (otp == null || otp.isEmpty) return null;

    // không log OTP raw
    _log('send-sms ok (otpLength=${otp.length})');
    return otp;
  }

  // =========================
  // Validation / rate limit
  // =========================
  bool _validateForm() {
    final ok = _formKey.currentState?.validate() ?? false;
    if (!ok) _log('form validate FAIL');
    return ok;
  }

  bool _checkOtpLimitAndCooldown() {
    // Limit 3 lần/ngày
    if (_otpAttemptsToday >= 3) {
      Fluttertoast.showToast(msg: 'Đã vượt quá 3 lần gửi OTP trong ngày');
      _log('limit hit: attempts=$_otpAttemptsToday');
      return false;
    }

    // Cooldown 90s
    final now = DateTime.now();
    if (_lastOtpTime != null) {
      final diff = now.difference(_lastOtpTime!).inSeconds;
      if (diff < 90) {
        final remain = 90 - diff;
        Fluttertoast.showToast(msg: 'Vui lòng đợi ${remain}s để gửi lại OTP');
        _log('cooldown blocked remain=${remain}s');
        return false;
      }
    }

    return true;
  }

  // =========================
  // Main flow
  // =========================
  Future<void> _requestOtpAndThenLogin() async {
    if (_isBusy) return;

    if (!_validateForm()) return;
    if (!_checkOtpLimitAndCooldown()) return;

    final userName = _staffCodeController.text.trim();
    final password = _passwordController.text;

    setState(() => _isBusy = true);
    final swAll = Stopwatch()..start();
    _log('START flow user=$userName');

    try {
      // 1) Fetch phone
      final phone =
          await _fetchPhoneByHisAccount(userName: userName, password: password);
      if (phone == null || phone.isEmpty) {
        Fluttertoast.showToast(
            msg: 'Không lấy được số điện thoại của tài khoản HIS');
        _log('fetch phone FAIL');
        return;
      }
      _log('phone=${_maskPhone(phone)}');

      // 2) Send OTP
      final otp = await _sendOtpToPhone(phone);
      if (otp == null) {
        Fluttertoast.showToast(msg: 'Gửi OTP thất bại');
        _log('send otp FAIL');
        return;
      }

      // 3) Save attempts/day
      await _incOtpAttempts();
      _log('attempts saved=$_otpAttemptsToday');

      // 4) Save OTP/cooldown state
      _serverOtp = otp;
      _lastOtpTime = DateTime.now();
      _startCooldown(90);

      // 5) Input OTP
      // final entered = await showModalBottomSheet<String>(
      //   context: context,
      //   isScrollControlled: true,
      //   useSafeArea: true,
      //   backgroundColor: Colors.white,
      //   shape: const RoundedRectangleBorder(
      //     borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      //   ),
      //   builder: (_) => _OtpSheet(
      //     maskedPhone: _maskPhone(phone),
      //     cooldown: _cooldown,
      //     onResend: _requestOtpAndThenLogin,
      //   ),
      // );
      //
      // if (!mounted) return;
      //
      // if (entered == null || entered.trim().length != 6) {
      //   _log('otp sheet dismissed / invalid input');
      //   return;
      // }
      //
      // if (entered.trim() != _serverOtp) {
      //   Fluttertoast.showToast(msg: 'Mã OTP không đúng');
      //   _log('otp mismatch');
      //   return;
      // }
      final ok = await showModalBottomSheet<bool>(
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (_) => _OtpSheet(
          maskedPhone: _maskPhone(phone),
          cooldown: _cooldown,
          onResend: _requestOtpAndThenLogin,
          serverOtp: _serverOtp!, // 👈 thêm
        ),
      );

      if (ok != true) {
        _log('otp not confirmed');
        return;
      }

      _log('otp ok -> checkStatusNursing');

      // 6) Login thật
      await _userAppStore.checkStatusNursing(
        code: _staffCodeController.text,
        password: _passwordController.text,
      );

      _log(
          'checkStatusNursing done isConnectedHis=${_userAppStore.isConnectedHis} err=${_userAppStore.errorMessage}');

      if (_userAppStore.isConnectedHis == true &&
          widget.isPushNewPage != true) {
        Navigator.pop(context);
        await SessionPrefs.isStaff(true);
        _homeStore.isStaff = true;

        Fluttertoast.showToast(
          msg: 'Đăng nhập thành công',
          gravity: ToastGravity.BOTTOM,
          backgroundColor: AppColors.success,
        );

        await _homeStore.refreshToken();
        _log('SUCCESS (pop) refreshToken done');
        return;
      }

      if (_userAppStore.isConnectedHis == true &&
          widget.isPushNewPage == true) {
        Navigator.pop(context);
        Modular.to.pushNamed(AppRoutes.nursePage);
        _log('SUCCESS (push nursePage)');
        return;
      }

      Fluttertoast.showToast(
        msg: _userAppStore.errorMessage ?? 'Đăng nhập HIS thất bại',
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppColors.error500,
      );
      _log('FAIL login final');
    } catch (e, st) {
      _log('EXCEPTION $e\n$st');
      Fluttertoast.showToast(
        msg: 'Có lỗi xảy ra, vui lòng thử lại',
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppColors.error500,
      );
    } finally {
      swAll.stop();
      _log('END flow in ${swAll.elapsedMilliseconds}ms');
      if (mounted) setState(() => _isBusy = false);
    }
  }

  // =========================
  // UI
  // =========================
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Liên kết với HIS',
                style: Styles.titleItem.copyWith(
                  color: AppColors.primary,
                  fontSize: 18.0,
                ),
              ),
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

          const Divider(color: AppColors.primary),
          const SizedBox(height: 16),

          AppInput(
            controller: _staffCodeController,
            enabled: !_isBusy,
            validator: (value) => (value == null || value.isEmpty)
                ? 'Hãy nhập đủ thông tin'
                : null,
            hintText: 'Mã tài khoản HIS',
            iconRight: IconEnums.close,
            keyboardType: TextInputType.text,
          ),

          const SizedBox(height: 8),

          AppInput(
            controller: _passwordController,
            enabled: !_isBusy,
            obscureText: true,
            validator: (value) => (value == null || value.isEmpty)
                ? 'Hãy nhập đủ thông tin'
                : null,
            hintText: 'Mật khẩu',
          ),

          const SizedBox(height: 20),

          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Hệ thống sẽ gửi OTP về số điện thoại đã đăng ký. Giới hạn 3 lần/ngày, gửi lại sau 90s.',
              style: TextStyle(
                fontSize: 11.5,
                color: Colors.black.withOpacity(0.55),
                height: 1.25,
              ),
            ),
          ),

          const SizedBox(height: 16),

          SizedBox(
            width: double.infinity,
            child: AppButton(
              title: _isBusy ? 'Đang xử lý...' : 'Đăng nhập',
              onPressed: _isBusy ? () {} : _requestOtpAndThenLogin,
            ),
          ),
        ],
      ),
    );
  }
}

// =========================
// OTP bottom sheet (tối ưu gọn + paste 6 số)
// =========================
class _OtpSheet extends StatefulWidget {
  final String maskedPhone;
  final ValueNotifier<int> cooldown;
  final Future<void> Function()? onResend;
  final String serverOtp;
  const _OtpSheet({
    required this.maskedPhone,
    required this.cooldown,
    this.onResend,
    required this.serverOtp,
  });

  @override
  State<_OtpSheet> createState() => _OtpSheetState();
}

class _OtpSheetState extends State<_OtpSheet> {
  final _controllers = List.generate(6, (_) => TextEditingController());
  final _focusNodes = List.generate(6, (_) => FocusNode());
  bool _submitting = false;
  int _failCount = 0;
  String? _errorText;

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  // void _submitIfComplete() {
  //   final code = _controllers.map((e) => e.text).join();
  //   if (code.length == 6) Navigator.pop(context, code);
  // }
  void _submitIfComplete() {
    final code = _controllers.map((e) => e.text).join();
    if (code.length != 6) return;

    // ✅ ĐÚNG
    if (code == widget.serverOtp) {
      Navigator.pop(context, true);
      return;
    }

    // ❌ SAI
    _failCount++;

    if (_failCount >= 3) {
      Fluttertoast.showToast(msg: 'Nhập sai OTP quá 3 lần');
      Navigator.pop(context, false); // đóng popup
      return;
    }

    setState(() {
      _errorText = 'Mã OTP không đúng (${3 - _failCount} lần còn lại)';
    });

    // clear để nhập lại
    for (final c in _controllers) {
      c.clear();
    }
    _focusNodes.first.requestFocus();
  }

  void _onChanged(int i, String v) {
    // Support paste: nếu dán "123456" vào ô đầu
    if (v.length > 1) {
      final digits = v.replaceAll(RegExp(r'\D'), '');
      if (digits.length >= 6) {
        for (int k = 0; k < 6; k++) {
          _controllers[k].text = digits[k];
        }
        _focusNodes[5].requestFocus();
        _submitIfComplete();
        return;
      }
    }

    if (v.isNotEmpty && i < 5) _focusNodes[i + 1].requestFocus();
    if (v.isEmpty && i > 0) _focusNodes[i - 1].requestFocus();
    if (i == 5 && v.isNotEmpty) _submitIfComplete();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom) +
                const EdgeInsets.fromLTRB(16, 14, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 44,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(99),
              ),
            ),
            const SizedBox(height: 14),
            const Icon(Icons.verified_user_outlined, size: 34),
            const SizedBox(height: 10),
            const Text(
              'Xác thực OTP',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 6),
            Text(
              'Mã OTP đã gửi tới ${widget.maskedPhone}',
              style: TextStyle(color: Colors.black.withOpacity(0.65)),
            ),
            if (_errorText != null) ...[
              const SizedBox(height: 8),
              Text(
                _errorText!,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(6, (i) {
                return SizedBox(
                  width: 46,
                  height: 54,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: TextField(
                      controller: _controllers[i],
                      focusNode: _focusNodes[i],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 6, // để paste cũng ổn, counterText ẩn
                      decoration: InputDecoration(
                        counterText: '',
                        filled: true,
                        fillColor: const Color(0xFFF7F8FC),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide:
                              BorderSide(color: AppColors.primary, width: 1.3),
                        ),
                      ),
                      onChanged: (v) => _onChanged(i, v),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _submitting
                    ? null
                    : () {
                        setState(() => _submitting = true);
                        _submitIfComplete();
                        if (mounted) setState(() => _submitting = false);
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: _submitting
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.white),
                      )
                    : const Text(
                        'Xác nhận',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
              ),
            ),
            const SizedBox(height: 10),
            ValueListenableBuilder<int>(
              valueListenable: widget.cooldown,
              builder: (_, sec, __) {
                final disabled =
                    sec > 0 || widget.onResend == null || _submitting;
                return TextButton(
                  onPressed: disabled
                      ? null
                      : () async {
                          setState(() => _submitting = true);
                          await widget.onResend!.call();
                          if (mounted) setState(() => _submitting = false);
                        },
                  child:
                      Text(sec > 0 ? 'Gửi lại OTP (${sec}s)' : 'Gửi lại OTP'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
