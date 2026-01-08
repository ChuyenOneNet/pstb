import 'package:flutter/material.dart';

import '../../../../../../constant/color.dart';

class PickValue {
  final String code;
  final String label;
  const PickValue(this.code, this.label);
}

class FilterBar extends StatefulWidget {
  final void Function(
      String? search, // không dùng ở đây nhưng giữ signature cũ
      String? departmentCode,
      DateTime? from,
      DateTime? to,
      String? patientCode,
      {String? roleCode}) onApply;
  final VoidCallback? onReset;

  // callback mở selector (trả về code+label để hiện chip trong sheet)
  final Future<PickValue?> Function()? onPickRole;
  final Future<PickValue?> Function()? onPickDepartment;
  final Future<PickValue?> Function()? onPickPatient;

  // giá trị ban đầu để hiển thị chip trong sheet
  final String? initRoleLabel;
  final String? initDeptLabel;
  final String? initPatientLabel;
  final DateTime? initFrom;
  final DateTime? initTo;

  const FilterBar({
    super.key,
    required this.onApply,
    this.onReset,
    this.onPickRole,
    this.onPickDepartment,
    this.onPickPatient,
    this.initRoleLabel,
    this.initDeptLabel,
    this.initPatientLabel,
    this.initFrom,
    this.initTo,
  });

  @override
  State<FilterBar> createState() => _FilterBarState();
}

class _FilterBarState extends State<FilterBar> {
  String? _roleCode, _roleLabel;
  String? _deptCode, _deptLabel;
  String? _patientCode, _patientLabel;
  DateTime? _from, _to;

  @override
  void initState() {
    super.initState();
    _roleLabel = widget.initRoleLabel;
    _deptLabel = widget.initDeptLabel;
    _patientLabel = widget.initPatientLabel;
    _from = widget.initFrom;
    _to = widget.initTo;
  }

  String _fmtRange() {
    if (_from == null || _to == null) return 'Chọn ngày';
    return '${_from!.day}/${_from!.month} - ${_to!.day}/${_to!.month}';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Material(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                      color: const Color(0xFFE5E7EB),
                      borderRadius: BorderRadius.circular(2))),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Expanded(
                      child: Text('Bộ lọc',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700))),
                  IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context)),
                ],
              ),
              const SizedBox(height: 8),

              // Nút thao tác
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _actionButton(
                    icon: Icons.badge,
                    label: _roleLabel ?? 'Chọn vai trò',
                    onTap: () async {
                      final res = await widget.onPickRole?.call();
                      if (res != null)
                        setState(() {
                          _roleCode = res.code;
                          _roleLabel = res.label;
                        });
                    },
                  ),
                  _actionButton(
                    icon: Icons.domain,
                    label: _deptLabel ?? 'Chọn khoa',
                    onTap: () async {
                      final res = await widget.onPickDepartment?.call();
                      if (res != null)
                        setState(() {
                          _deptCode = res.code;
                          _deptLabel = res.label;
                        });
                    },
                  ),
                  _actionButton(
                    icon: Icons.person_search,
                    label: _patientLabel ?? 'Chọn BN',
                    onTap: () async {
                      final res = await widget.onPickPatient?.call();
                      if (res != null)
                        setState(() {
                          _patientCode = res.code;
                          _patientLabel = res.label;
                        });
                    },
                  ),
                  _actionButton(
                    icon: Icons.calendar_today,
                    label: _fmtRange(),
                    onTap: () async {
                      final now = DateTime.now();
                      final rng = await showDateRangePicker(
                        context: context,
                        initialDateRange: (_from != null && _to != null)
                            ? DateTimeRange(start: _from!, end: _to!)
                            : null,
                        firstDate: DateTime(now.year - 1),
                        lastDate: DateTime(now.year + 1),
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: const ColorScheme.light(
                                  primary: Color(0xFF1E7FFF),
                                  onPrimary: Colors.white),
                            ),
                            child: child!,
                          );
                        },
                      );
                      if (rng != null)
                        setState(() {
                          _from = rng.start;
                          _to = rng.end;
                        });
                    },
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Chip tóm tắt lựa chọn ngay trong sheet
              Align(
                alignment: Alignment.centerLeft,
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    if (_roleLabel != null)
                      InputChip(
                          side: BorderSide(color: AppColors.primaryColor),
                          backgroundColor: AppColors.whiteColor,
                          label: Text(
                            'Vai trò: $_roleLabel',
                            style: TextStyle(color: AppColors.blackColor),
                          ),
                          onDeleted: () => setState(() {
                                _roleCode = null;
                                _roleLabel = null;
                              })),
                    if (_deptLabel != null)
                      InputChip(
                          side: BorderSide(color: AppColors.primaryColor),
                          backgroundColor: AppColors.whiteColor,
                          label: Text(
                            'Khoa: $_deptLabel',
                            style: TextStyle(color: AppColors.blackColor),
                          ),
                          onDeleted: () => setState(() {
                                _deptCode = null;
                                _deptLabel = null;
                              })),
                    if (_patientLabel != null)
                      InputChip(
                          side: BorderSide(color: AppColors.primaryColor),
                          backgroundColor: AppColors.whiteColor,
                          label: Text(
                            'BN: $_patientLabel',
                            style: TextStyle(color: AppColors.blackColor),
                          ),
                          onDeleted: () => setState(() {
                                _patientCode = null;
                                _patientLabel = null;
                              })),
                    if (_from != null && _to != null)
                      InputChip(
                          side: BorderSide(color: AppColors.primaryColor),
                          backgroundColor: AppColors.whiteColor,
                          label: Text(
                            'Ngày: ${_fmtRange()}',
                            style: TextStyle(color: AppColors.blackColor),
                          ),
                          onDeleted: () => setState(() {
                                _from = null;
                                _to = null;
                              })),
                  ],
                ),
              ),

              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                            color: AppColors.primaryColor, width: 1.5),
                      ),
                      icon: const Icon(
                        Icons.refresh,
                        color: AppColors.primaryColor,
                      ),
                      label: const Text(
                        'Đặt lại',
                        style: TextStyle(color: AppColors.primaryColor),
                      ),
                      onPressed: () {
                        setState(() {
                          _roleCode = _deptCode = _patientCode = null;
                          _roleLabel = _deptLabel = _patientLabel = null;
                          _from = _to = null;
                        });
                        widget.onReset?.call();
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1E7FFF)),
                      onPressed: () {
                        widget.onApply(
                          null, // search
                          _deptCode, _from, _to, _patientCode,
                          roleCode: _roleCode,
                        );
                        Navigator.pop(context);
                      },
                      child: const Text('Áp dụng',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _actionButton(
      {required IconData icon,
      required String label,
      required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: [Color(0xFFF0F7FF), Color(0xFFE0EFFF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFBFDFFF), width: 1.5),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(icon, size: 18, color: const Color(0xFF1E7FFF)),
          const SizedBox(width: 8),
          Text(label,
              style: const TextStyle(
                  fontWeight: FontWeight.w600, color: Color(0xFF1E7FFF))),
        ]),
      ),
    );
  }
}
