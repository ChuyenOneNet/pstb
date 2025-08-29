import 'package:flutter/material.dart';
import '../../../../utils/colors.dart';
import '../../../../widgets/text_field/input_text_field.dart';

class ParentInfoForm extends StatelessWidget {
  final TextEditingController fatherNameController;
  final TextEditingController motherNameController;
  final TextEditingController ageController;

  const ParentInfoForm({
    Key? key,
    required this.fatherNameController,
    required this.motherNameController,
    required this.ageController,
  }) : super(key: key);

  String? _validateParentName(String? value, String otherParentName) {
    final age = int.tryParse(ageController.text.trim());
    if (age != null && age < 16) {
      if ((value == null || value.trim().isEmpty) &&
          otherParentName.trim().isEmpty) {
        return 'Phải nhập tên bố hoặc mẹ';
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputTextField(
          textController: fatherNameController,
          label: 'Họ tên bố',
          prefixIcon:
              const Icon(Icons.male, size: 20, color: AppColors.primary),
          validator: (v) => _validateParentName(v, motherNameController.text),
          textAlign: TextAlign.start,
        ),
        const SizedBox(height: 14),
        InputTextField(
          textController: motherNameController,
          label: 'Họ tên mẹ',
          prefixIcon:
              const Icon(Icons.female, size: 20, color: AppColors.primary),
          validator: (v) => _validateParentName(v, fatherNameController.text),
          textAlign: TextAlign.start,
        ),
      ],
    );
  }
}
