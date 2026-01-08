// lib/services/fcm_service.dart
import 'dart:developer' as developer;
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart';

import '../app/modules/electronic_signature_v2/presentation/pages/sign_home_page_v2.dart';
import '../di/locator.dart';
import '../utils/constants.dart';
import '../utils/navigation_service.dart';
import '../utils/pending_navigation.dart';
import '../utils/routes.dart';
import '../utils/shared_preferences_manager.dart';
import 'notification_service.dart';

class FcmService {
  final FirebaseMessaging _messaging;
  String? _cachedToken;

  FcmService(this._messaging);

  String? get cachedToken => _cachedToken;

  /// Gọi 1 lần trong main() sau Firebase.initializeApp() + NotificationService.init()
  Future<void> init() async {
    await _requestPermission();
    await _waitForApnsToken();
    // Lấy token ngay khi khởi động app
    _cachedToken = await _messaging.getToken();
    developer.log('FCM token (init): $_cachedToken', name: 'FcmService');

    // App đang mở (foreground) -> show local notification custom
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("foreground");
      developer.log(
        'FCM onMessage: ${message.messageId}',
        name: 'FcmService',
      );
      NotificationService.showFcmNotification(message);
    });

    // User bấm notification để mở app
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("open");
      final nav = serviceLocator<NavigationService>();
      developer.log(
        'FCM onMessageOpenedApp: ${message.messageId}',
        name: 'FcmService',
      );
      final share = GetIt.I<SharedPreferencesManager>();
      final userName = share.getString(Constants.codeNursing); // giống menu

      if (userName != null && userName.isNotEmpty) {
        Modular.to
            .pushNamed('/sign-home-v2', arguments: {'userName': userName});
      } else {
        Modular.to
            .pushNamed(AppRoutes.login); // hoặc show noti/snackbar tùy bạn
      }
    });
    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _openFromRemoteMessage(initialMessage);
    }
    // Token refresh -> update cache
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
      developer.log('FCM token refreshed: $newToken', name: 'FcmService');
      _cachedToken = newToken;
    });
  }

  void _openFromRemoteMessage(RemoteMessage message) {
    final share = GetIt.I<SharedPreferencesManager>();
    final userName = share.getString(Constants.codeNursing);

    if (userName != null && userName.isNotEmpty) {
      PendingNavigation.set('/sign-home-v2', args: {'userName': userName});
    }
  }

  Future<void> _requestPermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    developer.log(
      'Notification permission: ${settings.authorizationStatus}',
      name: 'FcmService',
    );
  }

  /// Dùng ở AuthCubit: ưu tiên token cache, nếu chưa có thì lấy từ Firebase
  Future<String?> getFcmToken() async {
    if (_cachedToken != null) return _cachedToken;
    await _waitForApnsToken();
    _cachedToken =
        // Platform.isIOS
        //     ? await _messaging.getAPNSToken()
        //     :
        await _messaging.getToken();
    developer.log('FCM token (lazy): $_cachedToken', name: 'FcmService');
    return _cachedToken;
  }

  Future<void> _waitForApnsToken() async {
    if (!Platform.isIOS) return;

    String? apnsToken;
    int retry = 0;

    while (apnsToken == null && retry < 20) {
      apnsToken = await _messaging.getAPNSToken();
      retry++;
      await Future.delayed(const Duration(milliseconds: 300));
    }

    developer.log(
      'APNS token: $apnsToken',
      name: 'FcmService',
    );
  }
}
