import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:pstb/app/models/notification_model.dart';
import 'package:pstb/utils/colors.dart';
import 'package:pstb/widgets/stateful/stateful_widget.dart';
import '../../../../utils/styles.dart';
import '../notification_store.dart';

class OtherNotificationPage extends StatefulWidget {
  const OtherNotificationPage({Key? key}) : super(key: key);

  @override
  State<OtherNotificationPage> createState() => _OtherNotificationPageState();
}

class _OtherNotificationPageState extends State<OtherNotificationPage> {
  final NotificationStore _notificationStore = Modular.get<NotificationStore>();
  final ScrollController _sc = ScrollController();

  @override
  void initState() {
    super.initState();
    _notificationStore.getNotification();
    _sc.addListener(() {
      // print(_sc.position.extentAfter);
      if (_sc.position.extentAfter == 0) {
        _notificationStore.loadMoreOther();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _sc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => RefreshIndicator(
        onRefresh: () async {
          _notificationStore.checkNotification();
        },
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (_notificationStore.notifiToday.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'today',
                        style: Styles.titleItem,
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      dataNotification(_notificationStore.notifiToday)
                    ],
                  )
                else
                  const SizedBox(),
                if (_notificationStore.notifiYesterday.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 4.0,
                      ),
                      Text('yesterday', style: Styles.titleItem),
                      const SizedBox(
                        height: 4.0,
                      ),
                      dataNotification(_notificationStore.notifiYesterday)
                    ],
                  )
                else
                  const SizedBox(),
                if (_notificationStore.notifiOther.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 4.0,
                      ),
                      Text('other', style: Styles.titleItem),
                      dataNotification(_notificationStore.notifiOther)
                    ],
                  )
                else
                  const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dataNotification(List<NotificationItemModel> notifi) {
    return Observer(
      builder: (BuildContext context) { return Column(
        children: [
          for (int index = 0; index < notifi.length; index++)
            Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: TouchableOpacity(
                onTap: () {
                  setState(() {
                    notifi[index].status = true;
                  });
                },
                child: Container(
                  height: 60,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 1,
                        color: AppColors.lightSilver,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: Icon(
                          Icons.circle,
                          size: 12.0,
                          color: notifi[index].status
                              ? AppColors.background
                              : AppColors.primary,
                        ),
                      ),
                      const Icon(
                        Icons.notifications,
                        color: AppColors.lightSilver,
                      ),
                      const SizedBox(width: 8),
                      Padding(
                        padding: const EdgeInsets.only(top: 6.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              notifi[index].title ?? "",
                              style: Styles.heading4.copyWith(
                                color: AppColors.black,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              notifi[index].created ?? "",
                              style: Styles.subtitleSmallest,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ); },

    );
  }

}
