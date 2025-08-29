// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/notification/notification_store.dart';
import 'package:pstb/app/modules/notification/pages/notification_page.dart';

class NotificationModule extends WidgetModule {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => NotificationStore()),
  ];

  @override
  Widget get view => const NotificationPage();
}
