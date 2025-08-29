import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:pstb/utils/main.dart';
import '../../../../../../utils/format_util.dart';
import '../../../../../../utils/time_util.dart';
import '../../edit_profile_page/edit_profile_store.dart';

class DobEditProfile extends StatelessWidget {
  final EditProfileStore _controller = Modular.get<EditProfileStore>();

  DobEditProfile({Key? key}) : super(key: key);

  void buildMaterialDatePicker(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: _controller.hadBirthday
          ? DateTime.parse(FormatUtil.formatDateTime(_controller.birthday))
          : DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ))!;
    _controller
        .onChangeBirthday(TimeUtil.format(picked, TimeUtil.ViewDateFormat));
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
                _controller.onChangeBirthday(
                    TimeUtil.format(picked, TimeUtil.ViewDateFormat));
              },
              initialDateTime: _controller.hadBirthday
                  ? DateFormat(TimeUtil.ViewDateFormat)
                      .parse(_controller.birthday)
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
    return Observer(builder: (_) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: SizedBox(
                height: 24,
                width: 24,
                child: SvgPicture.asset(IconEnums.iconCake)),
          ),
          Expanded(
              child: TextField(
            onChanged: _controller.onChangeBirthday,
            controller: _controller.dobController,
            inputFormatters: [
              MaskTextInputFormatter(
                  mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')})
            ],
            style: Styles.subtitleSmallest,
            decoration: InputDecoration(
              labelText: 'Nhập ngày tháng năm sinh',
              hintStyle:
                  const TextStyle(color: AppColors.gray500, fontSize: 14),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
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
          ))
        ]),
      );
    });
  }
}
