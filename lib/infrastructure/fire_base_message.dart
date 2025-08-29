import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Define the Notification Callback typedef
typedef SelectNotificationCallback = Future<void> Function(String? payload);

AndroidNotificationChannel channel = const AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notifications',
  importance: Importance.high,
);

typedef FireBaseFCMTokenSetter = Future Function(String? token);
typedef FireBaseFCMOnMessageInit = void Function(RemoteMessage remoteMessage);
typedef FireBaseFCMOnMessage = void Function(RemoteMessage remoteMessage);
typedef FireBaseFCMOnMessageOpenedApp = void Function(
    RemoteMessage remoteMessage);

class FireBaseMessageListener {
  FireBaseFCMOnMessage? onMessage;
  FireBaseFCMOnMessageInit? onMessageInit;
  FireBaseFCMOnMessageOpenedApp? onMessageOpenedApp;

  FireBaseMessageListener({
    this.onMessage,
    this.onMessageInit,
    this.onMessageOpenedApp,
  });
}

class FireBaseMessageSrv {
  static final FireBaseMessageSrv _instance = FireBaseMessageSrv._internal();

  factory FireBaseMessageSrv() {
    return _instance;
  }

  static FireBaseMessageSrv get instance => _instance;

  FireBaseMessageSrv._internal();

  final _localNotificationsPlugIn = FlutterLocalNotificationsPlugin();
  String? _currentToken;
  bool _isEnable = false;

  Future<void> enableFireBaseMessage(
      SelectNotificationCallback onSelectNotification,
      FireBaseFCMTokenSetter tokenSetter,
      FireBaseMessageListener? listener) async {
    if (_isEnable) return;
    print('Init firebase message');

    var android = const AndroidInitializationSettings('app_icon');
    var iOS = const DarwinInitializationSettings(); // Ensure this is correct
    var initSettings = InitializationSettings(android: android, iOS: iOS);
    // Initialize FlutterLocalNotificationsPlugin with the new callback
    await _localNotificationsPlugIn.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        // Handle the notification when it is selected
        String? payload = response.payload;
        print("Notification tapped with payload: $payload");
        // You can navigate or perform other actions based on the payload here
      },
    );

    _currentToken =
        Platform.isIOS?await FirebaseMessaging.instance.getAPNSToken():
    await FirebaseMessaging.instance.getToken();
    print("tokkkkkk: $_currentToken");
    await tokenSetter(_currentToken);
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    messaging.onTokenRefresh.listen((fcmToken) async {
      // Handle token refresh logic here if needed
    }).onError((err) {
      debugPrint(err.toString());
    });
    await messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: false,
      sound: true,
    );

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) async {
      if (message != null && listener?.onMessageInit != null) {
        listener?.onMessageInit!(message);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      if (listener?.onMessageOpenedApp != null) {
        listener?.onMessageOpenedApp!(message);
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (listener?.onMessage != null) {
        listener?.onMessage!(message);
      }
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        _localNotificationsPlugIn.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              icon:
                  'launch_background', // Ensure this icon exists in your drawable resources
            ),
          ),
        );
      }
    });
    _isEnable = true;
    print('init complete');
  }

  void disable() {
    if (!_isEnable) return;
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    messaging.deleteToken();
    _currentToken = null;
    _isEnable = false;
  }
}
