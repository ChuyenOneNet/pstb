import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/schedule_detail/schedule_detail_store.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';
import '../widgets/new_schedule_detail.dart';

class ScheduleDetailCompletedPage extends StatefulWidget {
  const ScheduleDetailCompletedPage({Key? key}) : super(key: key);

  @override
  _ScheduleDetailCompletedPageState createState() =>
      _ScheduleDetailCompletedPageState();
}

class _ScheduleDetailCompletedPageState
    extends State<ScheduleDetailCompletedPage> {
  final ScheduleDetailStore _scheduleDetailStore =
      Modular.get<ScheduleDetailStore>();

  @override
  void initState() {
    _scheduleDetailStore.changeBuildContext(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: l10n(context)!.schedule_detail_title,
      ),
      body: Observer(builder: (context) {
        if (_scheduleDetailStore.loading) {
          return const Center(
            child: AppCircleLoading(),
          );
        }
        return NewScheduleDetail();
      }),
    );
  }
}
