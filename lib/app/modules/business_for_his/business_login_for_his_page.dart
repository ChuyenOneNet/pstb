import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:pstb/app/modules/business/business_store.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/images.dart';
import '../../../../utils/routes.dart';
import '../../../../widgets/stateless/app_bar.dart';
import 'business_detail_for_his_screen.dart';

class BusinessLoginForHisPage extends StatefulWidget {
  const BusinessLoginForHisPage({Key? key}) : super(key: key);

  @override
  State<BusinessLoginForHisPage> createState() =>
      _BusinessLoginForHisPageState();
}

class _BusinessLoginForHisPageState extends State<BusinessLoginForHisPage> {
  final BusinessStore store = Modular.get<BusinessStore>();
  final TextEditingController _patientCodeCtrl = TextEditingController();

  bool _isBusy = false;

  static const _kSavedPatientCode = 'saved_patient_code';
  static const _kBusinessLoggedIn = 'business_logged_in';

  @override
  void initState() {
    super.initState();
    //_loadSavedAndAutoLogin();
  }

  @override
  void dispose() {
    _patientCodeCtrl.dispose();
    super.dispose();
  }

  // Future<void> _loadSavedAndAutoLogin() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final savedCode = prefs.getString(_kSavedPatientCode) ?? '';
  //   final loggedIn = prefs.getBool(_kBusinessLoggedIn) ?? false;
  //
  //   if (savedCode.isNotEmpty) {
  //     _patientCodeCtrl.text = savedCode;
  //   }
  //
  //   if (!loggedIn || savedCode.isEmpty) return;
  //
  //   await _loginWithPatientCode(savedCode, auto: true);
  // }

  Future<void> _savePatientCode(String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kSavedPatientCode, code);
    await prefs.setBool(_kBusinessLoggedIn, true);
  }

  Future<void> _clearSavedPatientCode() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kSavedPatientCode);
    await prefs.remove(_kBusinessLoggedIn);

    Fluttertoast.showToast(msg: 'Đã xoá mã bệnh nhân đã lưu');
  }

  // Future<void> _loginWithPatientCode(
  //   String patientCode, {
  //   bool auto = false,
  // }) async {
  //   if (_isBusy) return;
  //   if (patientCode.isEmpty) {
  //     Fluttertoast.showToast(msg: 'Vui lòng nhập mã bệnh nhân');
  //     return;
  //   }
  //
  //   setState(() => _isBusy = true);
  //   try {
  //     final ok = await store.getUserBusiness(
  //       maYte: patientCode,
  //       password: patientCode,
  //     );
  //
  //     if (!ok) {
  //       if (!auto) {
  //         Fluttertoast.showToast(msg: 'Đăng nhập thất bại');
  //       }
  //       return;
  //     }
  //
  //     await _savePatientCode(patientCode);
  //
  //     if (!mounted) return;
  //     if (!auto) {
  //       Fluttertoast.showToast(msg: 'Đăng nhập thành công');
  //     }
  //
  //     Modular.to.pushReplacementNamed(AppRoutes.businessPageForHis);
  //   } finally {
  //     if (mounted) setState(() => _isBusy = false);
  //   }
  // }
  String? _getLatestDangKyId() {
    final list = store.listBusiness;
    if (list.isEmpty) return null;

    final records = list.first.khamChuaBenhs;
    if (records.isEmpty) return null;

    final sorted = List.of(records)
      ..sort((a, b) {
        final aDate = DateTime.tryParse(a.thoiGianRa ?? '') ?? DateTime(1900);
        final bDate = DateTime.tryParse(b.thoiGianRa ?? '') ?? DateTime(1900);
        return bDate.compareTo(aDate); // latest first
      });

    return sorted.first.dangKyId;
  }

  Future<void> _loginWithPatientCode(
    String patientCode, {
    bool auto = false,
  }) async {
    if (_isBusy) return;
    if (patientCode.isEmpty) {
      Fluttertoast.showToast(msg: 'Vui lòng nhập mã bệnh nhân');
      return;
    }

    setState(() => _isBusy = true);
    try {
      final ok = await store.getUserBusiness(
        maYte: patientCode,
        password: patientCode,
      );

      if (!ok) {
        if (!auto) Fluttertoast.showToast(msg: 'Đăng nhập thất bại');
        return;
      }

      await _savePatientCode(patientCode);

      // ✅ Load lịch sử khám để lấy dangKyId mới nhất
      await store.loadHistoryRecord(fromDate: null, toDate: null);

      final latestId = _getLatestDangKyId();
      if (!mounted) return;

      if (latestId == null || latestId.isEmpty) {
        Fluttertoast.showToast(msg: 'Không có dữ liệu khám để xem chi tiết');
        return;
      }

      if (!auto) Fluttertoast.showToast(msg: 'Đăng nhập thành công');
      Modular.to.pushReplacementNamed(
        AppRoutes.detailBusinessPageForHis,
        arguments: {'idBusiness': latestId},
      );
    } finally {
      if (mounted) setState(() => _isBusy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Tra cứu TTBN',
        isBack: true,
      ),
      backgroundColor: const Color(0xFFF6F7FB),
      body: Stack(
        children: [
          Container(
            height: 220,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary.withOpacity(0.95),
                  AppColors.primary.withOpacity(0.70),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(18, 16, 18, 24),
              child: Column(
                children: [
                  const SizedBox(height: 8),

                  /// Header
                  Row(
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 16,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Image.asset(ImageEnum.logopstbColor),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'TRA CỨU TTBN\nBệnh Viện Phụ sản Thái Bình',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            height: 1.25,
                            fontSize: 14.5,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  /// Card login
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nhập mã bệnh nhân để xem HSBA',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 14),
                        TextField(
                          controller: _patientCodeCtrl,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Mã bệnh nhân',
                            hintText: 'Ví dụ: 25055656',
                            prefixIcon: const Icon(Icons.badge_outlined),
                            filled: true,
                            fillColor: const Color(0xFFF7F8FC),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: _isBusy
                                ? null
                                : () => _loginWithPatientCode(
                                      _patientCodeCtrl.text.trim(),
                                    ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: _isBusy
                                ? const SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text(
                                    'Tra cứu',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 18),

                  /// Footer
                  Text(
                    'Phát triển bởi Công ty cổ phần Onenet\n'
                    'Địa chỉ: Số 2 Nguyễn Hoàng, Nam Từ Liêm, Hà Nội',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black.withOpacity(0.65),
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
