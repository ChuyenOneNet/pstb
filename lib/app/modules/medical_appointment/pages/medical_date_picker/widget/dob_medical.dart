import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:pstb/app/modules/medical_appointment/pages/medical_date_picker/medical_store.dart';
import 'package:pstb/app/modules/medical_appointment/pages/medical_date_picker/widget/type_personal_widget.dart';
import 'package:pstb/utils/main.dart';
import '../../../../../../utils/format_util.dart';
import '../../../../../../utils/time_util.dart';

class DobMedicalWidget extends StatelessWidget {
  final TextEditingController controller;
  final PersonalType? personalType;
  late final String dob;
  DobMedicalWidget(
      {Key? key,
      this.validator,
      required this.controller,
      this.personalType,
      required this.dob})
      : super(key: key);
  final String? Function(String?)? validator;
  void buildMaterialDatePicker(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: personalType == PersonalType.personal &&
              controller.text.trim().isNotEmpty
          ? DateFormat(TimeUtil.ViewDateFormat).parse(controller.text)
          : DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ))!;
    controller.text = TimeUtil.format(picked, TimeUtil.ViewDateFormat);
    dob = TimeUtil.format(picked, TimeUtil.ViewDateFormat);
  }

  void buildCupertinoDatePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height / 3,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (picked) {
                controller.text =
                    TimeUtil.format(picked, TimeUtil.ViewDateFormat);
                dob = TimeUtil.format(picked, TimeUtil.ViewDateFormat);
              },
              initialDateTime: personalType == PersonalType.personal &&
                      controller.text.trim().isNotEmpty
                  ? DateFormat(TimeUtil.ViewDateFormat).parse(controller.text)
                  : DateTime.now(),
              minimumYear: 1900,
              maximumYear: DateTime.now().year,
            ),
          );
        });
  }

  void handleDatePicker(BuildContext context) {
    FocusScope.of(context).unfocus();
    final ThemeData theme = Theme.of(context);
    switch (theme.platform) {
      case TargetPlatform.android:
        return buildMaterialDatePicker(context);
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
      case TargetPlatform.iOS:
        return buildCupertinoDatePicker(context);
      case TargetPlatform.macOS:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: TextFormField(
          style: Styles.content,
          // onChanged: _controller.onChangeBirthday,
          controller: controller,
          inputFormatters: [
            MaskTextInputFormatter(
                mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')})
          ],
          validator: validator,
          decoration: InputDecoration(
            hintText: 'Ngày sinh *',
            hintStyle: Styles.content,
            labelText: 'Ngày sinh *',
            errorStyle: Styles.content,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            suffixIcon: IconButton(
                onPressed: () {
                  handleDatePicker(context);
                },
                icon: SvgPicture.asset(
                  IconEnums.calendar,
                  width: 16,
                  height: 16,
                  color: AppColors.primary,
                  fit: BoxFit.contain,
                )),
          ),
        ));
  }
}
