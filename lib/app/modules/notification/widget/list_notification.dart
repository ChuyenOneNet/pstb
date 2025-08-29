import 'package:flutter/material.dart';
import 'package:pstb/app/modules/notification/widget/item_notification.dart';
import 'package:pstb/repository/notifications/new_notifications_model.dart';
import 'package:pstb/utils/main.dart';

class BuildListNotification extends StatelessWidget {
  const BuildListNotification({
    Key? key,
    required this.listNotification,
  }) : super(key: key);

  final List<NotificationModel> listNotification;
  @override
  Widget build(BuildContext context) {
    bool listSeen =
        listNotification.isEmpty ? false : listNotification[0].seen ?? false;
    return Column(
      children: List.generate(listNotification.length, (index) {
        if (index == 0) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 24, bottom: 16),
                child: Text(
                    listSeen
                        ? l10n(context)!.notification_title_list_seen
                        : l10n(context)!.notification_title_list_new,
                    style: Styles.heading4),
              ),
              BuildItemNotification(
                listNotification: listNotification,
                index: index,
              ),
            ],
          );
        } else {
          return BuildItemNotification(
            listNotification: listNotification,
            index: index,
          );
        }
      }),
    );
  }
}
