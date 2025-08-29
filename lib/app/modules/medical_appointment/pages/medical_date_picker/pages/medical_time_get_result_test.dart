import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';

import '../../../../../models/booking_detail_model.dart';
import '../widget/list_day_visit.dart';
import '../widget/list_time_visit.dart';
import '../medical_store.dart';

class MedicalTimeGetSample extends StatefulWidget {
  final Booking? booking;

  const MedicalTimeGetSample({Key? key, this.booking}) : super(key: key);

  @override
  _MedicalTimeGetSampleState createState() => _MedicalTimeGetSampleState();
}

class _MedicalTimeGetSampleState extends State<MedicalTimeGetSample> {
  final MedicalStore _controller = Modular.get<MedicalStore>();

  @override
  void initState() {
    _controller.changeBuildContext(context);
    refreshDataPicked();
    initBaseData(widget.booking != null);
    super.initState();
  }

  void initBaseData(bool withBooking) {
    DateTime dateGetSample = DateTime.now();
    int days = 0;
    // Xử lý khi thay đổi lịch khám
    // if (withBooking) {
    //   print('Thay đổi lịch khám ${widget.booking!.timeGetSample}');
    //   print('Thay đổi lịch khám ${widget.booking!.timeSeeDoctor}');
    //   dateGetSample = widget.booking!.timeGetSample ?? DateTime.now();
    //   days = widget.booking!.timeGetSample!.day - DateTime.now().day;
    // }
    print('Đặt mới cuộc khám');
    print(days);
    print(dateGetSample);

    _controller.initGetSampleData(days, dateGetSample);
  }

  void onEdit() {
    Modular.to.pushNamed(AppRoutes.medicalLocationGetSample);
  }

  void onContinue() {
    // print(_controller.getTimeSeeDoctor);
    // print(_controller.getTimeGetResult);
    if (widget.booking == null) {
      Modular.to.pushNamed(AppRoutes.appointmentConfirmAndPayment);
    } else {
      _controller.updateBooking(widget.booking!.id!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: l10n(context)!.medical_get_result_test_title,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _controller.getTimeSeeDoctor == null
                ? const SizedBox()
                : Container(
                    color: AppColors.background,
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Column(
                      children: [
                        Text(
                          l10n(context)!.medical_get_result_test_sub_title,
                          style: Styles.subtitleSmallest.copyWith(
                            color: AppColors.black,
                          ),
                        ),
                        Observer(
                          builder: (context) => RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: "vào: ",
                                  style: Styles.subtitleSmallest
                                      .copyWith(color: AppColors.black),
                                ),
                                TextSpan(
                                  text: DateFormat(
                                              DateTimeFormatPattern.formatHHmm)
                                          .format(_controller
                                              .listTimeVisit[
                                                  _controller.idTimeVisit!]
                                              .date) +
                                      " ",
                                  style: Styles.heading4
                                      .copyWith(color: AppColors.primary),
                                ),
                                TextSpan(
                                  text: DateTimeFormatPattern.weekDayConvert(
                                        context,
                                        _controller.listDayVisitDoctor[
                                            _controller.idDayPicked],
                                      ) +
                                      " ",
                                  style: Styles.heading4
                                      .copyWith(color: AppColors.primary),
                                ),
                                TextSpan(
                                  text: _controller
                                          .listDayVisitDoctor[
                                              _controller.idDayPicked]
                                          .day
                                          .toString() +
                                      "/" +
                                      _controller
                                          .listDayVisitDoctor[
                                              _controller.idDayPicked]
                                          .month
                                          .toString() +
                                      "/" +
                                      _controller
                                          .listDayVisitDoctor[
                                              _controller.idDayPicked]
                                          .year
                                          .toString(),
                                  style: Styles.heading4
                                      .copyWith(color: AppColors.primary),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
            const Divider(
              thickness: 1.0,
              color: AppColors.lightSilver,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Lịch Lấy mẫu',
                  style: Styles.heading4.copyWith(color: AppColors.black),
                ),
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Observer(
                      builder: (context) => BuildListDaySample(
                        listDayPickerLength:
                        _controller.listDaySampleLength,
                        onClickDayVisit: onClickDayGetSample,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Flexible(
                    flex: 6,
                    child: Observer(
                      builder: (context) => BuildListTimeVisit(
                        listAM: _controller.listTimeGetResultTestAM,
                        listPM: _controller.listTimeGetResultTestPM,
                        onTap: _controller.onChangeIdTimeGetResultTest,
                        idTimePicked: _controller.idTimeGetSample,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            _buildButtonContinue(),
          ],
        ),
      ),
    );
  }

  void onClickDayGetSample(idDayPicked) {
    // print(idDayPicked);
    _controller.onChangeIdGetSample(idDayPicked);
    refreshDataPicked();
  }

  void refreshDataPicked() {
    _controller.onChangeIdTimeGetResultTest(null);
  }

  Widget _buildButtonContinue() {
    return Row(
      children: [
        const Spacer(
          flex: 1,
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 12.0),
            child: AppButton(
              labelStyle: Styles.heading4.copyWith(color: AppColors.background),
              title: 'Tiếp tục',
              onPressed: () {
                if (_controller.idTimeGetSample == null) {
                  Fluttertoast.showToast(
                      msg: 'Hãy chọn thời gian lấy mẫu xét nghiệm',
                      backgroundColor: AppColors.error500,
                      gravity: ToastGravity.BOTTOM);
                  return;
                }
                onContinue();
              },
            ),
          ),
        ),
        const Spacer(
          flex: 1,
        ),
      ],
    );
  }
}
