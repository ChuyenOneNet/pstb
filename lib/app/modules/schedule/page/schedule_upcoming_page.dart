import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/schedule/widgets/schedule_upcoming_item.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/app_button.dart';
import '../../medical_appointment/medical_appointment_store.dart';
import '../schedule_store.dart';

class ScheduleUpcomingPage extends StatefulWidget {
  final String title;

  const ScheduleUpcomingPage({Key? key, this.title = "ScheduleUpcomingPage"})
      : super(key: key);

  @override
  _ScheduleUpcomingPageState createState() => _ScheduleUpcomingPageState();
}

class _ScheduleUpcomingPageState extends State<ScheduleUpcomingPage> {
  final ScheduleStore _scheduleStore = Modular.get<ScheduleStore>();

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset >=
          _scrollController.position.maxScrollExtent - 100) {
        if (_scheduleStore.isLoadingMore) return;
        _scheduleStore.loadMoreUpcoming();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) => RefreshIndicator(
        onRefresh: () async {
          _scheduleStore.refreshUpcoming();
        },
        child: Container(
          child: _scheduleStore.searchText == '' ? _dataRaw() : _dataSearch(),
        ),
      ),
    );
  }

  Widget _dataRaw() {
    var upcomingReversed = _scheduleStore.upcoming.reversed.toList();
    return Container(
        color: Colors.white,
        child: _scheduleStore.upcoming.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Image.asset('assets/images/socialmedia_tech.jpg'),
                  Image.asset('assets/images/appointment schedule.jpg'),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    'Bạn chưa có lịch hẹn nào!',
                    textAlign: TextAlign.center,
                    style: Styles.content,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      Expanded(
                        child: AppButton(
                          title: 'Đặt lịch ngay',
                          onPressed: () {
                            final MedicalAppointmentStore _appointmentStore =
                                Modular.get<MedicalAppointmentStore>();
                            _appointmentStore.changeSearchDataAtHome(false);
                            Modular.to.pushNamed(AppRoutes.medicalPackagePage);
                          },
                        ),
                      ),
                      const Spacer(),
                    ],
                  )
                ],
              )
            : ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                controller: _scrollController,
                padding: const EdgeInsets.only(top: 0),
                itemCount: upcomingReversed.length,
                itemBuilder: (context, index) {
                  return ScheduleUpcomingItem(
                    // openMap: openMap,
                    currentItem: upcomingReversed[index],
                  );
                },
              ));
  }

  Widget _dataSearch() {
    return Container(
      child: _scheduleStore.getSearchUpComing.isEmpty
          ? Column(
              children: [
                Image.asset('assets/images/appointment schedule.png'),
                const SizedBox(
                  height: 16.0,
                ),
                Text(
                  l10n(context)!.search_no_result,
                  textAlign: TextAlign.center,
                  style: Styles.content,
                ),
              ],
            )
          : ListView.builder(
              padding: const EdgeInsets.only(top: 0),
              itemCount: _scheduleStore.getSearchUpComing.length,
              itemBuilder: (context, index) {
                return ScheduleUpcomingItem(
                  // openMap: openMap,
                  currentItem: _scheduleStore.getSearchUpComing[index],
                );
              },
            ),
    );
  }
}
