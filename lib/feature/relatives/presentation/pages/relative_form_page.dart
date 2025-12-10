import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../app/modules/booking_v2/qr_scanner_screen.dart';
import '../../../../constant/color.dart';
import '../../data/models/relative_model.dart';
import '../cubit/relative_form_cubit.dart';

class RelativeFormPage extends StatefulWidget {
  final String mainCccd;
  final int? relativeId;

  const RelativeFormPage({
    super.key,
    required this.mainCccd,
    this.relativeId,
  });

  @override
  State<RelativeFormPage> createState() => _RelativeFormPageState();
}

class _RelativeFormPageState extends State<RelativeFormPage> {
  final _formKey = GlobalKey<FormState>();

  final _fullNameC = TextEditingController();
  final _dobC = TextEditingController();
  final _cccdC = TextEditingController();
  final _phoneC = TextEditingController();
  final _patientCodeC = TextEditingController();
  final _addressC = TextEditingController();
  final _wardC = TextEditingController();
  final _cityC = TextEditingController();
  final _ethnicityC = TextEditingController();
  final _occupationC = TextEditingController();
  final _countryC = TextEditingController();

  String? _relationship;

  static const _relationshipOptions = [
    {'code': 'CHA', 'label': 'Cha', 'icon': Icons.man},
    {'code': 'MẸ', 'label': 'Mẹ', 'icon': Icons.woman},
    {'code': 'CON', 'label': 'Con', 'icon': Icons.child_friendly},
    {'code': 'VO_CHONG', 'label': 'Vợ/Chồng', 'icon': Icons.favorite},
    {'code': 'ANH_CHI_EM', 'label': 'Anh chị em', 'icon': Icons.people_alt},
    {'code': 'ONG_BA', 'label': 'Ông bà', 'icon': Icons.elderly},
    {'code': 'KHAC', 'label': 'Khác', 'icon': Icons.person_outline},
  ];

  @override
  void initState() {
    super.initState();
    if (widget.relativeId != null) {
      context
          .read<RelativeFormCubit>()
          .loadDetail(widget.mainCccd, widget.relativeId!);
    }
  }

  @override
  void dispose() {
    _fullNameC.dispose();
    _dobC.dispose();
    _cccdC.dispose();
    _phoneC.dispose();
    _patientCodeC.dispose();
    _addressC.dispose();
    _wardC.dispose();
    _cityC.dispose();
    _ethnicityC.dispose();
    _occupationC.dispose();
    _countryC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.relativeId != null;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Text(
          isEdit ? 'Chỉnh sửa' : 'Thêm người thân',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner, size: 26),
            onPressed: _onScanQR,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: BlocConsumer<RelativeFormCubit, RelativeFormState>(
        listener: (context, state) {
          if (state.initial != null && isEdit) {
            _bindInitial(state.initial!);
          }
          if (state.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content:
                    Text(isEdit ? 'Cập nhật thành công!' : 'Thêm thành công!'),
                backgroundColor: Colors.green[700],
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            );
            Navigator.pop(context, true);
          }
          if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error!),
                backgroundColor: Colors.red[700],
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            );
          }
        },
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 100),
              children: [
                _buildSection('Thông tin cơ bản', [
                  _field(_fullNameC, 'Họ và tên *', Icons.person_outline,
                      validator: (v) =>
                          v?.trim().isEmpty ?? true ? 'Bắt buộc' : null),
                  _field(_dobC, 'Ngày sinh (dd/MM/yyyy) *',
                      Icons.calendar_today_outlined,
                      validator: _validateDob),
                  _field(_cccdC, 'CCCD/CMND *', Icons.credit_card_outlined,
                      keyboardType: TextInputType.number,
                      validator: _validateCccd),
                  _field(_phoneC, 'Số điện thoại *', Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                      validator: _validatePhone),
                  _field(
                      _patientCodeC, 'Mã bệnh nhân *', Icons.qr_code_2_outlined,
                      validator: (v) =>
                          v?.trim().isEmpty ?? true ? 'Bắt buộc' : null),
                  const SizedBox(height: 16),
                  _buildRelationshipChips(),
                ]),
                const SizedBox(height: 20),
                _buildSection('Địa chỉ', [
                  _field(_addressC, 'Số nhà, đường...', Icons.home_outlined,
                      maxLines: 2),
                  Row(
                    children: [
                      Expanded(
                          child: _field(_wardC, 'Phường/Xã',
                              Icons.location_city_outlined)),
                      const SizedBox(width: 12),
                      Expanded(
                          child: _field(_cityC, 'Tỉnh/Thành phố',
                              Icons.apartment_outlined)),
                    ],
                  ),
                ]),
                const SizedBox(height: 20),
                _buildSection('Thông tin khác', [
                  Row(
                    children: [
                      Expanded(
                          child: _field(_occupationC, 'Nghề nghiệp',
                              Icons.work_outline_outlined)),
                      const SizedBox(width: 12),
                      Expanded(
                          child: _field(
                              _ethnicityC, 'Dân tộc', Icons.groups_outlined)),
                    ],
                  ),
                  _field(_countryC, 'Quốc gia', Icons.public_outlined),
                ]),
                const SizedBox(height: 32),
                FilledButton(
                  onPressed: state.loading ? null : _onSubmit,
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    backgroundColor: AppColors.primaryColor,
                  ),
                  child: state.loading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2.5),
                        )
                      : Text(
                          isEdit ? 'Lưu thay đổi' : 'Thêm người thân',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 12,
                  offset: const Offset(0, 4)),
            ],
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _field(
    TextEditingController controller,
    String label,
    IconData icon, {
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: AppColors.primaryColor),
          filled: true,
          fillColor: const Color(0xFFFBFCFE),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.red[400]!),
          ),
        ),
      ),
    );
  }

  Widget _buildRelationshipChips() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Mối quan hệ *',
            style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: _relationshipOptions.map((opt) {
            final selected = _relationship == opt['code'];
            return FilterChip(
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    opt['icon'] as IconData,
                    size: 18,
                    color:
                        selected ? AppColors.whiteColor : AppColors.blackColor,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    opt['label'] as String,
                    style: TextStyle(
                      color: selected
                          ? AppColors.whiteColor
                          : AppColors.blackColor,
                    ),
                  ),
                ],
              ),
              selected: selected,
              onSelected: (_) =>
                  setState(() => _relationship = opt['code'] as String?),
              selectedColor: AppColors.primaryColor,
              checkmarkColor: Colors.white,
              backgroundColor: Colors.grey[100],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            );
          }).toList(),
        ),
      ],
    );
  }

  void _bindInitial(RelativeModel m) {
    _fullNameC.text = m.fullName;
    _dobC.text = _normalizeDobToDdMMyyyy(m.dob) ?? m.dob;
    _cccdC.text = m.cccd;
    _phoneC.text = m.phone;
    _patientCodeC.text = m.patientCode;
    _addressC.text = m.addressDetail ?? '';
    _wardC.text = m.ward ?? '';
    _cityC.text = m.city ?? '';
    _ethnicityC.text = m.ethnicity ?? '';
    _occupationC.text = m.occupation ?? '';
    _countryC.text = m.country ?? '';
    _relationship = m.relationship;
  }

  Future<void> _onScanQR() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) => QRScannerScreen(onQRScanned: _handleScannedQr)),
    );
  }

  void _handleScannedQr(String raw) {
    final parsed = _tryParseQr(raw);
    if (parsed['name'] != null) _fullNameC.text = parsed['name']!;
    if (parsed['cccd'] != null) _cccdC.text = parsed['cccd']!;
    if (parsed['dob'] != null) {
      final formatted = _normalizeDobToDdMMyyyy(parsed['dob']!);
      if (formatted != null) _dobC.text = formatted;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Đã nhập thông tin từ QR'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Map<String, String?> _tryParseQr(String raw) {
    final out = <String, String?>{'name': null, 'cccd': null, 'dob': null};

    try {
      final j = json.decode(raw);
      if (j is Map) {
        out['name'] =
            (j['name'] ?? j['hoTen'] ?? j['fullName'] ?? j['Họ và tên'])
                ?.toString();
        out['cccd'] = (j['id'] ?? j['cccd'] ?? j['cmnd'] ?? j['identifyNumber'])
            ?.toString();
        out['dob'] = (j['dob'] ?? j['birthDate'] ?? j['ngaySinh'])?.toString();
        return out;
      }
    } catch (_) {}

    final separators = ['\n', '|', ';', ','];
    for (final sep in separators) {
      if (raw.contains(sep)) {
        final parts = raw.split(sep);
        for (final p in parts) {
          final kv = p.split(RegExp(r'[:=]'));
          if (kv.length >= 2) {
            final k = kv[0].trim().toLowerCase();
            final v = kv.sublist(1).join(':').trim();

            if (k.contains('name') ||
                k.contains('hoten') ||
                k.contains('ho ten') ||
                k.contains('fullname')) {
              out['name'] = v;
            }
            if (k.contains('cccd') ||
                k.contains('cmnd') ||
                k.contains('id') ||
                k.contains('identify')) {
              out['cccd'] = v.replaceAll(RegExp(r'[^0-9]'), '');
            }
            if (k.contains('dob') ||
                k.contains('birth') ||
                k.contains('ngaysinh')) {
              out['dob'] = v;
            }
          }
        }
        if (out['cccd'] != null || out['name'] != null) return out;
      }
    }

    final idMatch = RegExp(r'\b(\d{12}|\d{9})\b').firstMatch(raw);
    if (idMatch != null) out['cccd'] = idMatch.group(1);

    final lines = raw.split(RegExp(r'[\r\n]+'));
    for (final l in lines) {
      final t = l.trim();
      if (t.length > 4 &&
          RegExp(r'^[\p{L} \.\-]+$', unicode: true).hasMatch(t)) {
        out['name'] ??= t;
      }
      final dateMatch = RegExp(r'(\d{2}[/\-]\d{2}[/\-]\d{4})').firstMatch(t);
      if (dateMatch != null && out['dob'] == null) {
        out['dob'] = dateMatch.group(1);
      }
    }

    return out;
  }

  String? _normalizeDobToDdMMyyyy(String raw) {
    raw = raw.trim();
    DateTime? dt;

    try {
      dt = DateTime.parse(raw);
    } catch (_) {}

    dt ??= _tryParseWithFormat(raw, 'dd/MM/yyyy');
    dt ??= _tryParseWithFormat(raw, 'dd-MM-yyyy');

    if (dt == null) return null;
    return DateFormat('dd/MM/yyyy').format(dt);
  }

  DateTime? _tryParseWithFormat(String input, String pattern) {
    try {
      return DateFormat(pattern).parseStrict(input);
    } catch (_) {
      return null;
    }
  }

  String? _validateDob(String? value) {
    if (value == null || value.trim().isEmpty) return 'Bắt buộc';
    final norm = _normalizeDobToDdMMyyyy(value);
    if (norm == null) return 'Ngày sinh không hợp lệ';
    try {
      final dt = DateFormat('dd/MM/yyyy').parseStrict(norm);
      if (dt.isAfter(DateTime.now()))
        return 'Ngày sinh không được lớn hơn hiện tại';
    } catch (_) {
      return 'Ngày sinh không hợp lệ';
    }
    return null;
  }

  String? _validateCccd(String? value) {
    if (value == null || value.trim().isEmpty) return 'Bắt buộc';
    final v = value.trim();
    if (!RegExp(r'^\d{9}$|^\d{12}$').hasMatch(v))
      return 'CCCD/CMND phải 9 hoặc 12 chữ số';
    if (v == widget.mainCccd) return 'Không được thêm chính mình';
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) return 'Bắt buộc';
    final v = value.trim();
    if (!RegExp(r'^(0|\+84)\d{9}$').hasMatch(v))
      return 'Số điện thoại không hợp lệ';
    return null;
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;

    final dobNorm = _normalizeDobToDdMMyyyy(_dobC.text.trim())!;
    final dt = DateFormat('dd/MM/yyyy').parseStrict(dobNorm);
    final dobApi = DateFormat('yyyy-MM-dd').format(dt);

    final model = RelativeModel(
      id: widget.relativeId,
      mainCccd: widget.mainCccd,
      fullName: _fullNameC.text.trim(),
      dob: dobApi,
      cccd: _cccdC.text.trim(),
      phone: _phoneC.text.trim(),
      patientCode: _patientCodeC.text.trim(),
      addressDetail:
          _addressC.text.trim().isEmpty ? null : _addressC.text.trim(),
      city: _cityC.text.trim().isEmpty ? null : _cityC.text.trim(),
      ward: _wardC.text.trim().isEmpty ? null : _wardC.text.trim(),
      ethnicity:
          _ethnicityC.text.trim().isEmpty ? null : _ethnicityC.text.trim(),
      occupation:
          _occupationC.text.trim().isEmpty ? null : _occupationC.text.trim(),
      country: _countryC.text.trim().isEmpty ? null : _countryC.text.trim(),
      relationship: _relationship,
    );

    if (widget.relativeId != null) {
      context
          .read<RelativeFormCubit>()
          .submitUpdate(widget.mainCccd, widget.relativeId!, model);
    } else {
      context.read<RelativeFormCubit>().submitAdd(widget.mainCccd, model);
    }
  }
}
