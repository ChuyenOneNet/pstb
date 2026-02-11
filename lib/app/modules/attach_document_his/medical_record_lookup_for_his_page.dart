import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pstb/app/modules/attach_document_his/widgets/medical_record_result_section.dart';
import 'package:pstb/app/modules/attach_document_his/widgets/patient_code_search_section.dart';
import 'package:pstb/app/modules/business/business_store.dart';
import 'package:pstb/utils/colors.dart';
import 'package:pstb/utils/images.dart';
import 'package:pstb/widgets/stateless/app_bar.dart';

class MedicalRecordLookupForHisPage extends StatefulWidget {
  const MedicalRecordLookupForHisPage({Key? key}) : super(key: key);

  @override
  State<MedicalRecordLookupForHisPage> createState() =>
      _MedicalRecordLookupForHisPageState();
}

class _MedicalRecordLookupForHisPageState
    extends State<MedicalRecordLookupForHisPage> {
  final BusinessStore store = Modular.get<BusinessStore>();
  final TextEditingController _patientCodeCtrl = TextEditingController();

  bool _isSearching = false;
  bool _hasSearched = false;

  @override
  void dispose() {
    _patientCodeCtrl.dispose();
    super.dispose();
  }

  Future<void> _search() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (_isSearching) return;

    final code = _patientCodeCtrl.text.trim();
    if (code.isEmpty) {
      Fluttertoast.showToast(msg: 'Vui lòng nhập mã bệnh nhân');
      return;
    }

    setState(() => _isSearching = true);
    try {
      // 1) Login ngầm để lấy token/session (theo cách bạn đang làm)
      final ok = await store.getUserBusiness(maYte: code, password: code);
      if (!ok) {
        Fluttertoast.showToast(msg: 'Tra cứu thất bại (mã không hợp lệ)');
        setState(() => _hasSearched = true);
        return;
      }

      // 2) Load lịch sử khám chữa bệnh (mặc định toàn bộ)
      await store.loadHistoryRecord(fromDate: null, toDate: null);

      if (!mounted) return;
      setState(() => _hasSearched = true);
    } catch (e) {
      Fluttertoast.showToast(msg: 'Có lỗi khi tra cứu');
    } finally {
      if (mounted) setState(() => _isSearching = false);
    }
  }

  void _clear() {
    _patientCodeCtrl.clear();
    setState(() {
      _hasSearched = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Đính kèm tài liệu HSBA',
        isBack: true,
      ),
      backgroundColor: const Color(0xFFF6F7FB),
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(18, 16, 18, 24),
              child: Column(
                children: [
                  // Card nhập mã + tra cứu
                  PatientCodeSearchSection(
                    controller: _patientCodeCtrl,
                    isBusy: _isSearching,
                    onSearch: _search,
                    onClear: _hasSearched ? _clear : null,
                  ),

                  const SizedBox(height: 14),

                  // Kết quả: thông tin BN + filter + list (chỉ hiện sau khi tra cứu)
                  if (_hasSearched)
                    MedicalRecordResultSection(
                      store: store,
                    ),

                  const SizedBox(height: 18),

                  // Footer
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
