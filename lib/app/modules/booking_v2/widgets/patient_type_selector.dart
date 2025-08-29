import 'package:flutter/material.dart';
import '../../../../utils/colors.dart';

class PatientTypeSelector extends StatelessWidget {
  final String patientType;
  final Function(String) onChanged;

  const PatientTypeSelector({
    Key? key,
    required this.patientType,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Chọn đối tượng khám *',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade400),
          ),
          child: Row(
            children: [
              Expanded(
                child: RadioListTile<String>(
                  activeColor: AppColors.primary,
                  title: const Text('Cá nhân'),
                  value: 'Cá nhân',
                  groupValue: patientType,
                  onChanged: (v) => v != null ? onChanged(v) : null,
                ),
              ),
              Expanded(
                child: RadioListTile<String>(
                  activeColor: AppColors.primary,
                  title: const Text('Người thân'),
                  value: 'Người thân',
                  groupValue: patientType,
                  onChanged: (v) => v != null ? onChanged(v) : null,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
