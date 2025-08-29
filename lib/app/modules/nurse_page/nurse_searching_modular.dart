// import 'package:flutter_modular/flutter_modular.dart';
// import 'package:pstb/app/modules/nurse_page/input_patient/input_patient.dart';
// import 'package:pstb/app/modules/nurse_page/nurse_searching_page.dart';
// import 'package:pstb/app/modules/nurse_page/nurse_searching_store.dart';
// import 'package:pstb/app/modules/nurse_page/qr_scanner/qr_code_store.dart';
// import 'package:pstb/app/modules/nurse_page/qr_scanner/qr_scanner_page.dart';
// import 'package:pstb/app/modules/nurse_page/widgets/recording_page.dart';
// import 'package:pstb/utils/routes.dart';
//
// class NurseSearchingModule extends Module {
//   @override
//   final List<Bind> binds = [
//     Bind.lazySingleton((i) => NurseSearchingStore()),
//     Bind.lazySingleton((i) => QRCodeStore()),
//   ];
//
//   @override
//   final List<ModularRoute> routes = [
//     ChildRoute(AppRoutes.nursePage,
//         child: (_, __) => const NurseSearchingPage()),
//     ChildRoute(AppRoutes.inputPatient, child: (_, __) => const InputPatient()),
//     ChildRoute(AppRoutes.qrCode, child: (_, __) => const QRScannerPage()),
//     ChildRoute(AppRoutes.recordingPage, child: (_, __) => const RecordingPage()),
//   ];
// }
