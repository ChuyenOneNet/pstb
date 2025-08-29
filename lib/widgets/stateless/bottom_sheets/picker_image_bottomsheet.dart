import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pstb/app/modules/home/home_store.dart';
import 'package:pstb/utils/image_picker_helper.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateful/camera_dialog.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'content_bottom_sheet_default.dart';

class PickerImageBottomSheet {
  /// [onDone] callback return a xFile
  static void show(
      {required BuildContext context,
      String? title,
      required bool checkOpenFile,
      required Function(XFile) onDone,
      required Function(PlatformFile) onDoneFile,
      String? cameraPurposeMessage,
      String? photoPurposeMessage}) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) => PickerImageBottomSheetWidget(
          title: title,
          checkOpenFile: checkOpenFile,
          cameraPurposeMessage: cameraPurposeMessage,
          photoPurposeMessage: photoPurposeMessage,
          cameraCallback: () async {
            // return await CameraUtil.show(
            //     context: context,
            //     onDone: (image) async {
            //       await onDone(image);
            //       //final duplicateFilePath = await getApplicationDocumentsDirectory();
            //       //final fileName = basename(image.path);
            //       //await image.saveTo('${duplicateFilePath.path}/$fileName');
            //       //GallerySaver.saveImage('${duplicateFilePath.path}/$fileName');
            //       Navigator.of(context, rootNavigator: true).pop();
            //     });
            final pickedFile = await ImagePicker()
                .pickImage(source: ImageSource.camera, imageQuality: 100);
            if (pickedFile != null) {
              await onDone(pickedFile);
              Navigator.of(context, rootNavigator: true).pop();
            }
          },
          galleryCallback: () async {
            // final image =
            //     await Modular.get<ImagePickerHelper>().imgFromGallery();
            // if (image != null) {
            //   onDone(image);
            // }

            final pickedFile = await ImagePicker()
                .pickImage(source: ImageSource.gallery, imageQuality: 100);

            if (pickedFile != null) {
              await onDone(pickedFile);
              Navigator.of(context, rootNavigator: true).pop();
            }
          },
          fileCallback: () async {
            final document =
                await Modular.get<ImagePickerHelper>().fileGallery();
            if (document != null) {
              onDoneFile(document);
            }
          }),
    );
  }
}

class PickerImageBottomSheetWidget extends StatelessWidget {
  const PickerImageBottomSheetWidget(
      {Key? key,
      this.title,
      required this.cameraCallback,
      required this.galleryCallback,
      this.fileCallback,
      required this.checkOpenFile,
      this.cameraPurposeMessage,
      this.photoPurposeMessage})
      : super(key: key);

  final Function cameraCallback;
  final Function galleryCallback;
  final Function? fileCallback;
  final String? title;
  final bool checkOpenFile;
  final String? cameraPurposeMessage;
  final String? photoPurposeMessage;

  @override
  Widget build(BuildContext context) {
    return ContentBottomSheetDefault(
      title: title ?? l10n(context)!.option,
      buttons: [
        ButtonBottomSheetModel(
            label: l10n(context).take_picture,
            color: Colors.black,
            onPressed: () async {
              debugPrint("chup anh");
              if (await Permission.camera.isDenied ||
                  await Permission.camera.isPermanentlyDenied) {
                var allowPermission = await showCupertinoDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (_) {
                      return CupertinoAlertDialog(
                        title: const Text('Yêu cầu quyền truy cập vào camera'),
                        content: Text(cameraPurposeMessage ??
                            "Bạn cần cho phép quyền truy cập camera để sử dụng tính năng"),
                        actions: [
                          CupertinoDialogAction(
                              child: Text(
                                "Tiếp tục",
                                style: Styles.heading5,
                              ),
                              onPressed: () async {
                                //await openAppSettings();
                                Navigator.pop(context, true);
                              }),
                          // CupertinoDialogAction(
                          //     child: Text(
                          //       "Để sau",
                          //       style: Styles.heading5
                          //           .copyWith(color: AppColors.error700),
                          //     ),
                          //     onPressed: () async {
                          //       if (Platform.isIOS) {
                          //         Navigator.pop(context);
                          //       } else {
                          //         var dontAllow = await showCupertinoDialog(
                          //             context: context,
                          //             builder: (_) {
                          //               return CupertinoAlertDialog(
                          //                 title: const Text('Thông báo'),
                          //                 content: Text(
                          //                     "Bạn không thể ${purposeMessage} nếu không cho phép truy cập camera. Xác nhận?"),
                          //                 actions: [
                          //                   CupertinoDialogAction(
                          //                       child: Text(
                          //                         "Không cho phép",
                          //                         style: Styles.heading5
                          //                             .copyWith(
                          //                                 color: AppColors
                          //                                     .error700),
                          //                       ),
                          //                       onPressed: () async {
                          //                         //await openAppSettings();
                          //                         Navigator.pop(context, true);
                          //                       }),
                          //                   CupertinoDialogAction(
                          //                       child: const Text("Quay lại"),
                          //                       onPressed: () {
                          //                         Navigator.pop(context);
                          //                       })
                          //                 ],
                          //               );
                          //             });
                          //         if (dontAllow == true) {
                          //           Navigator.pop(context, false);
                          //         }
                          //       }
                          //     })
                        ],
                      );
                    });

                if (allowPermission == null || allowPermission == false) {
                  return;
                }
              }

              if (await Permission.camera.isPermanentlyDenied) {
                showCupertinoDialog(
                    context: context,
                    builder: (_) {
                      return CupertinoAlertDialog(
                        title: const Text('Yêu cầu quyền truy cập vào camera'),
                        content: Text(cameraPurposeMessage ??
                            "Bạn cần cho phép quyền truy cập camera để sử dụng tính năng"),
                        actions: [
                          CupertinoDialogAction(
                              child: Text(
                                "Mở cài đặt",
                                style: Styles.heading5
                                    .copyWith(color: AppColors.error700),
                              ),
                              onPressed: () async {
                                await openAppSettings();
                                Navigator.pop(context);
                                return;
                              }),
                          CupertinoDialogAction(
                              child: const Text("Quay lại"),
                              onPressed: () {
                                Navigator.pop(context);
                                return;
                              })
                        ],
                      );
                    });
              }

              final _homeStore = Modular.get<HomeStore>();
              _homeStore.statuses = await [
                Permission.camera,
                //Permission.microphone,
              ].request();
              if (_homeStore.statuses[Permission.camera] ==
                      PermissionStatus.granted
                  // && _homeStore.statuses[Permission.microphone] ==
                  //     PermissionStatus.granted
                  ) {
                await cameraCallback();
                Navigator.pop(context);
                return;
              }
            }),
        ButtonBottomSheetModel(
          label: l10n(context).pick_picture,
          color: Colors.black,
          onPressed: () async {
            debugPrint("chon anh");
            AndroidDeviceInfo? androidInfo;
            var isAndroidLE32 = false;
            if (Platform.isAndroid) {
              androidInfo = await DeviceInfoPlugin().androidInfo;
              if (androidInfo.version.sdkInt <= 32) isAndroidLE32 = true;
            }
            var storage_isDenied = await Permission.storage.isDenied;
            var storage_isPermanentlyDenied =
                await Permission.storage.isPermanentlyDenied;
            var photos_isDenied = await Permission.photos.isDenied;
            var photos_isPermanentlyDenied =
                await Permission.photos.isPermanentlyDenied;
            var photos_isLimited = await Permission.photos.isLimited;
            if (Platform.isIOS) {
              // Fluttertoast.showToast(
              //     msg:
              //         "photos.isGranted: ${await Permission.photos.isGranted}\n photos.isDenied: ${await Permission.photos.isDenied}\n photos.isLimited: ${await Permission.photos.isLimited} \n photos.isPermanentlyDenied: ${await Permission.photos.isPermanentlyDenied}");
              if ((await Permission.photos.isDenied ||
                      await Permission.photos.isPermanentlyDenied) ||
                  (Platform.isIOS && !photos_isLimited)) {
                var allowPermission = await showCupertinoDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (_) {
                      return CupertinoAlertDialog(
                        title: const Text(
                            'Yêu cầu quyền truy cập vào thư viện ảnh'),
                        content: Text(photoPurposeMessage ??
                            "Bạn cần cho phép quyền truy cập vào thư viện ảnh để sử dụng tính năng"),
                        actions: [
                          CupertinoDialogAction(
                              child: Text(
                                "Tiếp tục",
                                style: Styles.heading5,
                              ),
                              onPressed: () async {
                                //await openAppSettings();
                                Navigator.pop(context, true);
                              }),
                          // CupertinoDialogAction(
                          //     child: Text(
                          //       "Để sau",
                          //       style: Styles.heading5
                          //           .copyWith(color: AppColors.error700),
                          //     ),
                          //     onPressed: () async {
                          //       if (Platform.isIOS) {
                          //         Navigator.pop(context);
                          //       } else {
                          //         var dontAllow = await showCupertinoDialog(
                          //             context: context,
                          //             builder: (_) {
                          //               return CupertinoAlertDialog(
                          //                 title: const Text('Thông báo'),
                          //                 content: Text(
                          //                     "Bạn không thể ${purposeMessage} nếu không cho phép truy cập vào thử viện ảnh. Xác nhận?"),
                          //                 actions: [
                          //                   CupertinoDialogAction(
                          //                       child: Text(
                          //                         "Không cho phép",
                          //                         style: Styles.heading5
                          //                             .copyWith(
                          //                                 color: AppColors
                          //                                     .error700),
                          //                       ),
                          //                       onPressed: () async {
                          //                         //await openAppSettings();
                          //                         Navigator.pop(context, true);
                          //                       }),
                          //                   CupertinoDialogAction(
                          //                       child: const Text("Quay lại"),
                          //                       onPressed: () {
                          //                         Navigator.pop(context);
                          //                       })
                          //                 ],
                          //               );
                          //             });
                          //         if (dontAllow == true) {
                          //           Navigator.pop(context, false);
                          //         }
                          //       }
                          //     })
                        ],
                      );
                    });

                if (allowPermission == null || allowPermission == false) {
                  return;
                }
              }

              if (await Permission.photos.isPermanentlyDenied) {
                showCupertinoDialog(
                    context: context,
                    builder: (_) {
                      return CupertinoAlertDialog(
                        title: const Text(
                            'Yêu cầu quyền truy cập vào thư viện ảnh'),
                        content: Text(photoPurposeMessage ??
                            "Bạn cần cho phép quyền truy cập vào thư viện ảnh để sử dụng tính năng"),
                        actions: [
                          CupertinoDialogAction(
                              child: Text(
                                "Mở cài đặt",
                                style: Styles.heading5
                                    .copyWith(color: AppColors.error700),
                              ),
                              onPressed: () async {
                                await openAppSettings();
                                Navigator.pop(context);
                                return;
                              }),
                          CupertinoDialogAction(
                              child: const Text("Quay lại"),
                              onPressed: () {
                                Navigator.pop(context);
                                return;
                              })
                        ],
                      );
                    });
              }
            }
            // final _homeStore = Modular.get<HomeStore>();
            // _homeStore.statuses = await [
            //   Permission.photos,
            //   Permission.storage,
            // ].request();

            if (Platform.isAndroid) {
              final androidInfo = await DeviceInfoPlugin().androidInfo;
              // if (androidInfo.version.sdkInt <= 32) {
              //   /// use [Permissions.storage.status]
              //   if (_homeStore.statuses[Permission.storage] ==
              //       PermissionStatus.granted) {
              //     await galleryCallback();
              //     Navigator.pop(context);
              //     return;
              //   }
              // } else {
              //   /// use [Permissions.photos.status]
              //   if (_homeStore.statuses[Permission.photos] ==
              //       PermissionStatus.granted) {
              //     await galleryCallback();
              //     Navigator.pop(context);
              //     return;
              //   }
              // }
              await galleryCallback();
              Navigator.pop(context);
              return;
            } else {
              // final _homeStore = Modular.get<HomeStore>();
              // _homeStore.statuses = await [
              //   Permission.photos,
              //   Permission.storage,
              // ].request();
              //if (_homeStore.statuses[Permission.photos] ==
              //    PermissionStatus.granted) {
              await galleryCallback();
              Navigator.pop(context);
              return;
              //}
            }
          },
        ),
        if (checkOpenFile == true)
          ButtonBottomSheetModel(
            label: 'Chọn tài liệu',
            color: Colors.black,
            onPressed: () async {
              final statusFile = await Permission.storage.request();
              if (statusFile.isGranted) {
                await fileCallback!();
                Navigator.pop(context);
                return;
              }
              showCupertinoDialog(
                  context: context,
                  builder: (_) {
                    return CupertinoAlertDialog(
                      title: const Text('Yêu cầu quyền truy cập vào thư viện'),
                      content: const Text(
                          "Bạn cần mở quyền truy cập để sử dụng tính năng"),
                      actions: [
                        CupertinoDialogAction(
                            child: Text(
                              "Mở cài đặt",
                              style: Styles.heading4
                                  .copyWith(color: AppColors.error700),
                            ),
                            onPressed: () async {
                              await openAppSettings();
                              Navigator.pop(context);
                            }),
                        CupertinoDialogAction(
                            child: const Text("Bỏ qua"),
                            onPressed: () {
                              Navigator.pop(context);
                            })
                      ],
                    );
                  });
            },
          )
      ],
    );
  }
}
