// import 'package:mobx/mobx.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
//
// part 'qr_code_store.g.dart';
//
// class QRCodeStore = _QRCodeStoreBase with _$QRCodeStore;
//
// abstract class _QRCodeStoreBase with Store {
//   @observable
//   QRViewController? controller;
//
//   @observable
//   String value = '';
//
//   @action
//   void controllerQRCode(QRViewController qrViewController,Function(Barcode)onDone) {
//     controller = qrViewController;
//     qrViewController.resumeCamera();
//     qrViewController.scannedDataStream.listen(onDone);
//   }
// }
