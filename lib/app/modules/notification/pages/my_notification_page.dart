import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pstb/app/models/notification_model.dart';
import 'package:pstb/utils/colors.dart';
import 'package:pstb/utils/icons.dart';
import 'package:pstb/utils/routes.dart';
import 'package:pstb/utils/styles.dart';
import 'package:pstb/widgets/stateful/stateful_widget.dart';

import '../notification_store.dart';
import 'notifi_details_page/notification_details_page.dart';

class MyNotificationPage extends StatefulWidget {
  const MyNotificationPage({Key? key}) : super(key: key);

  @override
  State<MyNotificationPage> createState() => _MyNotificationPageState();
}

class _MyNotificationPageState extends State<MyNotificationPage> {
  final NotificationStore _notificationStore = NotificationStore();
  final ScrollController _sc = ScrollController();

  @override
  void initState() {
    super.initState();
    _notificationStore.getUserNotifications();
    _sc.addListener(() {
      if (_sc.position.extentAfter == 0) {
        _notificationStore.loadMore();
      }
    });
  }

  @override
  void dispose() {
    _sc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Observer(
          builder: (_) => RefreshIndicator(
                onRefresh: () async {
                  _notificationStore.getUserNotifications();
                },
                child: _notificationStore.newNotifications.isNotEmpty
                    ? ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        controller: _sc,
                        padding: const EdgeInsets.only(top: 0, bottom: 10),
                        itemCount: _notificationStore.newNotifications.length,
                        itemBuilder: (context, index) {
                          if (_notificationStore.newNotifications.isEmpty) {
                            return Center(
                              child: SizedBox(
                                child: Text(
                                  'Chưa có thông báo mới nào',
                                  style: Styles.content,
                                ),
                              ),
                            );
                          }

                          return _buildListItem(
                              _notificationStore.newNotifications[index],
                              context);
                        })
                    : Center(
                        child: Text(
                          'Chưa có thông báo mới nào!',
                          style: Styles.content,
                        ),
                      ),
              )),
    );
  }

  Widget _buildListItem(
      NotificationItemModel notification, BuildContext context) {
    return TouchableOpacity(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  NotificationDetailsPage(notification: notification)),
        );
        // if (notification.typeCode == "TEST_RESULT") {
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) =>
        //             NotificationDetailsPage(notification: notification)),
        //   );
        //   return;
        // }
        // Modular.to.pushNamed(AppRoutes.ehrModule);
      },
      child: Container(
        decoration: const BoxDecoration(
            border: Border(
          bottom: BorderSide(
            width: 1,
            color: AppColors.lightSilver,
            style: BorderStyle.solid,
          ),
        )),
        padding: const EdgeInsets.only(
          left: 16,
          top: 8.0,
          bottom: 8.0,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.notifications,
              color: AppColors.lightSilver,
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.title ?? "",
                  style: Styles.titleItem,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  notification.created ?? "",
                  style: Styles.content,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _renderIconByType(String type) {
    switch (type) {
      case 'COMPLETE_EXAMINATION':
        return SvgPicture.asset(IconEnums.notificationIconsDefault);
      case 'COMPLETE_SOS':
        return SvgPicture.asset(IconEnums.notificationIconsMedicine);
      case 'TEST_RESULT':
        return SvgPicture.asset(IconEnums.notificationIconsAppointment);
      default:
        return SvgPicture.asset(IconEnums.notificationIconsDefault);
    }
  }
}
