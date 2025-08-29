// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_modular/flutter_modular.dart';
// import 'package:pstb/app/modules/nurse_page/nurse_searching_store.dart';
// import 'package:pstb/utils/main.dart';
// import 'package:pstb/widgets/stateless/stateless_widget.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
//
// import 'qr_code_store.dart';
//
// class QRScannerPage extends StatefulWidget {
//   const QRScannerPage({Key? key}) : super(key: key);
//
//   @override
//   State<QRScannerPage> createState() => _QRScannerPageState();
// }
//
// class _QRScannerPageState extends State<QRScannerPage> {
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   Barcode? result;
//   final _qrController = Modular.get<QRCodeStore>();
//
//   @override
//   void initState() {
//     _qrController.controller?.resumeCamera();
//     super.initState();
//   }
//
//   @override
//   void reassemble() {
//     super.reassemble();
//     if (Platform.isAndroid) {
//       _qrController.controller!.pauseCamera();
//     } else if (Platform.isIOS) {
//       _qrController.controller!.resumeCamera();
//     }
//   }
//   @override
//   void dispose() {
//     _qrController.controller?.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         title: "Quét mã bệnh nhân",
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: QRView(
//               overlay: QrScannerOverlayShape(
//                   borderColor: AppColors.primary,
//                   cutOutSize: MediaQuery.of(context).size.width * 0.55),
//               onQRViewCreated: (controller) {
//                 _qrController.controllerQRCode(controller,(barCode){
//                   _qrController.value = barCode.code??'';
//                   if(_qrController.value.isNotEmpty) {
//                     final _nurseStore = Modular.get<NurseSearchingStore>();
//                     _qrController.controller!.pauseCamera();
//                     _nurseStore.codePatient = barCode.code??'';
//                     Modular.to.pop(_nurseStore.codePatient);
//                     // await nurseController.pressActivePatient();
//                     // if (!nurseController.isActivePatient) {
//                     //   AppSnackBar.show(context, AppSnackBarType.Error,
//                     //       'Không tìm thấy thông tin bệnh nhân');
//                     //   return;
//                     // }
//                     // Modular.to.pushNamed(AppRoutes.inputHeathycare);
//                   }
//                 });
//               },
//               key: qrKey,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
