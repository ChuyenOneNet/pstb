import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/models/booking_list_model.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateful/stateful_widget.dart';

import '../schedule_store.dart';
import 'schedule_completed_time.dart';
import 'schedule_item_basic.dart';

class ScheduleCompletedItem extends StatefulWidget {
  final BookingItem currentItem;

  const ScheduleCompletedItem({
    Key? key,
    required this.currentItem,
  }) : super(key: key);

  @override
  _ScheduleCompletedItemState createState() => _ScheduleCompletedItemState();
}

class _ScheduleCompletedItemState extends State<ScheduleCompletedItem> {
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
      onTap: () => _controller.navigateToDetail(
        completed: true,
        maHoSo: widget.currentItem.maHoSo,
        id: widget.currentItem.id!,
      ),
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
                  title: widget.currentItem.packageName ?? "",
                  doctor: widget.currentItem.doctorName ?? "",
                  timeGetSample: widget.currentItem.timeGetSample,
                  status: _controller.status,
                  isUpcoming: false,
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
