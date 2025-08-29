import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/schedule/widgets/schedule_completed_time.dart';
import 'package:pstb/app/models/booking_list_model.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateful/stateful_widget.dart';
import '../schedule_store.dart';
import 'schedule_item_basic.dart';

class ScheduleUpcomingItem extends StatefulWidget {
  final BookingItem currentItem;

  const ScheduleUpcomingItem({
    Key? key,
    required this.currentItem,
  }) : super(key: key);

  @override
  _ScheduleUpcomingItemState createState() => _ScheduleUpcomingItemState();
}

class _ScheduleUpcomingItemState extends State<ScheduleUpcomingItem> {
  final ScheduleStore _controller = Modular.get<ScheduleStore>();

  @override
  void initState() {
    // TODO: implement initState
    checkStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        // print(widget.currentItem.maHoSo),
        // print(widget.currentItem.id),
        _controller.navigateToDetail(
            completed: false,
            maHoSo: widget.currentItem.maHoSo,
            id: widget.currentItem.id!),
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: widthConvert(context, 16),
        ),
        child: Container(
          margin: EdgeInsets.symmetric(
            vertical: widthConvert(context, 8),
          ),
          decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.black.withOpacity(0.2))),
          child: Row(
            children: [
              ScheduleCompletedItemTime(
                timeSeeDoctor: widget.currentItem.timeSeeDoctor,
                timeGetSample: widget.currentItem.timeGetSample,
              ),
              Expanded(
                child: ScheduleItemBasic(
                  title: widget.currentItem.packageName ?? '',
                  doctor: widget.currentItem.doctorName ?? '',
                  timeGetSample: widget.currentItem.timeGetSample,
                  status: _controller.status,
                  isUpcoming: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void checkStatus() {
    int i = widget.currentItem.status ?? 0;
    switch (i) {
      case 0:
        _controller.onChangeStatus('Đang cập nhật');
        break;
      case 1:
        _controller.onChangeStatus('Chờ');
        break;
      case 3:
        _controller.onChangeStatus('Đã thực hiện');
        break;
    }
  }
}
