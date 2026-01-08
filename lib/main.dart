import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pstb/services/fcm_service.dart';
import 'package:pstb/services/firebase_messaging_background_handler.dart';
import 'package:pstb/services/notification_service.dart';
import 'package:pstb/utils/colors.dart';
import 'package:vnpt_smartca_module/main.dart';
import 'app/app_module.dart';
import 'app/app_widget.dart';

import 'di/locator.dart';

//List<CameraDescription> cameras = [];

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
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true; // bỏ qua check
  }
}

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('sign_cache');
  await Firebase.initializeApp();
  await setupLocator();
  await GetStorage.init();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await NotificationService.init();

  // FCM service
  final fcmService = FcmService(FirebaseMessaging.instance);
  await fcmService.init();

  //cameras = await availableCameras();
  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
  configLoading();
}

@pragma('vm:entry-point')
void VNPTSmartCAEntryponit() => bootstrapSmartCAApp();
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
