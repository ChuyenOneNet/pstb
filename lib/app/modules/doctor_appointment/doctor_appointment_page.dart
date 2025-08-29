import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:pstb/app/modules/doctor_appointment/doctor_appointment_store.dart';
import 'package:pstb/app/modules/doctor_appointment/widget/appointment_item.dart';
import 'package:pstb/utils/colors.dart';
import 'package:pstb/utils/constants.dart';
import 'package:pstb/utils/styles.dart';
import 'package:pstb/utils/time_util.dart';
import 'package:pstb/widgets/stateless/app_bar.dart';
import 'package:table_calendar/table_calendar.dart';

class DoctorAppointmentPage extends StatefulWidget {
  const DoctorAppointmentPage({Key? key}) : super(key: key);

  @override
  State<DoctorAppointmentPage> createState() => _DoctorAppointmentPageState();
}

class _DoctorAppointmentPageState extends State<DoctorAppointmentPage> {
  final DoctorAppointmentStore controller =
      Modular.get<DoctorAppointmentStore>();

  final titleController = TextEditingController();
  final descpController = TextEditingController();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDate;
  late ScrollController _scrollController;

  @override
  void initState() {
    // TODO: implement initState
    _selectedDate = _focusedDay;
    _scrollController = ScrollController()..addListener(_loadMoreItems);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.getAllAppointment();
      await loadCurrentEvents(_focusedDay);
      setState(() {
        loadPreviousEvents();
      });
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.removeListener(_loadMoreItems);
    super.dispose();
  }

  Future<void> _loadMoreItems() async {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      await controller.loadMoreAppointment();
    }
  }

  loadCurrentEvents(DateTime focusedDay) async {
    DateTime firstDayOfMonth = DateTime(focusedDay.year, focusedDay.month, 1);
    String fromDate = DateFormat('dd/MM/yyyy').format(firstDayOfMonth);

    DateTime lastDayOfMonth =
        DateTime(focusedDay.year, focusedDay.month + 1, 0);
    String toDate = DateFormat('dd/MM/yyyy').format(lastDayOfMonth);
    await controller.getAllAppointmentEvent(fromDate, toDate);
  }

  loadPreviousEvents() {
    for (var element in controller.listAppointmentEvent) {
      if (controller.mySelectedEvents[DateFormat('yyyy-MM-dd').format(
          // DateTime.now()
          element.timeSeeDoctor ?? DateTime.now())] != null) {
        controller.mySelectedEvents[DateFormat('yyyy-MM-dd').format(
            // DateTime.now()
            element.timeSeeDoctor ?? DateTime.now())]?.add({
          "eventTitle": element.packageName,
          "eventDescp": element.doctorName,
          "eventTime": DateFormat(DateTimeFormatPattern.backendTimeFormat)
              .format(element.timeSeeDoctor!),
        });
      } else {
        controller.mySelectedEvents[DateFormat('yyyy-MM-dd').format(
            // DateTime.now()
            element.timeSeeDoctor ?? DateTime.now())] = [
          {
            "eventTitle": element.packageName,
            "eventDescp": element.doctorName,
            "eventTime": DateFormat(DateTimeFormatPattern.backendTimeFormat)
                .format(element.timeSeeDoctor!),
          }
        ];
      }
    }
  }

  List _listOfDayEvents(DateTime dateTime) {
    if (controller
            .mySelectedEvents[DateFormat('yyyy-MM-dd').format(dateTime)] !=
        null) {
      return controller
          .mySelectedEvents[DateFormat('yyyy-MM-dd').format(dateTime)]!;
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Lịch hẹn của tôi',
        isBack: true,
      ),
      body: controller.isDataList ? dataList() : dataCalendar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            controller.isDataList = !controller.isDataList;
          });
        },
        child: controller.isDataList
            ? const Icon(Icons.calendar_month_outlined)
            : const Icon(Icons.list),
        backgroundColor: AppColors.primary,
      ),
    );
  }

  Widget dataList() {
    var appointments = controller.listAppointment;
    return Observer(builder: (context) {
      return controller.listAppointment.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset('assets/images/appointment schedule.jpg'),
                const SizedBox(
                  height: 8.0,
                ),
                Text(
                  'Bạn chưa có lịch hẹn nào!',
                  textAlign: TextAlign.center,
                  style: Styles.content,
                ),
              ],
            )
          : RefreshIndicator(
              onRefresh: () async {
                await controller.getAllAppointment();
              },
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                controller: _scrollController,
                padding: const EdgeInsets.only(top: 0),
                itemCount: appointments.length,
                itemBuilder: (context, index) {
                  return AppointmentItem(
                    currentItem: appointments[index],
                  );
                },
              ),
            );
    });
  }

  Widget dataCalendar() {
    return Column(
      children: [
        Card(
          margin: const EdgeInsets.all(16.0),
          elevation: 5.0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            side: BorderSide(color: AppColors.lightSilver, width: 2.0),
          ),
          child: TableCalendar(
            // locale: 'en_US',
            locale: 'vi_VN',
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            startingDayOfWeek: StartingDayOfWeek.monday,
            daysOfWeekHeight: 40.0,
            rowHeight: 60.0,
            headerStyle: HeaderStyle(
              titleTextStyle:
                  const TextStyle(color: Colors.white, fontSize: 18.0),
              titleCentered: true,
              titleTextFormatter: (date, locale) =>
                  DateFormat.yMMMMEEEEd(locale).format(date),
              decoration: const BoxDecoration(
                  // color: Color(0xff520101),
                  color: AppColors.primary,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              formatButtonTextStyle:
                  const TextStyle(color: Colors.redAccent, fontSize: 16.0),
              formatButtonDecoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              formatButtonVisible: false,
              leftChevronIcon: const Icon(
                Icons.chevron_left,
                color: AppColors.background,
                size: 28,
              ),
              rightChevronIcon: const Icon(
                Icons.chevron_right,
                color: AppColors.background,
                size: 28,
              ),
            ),
            daysOfWeekStyle: const DaysOfWeekStyle(
              // Weekend days color (Sat,Sun)
              weekendStyle: TextStyle(color: Colors.red),
            ),
            calendarStyle: const CalendarStyle(
                // Weekend dates color (Sat & Sun Column)
                weekendTextStyle: TextStyle(color: Colors.red),
                // highlighted color for today
                todayDecoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                // highlighted color for selected day
                selectedDecoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                markersAlignment: Alignment.bottomRight,
                tablePadding: EdgeInsets.all(8.0)
                // markerDecoration: BoxDecoration(
                //   color: Colors.grey,
                //   shape: BoxShape.circle,
                // ),
                // markerMargin: EdgeInsets.symmetric(horizontal: 0.6),
                ),
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, day, events) => events.isNotEmpty
                  ? Container(
                      width: 20,
                      height: 20,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(8.0)),
                      child: Text(
                        '${events.length}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    )
                  : null,
            ),
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDate, selectedDay)) {
                // Call `setState()` when updating the selected day
                setState(() {
                  _selectedDate = selectedDay;
                  _focusedDay = focusedDay;
                });
              }
            },
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDate, day);
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                // Call `setState()` when updating calendar format
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) async {
              _focusedDay = focusedDay;
              DateTime firstDayOfMonth =
                  DateTime(focusedDay.year, focusedDay.month, 1);
              String fromDate =
                  DateFormat(DateTimeFormatPattern.dobddMMyyyy).format(firstDayOfMonth);

              DateTime lastDayOfMonth =
                  DateTime(focusedDay.year, focusedDay.month + 1, 0);
              String toDate = DateFormat(DateTimeFormatPattern.dobddMMyyyy).format(lastDayOfMonth);

              await controller.getAllAppointmentEvent(fromDate, toDate);

              setState(() {
                loadPreviousEvents();
              });
            },
            eventLoader: _listOfDayEvents,
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              ..._listOfDayEvents(_selectedDate!).map(
                (myEvents) => Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: AppColors.lightSilver)),
                  child: ListTile(
                    leading: const Icon(
                      Icons.calendar_month_outlined,
                      color: AppColors.primary,
                    ),
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        'Gói khám: ${myEvents['eventTitle']}',
                        style: Styles.titleItem,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'BS: ${myEvents['eventDescp']}',
                          style: Styles.content,
                        ),
                        const SizedBox(
                          height: 4.0,
                        ),
                        Text(
                          'Thời gian: ${myEvents['eventTime']}',
                          style: Styles.content,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
