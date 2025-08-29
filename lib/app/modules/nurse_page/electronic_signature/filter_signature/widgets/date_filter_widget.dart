import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pstb/app/modules/nurse_page/electronic_signature/filter_signature/filter_signature_store.dart';
import 'package:pstb/utils/date_time_custom_utils.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class DateFilterWidget extends StatelessWidget {
  DateFilterWidget({Key? key}) : super(key: key);
  final _filterSignatureStore = Modular.get<FilterSignatureStore>();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Thời gian',
          style: Styles.heading4,
        ),
        const SizedBox(
          height: 4,
        ),
        Observer(builder: (context) {
          return Row(
            children: [
              Expanded(
                child: _ButtonTimerWidget(
                  title: 'Từ ngày',
                  timer: _filterSignatureStore.fromDate,
                  onTap: () {
                    showBarModalBottomSheet(
                        context: context,
                        barrierColor: AppColors.black.withOpacity(0.5),
                        builder: (_) => Container(
                              height: heightConvert(context, 250),
                              color: AppColors.background,
                              child: CupertinoDatePicker(
                                initialDateTime: DateTime.now(),
                                mode: CupertinoDatePickerMode.date,
                                onDateTimeChanged:
                                    _filterSignatureStore.onChangeStartDate,
                              ),
                            ));
                  },
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              Expanded(
                child: _ButtonTimerWidget(
                    title: 'Đến ngày',
                    timer: _filterSignatureStore.toDate,
                    onTap: () {
                      if (_filterSignatureStore.fromDate == null) {
                        Fluttertoast.showToast(
                            msg: 'Hãy chọn thời gian từ ngày');
                        return;
                      }
                      showCupertinoModalBottomSheet(
                          context: context,
                          barrierColor: AppColors.black.withOpacity(0.5),
                          builder: (_) => Container(
                                height: heightConvert(context, 250),
                                color: AppColors.background,
                                child: CupertinoDatePicker(
                                  initialDateTime: DateTime.now(),
                                  minimumDate:
                                      DateTimeCustomUtils.parseDatetime(
                                          dateTime:
                                              _filterSignatureStore.fromDate,
                                          parseTime: DateTimeFormatPattern
                                              .dobddMMyyyy),
                                  mode: CupertinoDatePickerMode.date,
                                  onDateTimeChanged:
                                      _filterSignatureStore.onChangeEndDate,
                                ),
                              ));
                    }),
              ),
            ],
          );
        }),
      ],
    );
  }
}

class _ButtonTimerWidget extends StatelessWidget {
  const _ButtonTimerWidget({
    Key? key,
    required this.title,
    required this.onTap,
    this.timer,
  }) : super(key: key);
  final String title;
  final Function() onTap;
  final String? timer;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title),
        AppButton(
          title: timer ?? '--/--/----',
          labelStyle: Styles.subtitleSmallest,
          onPressed: onTap,
          primaryColor: AppColors.lightSilver,
        ),
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }
}
