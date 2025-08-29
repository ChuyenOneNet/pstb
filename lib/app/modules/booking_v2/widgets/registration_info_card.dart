import 'package:flutter/material.dart';

class RegistrationInfoCard extends StatelessWidget {
  final TextEditingController examNoCtrl;
  final DateTime scheduledAt;
  final VoidCallback onPickScheduledAt;
  final String subjectType;
  final ValueChanged<String?> onSubjectTypeChanged;
  final String visitType;
  final ValueChanged<String?> onVisitTypeChanged;
  final String department;
  final ValueChanged<String> onDepartmentChanged;
  final TextEditingController reasonCtrl;
  final String priority;
  final ValueChanged<String?> onPriorityChanged;
  final String arrivalMethod;
  final ValueChanged<String?> onArrivalMethodChanged;
  final TextEditingController kcbCodeCtrl;

  const RegistrationInfoCard({
    Key? key,
    required this.examNoCtrl,
    required this.scheduledAt,
    required this.onPickScheduledAt,
    required this.subjectType,
    required this.onSubjectTypeChanged,
    required this.visitType,
    required this.onVisitTypeChanged,
    required this.department,
    required this.onDepartmentChanged,
    required this.reasonCtrl,
    required this.priority,
    required this.onPriorityChanged,
    required this.arrivalMethod,
    required this.onArrivalMethodChanged,
    required this.kcbCodeCtrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final green = Colors.green.shade700;
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            decoration: BoxDecoration(
                color: green.withOpacity(0.08),
                borderRadius: BorderRadius.circular(6)),
            child: Text(
              'Thông tin đăng ký',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: green, fontSize: 16),
            ),
          ),
          const SizedBox(height: 12),
          _buildField(TextFormField(
            controller: examNoCtrl,
            decoration: const InputDecoration(labelText: 'Số khám'),
          )),
          _buildField(InkWell(
            onTap: onPickScheduledAt,
            child: InputDecorator(
              decoration: const InputDecoration(labelText: 'Ngày giờ khám'),
              child: Text(
                '${scheduledAt.day}/${scheduledAt.month}/${scheduledAt.year} '
                '${scheduledAt.hour}:${scheduledAt.minute.toString().padLeft(2, '0')}',
              ),
            ),
          )),
          _buildField(DropdownButtonFormField<String>(
            value: subjectType,
            decoration: const InputDecoration(labelText: 'Đối tượng *'),
            items: const [
              DropdownMenuItem(value: 'Không BHYT', child: Text('Không BHYT')),
              DropdownMenuItem(value: 'BHYT', child: Text('BHYT')),
              DropdownMenuItem(value: 'Khác', child: Text('Khác')),
            ],
            onChanged: onSubjectTypeChanged,
            validator: (v) => v == null || v.isEmpty ? 'Bắt buộc' : null,
          )),
          _buildField(DropdownButtonFormField<String>(
            value: visitType,
            decoration: const InputDecoration(labelText: 'Loại khám'),
            items: const [
              DropdownMenuItem(value: 'Khám bệnh', child: Text('Khám bệnh')),
              DropdownMenuItem(value: 'Trực tiếp', child: Text('Trực tiếp')),
              DropdownMenuItem(
                  value: 'Khám cấp cứu', child: Text('Khám cấp cứu')),
            ],
            onChanged: onVisitTypeChanged,
          )),
          _buildField(TextFormField(
            initialValue: department,
            decoration: const InputDecoration(labelText: 'Khoa/Phòng *'),
            onChanged: onDepartmentChanged,
            validator: (v) => v == null || v.isEmpty ? 'Bắt buộc' : null,
          )),
          _buildField(TextFormField(
            controller: reasonCtrl,
            decoration: const InputDecoration(labelText: 'Lý do đến khám *'),
            validator: (v) => v == null || v.isEmpty ? 'Bắt buộc' : null,
          )),
          _buildField(DropdownButtonFormField<String>(
            value: priority,
            decoration: const InputDecoration(labelText: 'Ưu tiên'),
            items: const [
              DropdownMenuItem(
                  value: 'Bình thường', child: Text('Bình thường')),
              DropdownMenuItem(value: 'Cấp cứu', child: Text('Cấp cứu')),
            ],
            onChanged: onPriorityChanged,
          )),
          _buildField(DropdownButtonFormField<String>(
            value: arrivalMethod,
            decoration: const InputDecoration(labelText: 'Hình thức'),
            items: const [
              DropdownMenuItem(value: 'Tự đến', child: Text('Tự đến')),
              DropdownMenuItem(value: 'Khám từ xa', child: Text('Khám từ xa')),
            ],
            onChanged: onArrivalMethodChanged,
          )),
          _buildField(TextFormField(
            controller: kcbCodeCtrl,
            decoration: const InputDecoration(labelText: 'Mã ĐT KCB'),
          )),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(6)),
            child: const Text(
              'Ghi chú: Nếu không chọn phòng -> cần đến quầy tiếp nhận để sắp xếp phòng khám.',
              style: TextStyle(fontSize: 13),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildField(Widget child) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: child,
    );
  }
}
