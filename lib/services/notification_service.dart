// lib/services/notification_service.dart
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get_it/get_it.dart';

import '../app/modules/electronic_signature_v2/presentation/pages/sign_home_page_v2.dart';
import '../di/locator.dart';
import '../utils/constants.dart';
import '../utils/navigation_service.dart';
import '../utils/pending_navigation.dart';
import '../utils/routes.dart';
import '../utils/shared_preferences_manager.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'high_importance_channel',
    'Thông báo quan trọng',
    description: 'Kênh dùng để hiển thị các thông báo thuốc',
    importance: Importance.high,
  );

  /// Gọi 1 lần trong main() sau Firebase.initializeApp()
  static Future<void> init() async {
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings();
    const initSettings =
        InitializationSettings(android: androidInit, iOS: iosInit);

    await _plugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        print("background");
        // final nav = serviceLocator<NavigationService>();
        // // TODO: xử lý khi user bấm vào thông báo (foreground/background)
        // // response.payload có thể chứa id thuốc, v.v.
        // final share = GetIt.I<SharedPreferencesManager>();
        // final userName = share.getString(Constants.codeNursing); // giống menu
        //
        // if (userName != null && userName.isNotEmpty) {
        //   Modular.to
        //       .pushNamed('/sign-home-v2', arguments: {'userName': userName});
        // } else {
        //   Modular.to
        //       .pushNamed(AppRoutes.login); // hoặc show noti/snackbar tùy bạn
        // }
        _goToSignOrLogin();
      },
    );
    final launchDetails = await _plugin.getNotificationAppLaunchDetails();
    if (launchDetails?.didNotificationLaunchApp ?? false) {
      // lúc này router có thể chưa sẵn ngay -> set pending để AppWidget xử lý
      _setPendingToSignOrLogin();
    }
    // Tạo channel cho Android
    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);
  }

  static void _goToSignOrLogin() {
    final share = GetIt.I<SharedPreferencesManager>();
    final userName = share.getString(Constants.codeNursing);

    if (userName != null && userName.isNotEmpty) {
      Modular.to.pushNamed('/sign-home-v2', arguments: {'userName': userName});
    } else {
      Modular.to.pushNamed(AppRoutes.login);
    }
  }

  static void _setPendingToSignOrLogin() {
    final share = GetIt.I<SharedPreferencesManager>();
    final userName = share.getString(Constants.codeNursing);

    if (userName != null && userName.isNotEmpty) {
      PendingNavigation.set('/sign-home-v2', args: {'userName': userName});
    }
  }

  /// Hiển thị local notification từ RemoteMessage (dùng cho foreground / background handler)
  static Future<void> showFcmNotification(RemoteMessage message) async {
    final notification = message.notification;
    final android = notification?.android;

    final title = notification?.title ?? 'Thông báo';
    final body = notification?.body ?? 'Bạn có một thông báo mới';

    final androidDetails = AndroidNotificationDetails(
      _channel.id,
      _channel.name,
      channelDescription: _channel.description,
      importance: Importance.high,
      priority: Priority.high,
      styleInformation: BigTextStyleInformation(
        body,
        contentTitle: title,
      ),
      icon: android?.smallIcon ?? '@mipmap/ic_launcher',
    );

    const iosDetails = DarwinNotificationDetails();

    final details =
        NotificationDetails(android: androidDetails, iOS: iosDetails);

    await _plugin.show(
      Random().nextInt(1 << 31),
      title,
      body,
      details,
      payload: message.data['payload']?.toString(),
    );
  }
}
