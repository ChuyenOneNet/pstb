import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pstb/utils/colors.dart';
import 'app/app_module.dart';
import 'app/app_widget.dart';
import 'package:camera/camera.dart';

import 'di/locator.dart';

List<CameraDescription> cameras = [];

// void downloadCallback(String id, DownloadTaskStatus status, int progress) {
//   debugPrint(
//       'Background Isolate Callback: task ($id) is in status ($status) and process ($progress)');
//
//   final SendPort send =
//       IsolateNameServer.lookupPortByName('downloader_send_port')!;
//   send.send([id, status, progress]);
// }
//
// Future _initialDownloaderTask() async {
//   await Permission.storage.request();
// }

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint('Handling a background message ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setupLocator();
  await GetStorage.init();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  cameras = await availableCameras();
  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.doubleBounce
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 60
    ..radius = 10.0
    ..progressColor = AppColors.background
    ..backgroundColor = AppColors.primary
    ..indicatorColor = AppColors.primary
    ..textColor = AppColors.background
    ..maskType = EasyLoadingMaskType.custom
    ..maskColor = AppColors.transparent
    ..userInteractions = false
    ..dismissOnTap = false;
}
