import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/schedule/widgets/schedule_completed_item.dart';
import 'package:pstb/utils/main.dart';

import '../../../../widgets/stateless/app_button.dart';
import '../../medical_appointment/medical_appointment_store.dart';
import '../schedule_store.dart';

class ScheduleCompletedPage extends StatefulWidget {
  final String title;

  const ScheduleCompletedPage({this.title = "ScheduleCompletedPage"}) : super();

  @override
  _ScheduleCompletedPageState createState() => _ScheduleCompletedPageState();
}

class _ScheduleCompletedPageState extends State<ScheduleCompletedPage> {
  final ScheduleStore _scheduleStore = Modular.get<ScheduleStore>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      // print(_scrollController.offset);
      // print(_scrollController.position.maxScrollExtent);
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
          _scheduleStore.refreshCompleted();
        },
        child: Container(
          child: _scheduleStore.searchText == '' ? _dataRaw() : _dataSearch(),
        ),
      ),
    );
  }

  Widget _dataRaw() {
    return Container(
      color: Colors.white,
      child: _scheduleStore.completed.isEmpty
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
              padding: const EdgeInsets.only(top: 0),
              itemCount: _scheduleStore.completed.length,
              itemBuilder: (context, index) {
                return ScheduleCompletedItem(
                  currentItem: _scheduleStore.completed[index],
                );
              },
            ),
    );
  }

  Widget _dataSearch() {
    return Container(
      child: _scheduleStore.getSearchCompleted.isEmpty
          ? Center(
              child: Text(
                l10n(context)!.search_no_result,
                textAlign: TextAlign.center,
                style: Styles.content.copyWith(color: AppColors.neutral700),
              ),
            )
          : ListView.builder(
              itemCount: _scheduleStore.getSearchCompleted.length,
              itemBuilder: (context, index) {
                return ScheduleCompletedItem(
                  currentItem: _scheduleStore.getSearchCompleted[index],
                );
              },
            ),
    );
  }
}
