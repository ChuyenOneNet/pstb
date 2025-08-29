import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pstb/main.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateful/touchable_opacity.dart';

class CameraUtil {
  static Future<void> show(
      {required BuildContext context, required Function(XFile) onDone}) async {
    await showGeneralDialog(
        context: context,
        pageBuilder: (context, animation, secondaryAnimation) {
          return CameraDialog(
            onDone: onDone,
          );
        });
  }
}

class CameraDialog extends StatefulWidget {
  final bool isShowFrames;
  final String? routeName;
  final Function(XFile) onDone;

  const CameraDialog(
      {Key? key,
      this.routeName,
      this.isShowFrames = false,
      required this.onDone})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CameraDialogState();
  }
}

class _CameraDialogState extends State<CameraDialog> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  XFile imagePath = XFile("");
  int cameraIndex = 0;

  @override
  void initState() {
    super.initState();
    changeCamera(cameraIndex);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void changeCamera(int cameraIndex) {
    _controller = CameraController(
      cameras[cameraIndex],
      ResolutionPreset.max,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  Future<void> takePhoto() async {
    try {
      await _initializeControllerFuture;
      final image = await _controller.takePicture();
      setState(() {
        imagePath = image;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    double maxHeight = 2000;
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 0,
            backgroundColor: AppColors.newbg900,
            insetPadding: const EdgeInsets.all(0),
            child: imagePath.path != ""
                ? _buildResult(
                    imagePath.path,
                    maxWidth,
                    () => Navigator.of(context, rootNavigator: true).pop(),
                    () => setState(() {
                          imagePath = XFile("");
                        }),
                    () => widget.onDone(imagePath))
                : _buildCamera(
                    maxWidth,
                    maxHeight,
                    () => Navigator.of(context, rootNavigator: true).pop(),
                    () => takePhoto(),
                    () => setState(() {
                          imagePath = XFile("");
                        }))));
  }

  Widget _buildCamera(double maxWidth, double maxHeight, Function onClose,
      Function onTakePhoto, Function onChangeCamera) {
    return Scaffold(
      backgroundColor: AppColors.black,
      bottomSheet: Container(
        height: 128,
        width: maxWidth,
        color: AppColors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TouchableOpacity(
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.background,
                  size: 28,
                ),
                onTap: () => onClose()),
            TouchableOpacity(
                child: SvgPicture.asset(IconEnums.takePhotoButton),
                onTap: () => takePhoto()),
            widget.isShowFrames
                ? TouchableOpacity(
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppColors.grayLight,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        imagePath = XFile("");
                      });
                    },
                  )
                : TouchableOpacity(
                    child: const Icon(
                      Icons.flip_camera_ios,
                      color: AppColors.background,
                      size: 36,
                    ),
                    onTap: () {
                      setState(
                        () {
                          cameraIndex = cameraIndex == 1 ? 0 : 1;
                        },
                      );
                      changeCamera(cameraIndex);
                    }),
          ],
        ),
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              alignment: Alignment.topCenter,
              children: [
                CameraPreview(_controller),
                widget.isShowFrames
                    ? Container(
                        height: maxHeight,
                        width: maxWidth,
                        color: AppColors.black,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 56),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          top: BorderSide(
                                            color: AppColors.background,
                                            width: 2,
                                          ),
                                          left: BorderSide(
                                            color: AppColors.background,
                                            width: 2,
                                          ))),
                                ),
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          top: BorderSide(
                                            color: AppColors.background,
                                            width: 2,
                                          ),
                                          right: BorderSide(
                                            color: AppColors.background,
                                            width: 2,
                                          ))),
                                )
                              ],
                            ),
                            Container(
                              width: 240,
                              height: 240,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 21, vertical: 24),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: AppColors.gray500,
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SvgPicture.asset(IconEnums.phoneActionCheck),
                                  Text(
                                    l10n(context)!.camera_decription,
                                    textAlign: TextAlign.center,
                                    style: Styles.subtitleLarge
                                        .copyWith(color: AppColors.background),
                                  )
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                            color: AppColors.background,
                                            width: 2,
                                          ),
                                          left: BorderSide(
                                            color: AppColors.background,
                                            width: 2,
                                          ))),
                                ),
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                            color: AppColors.background,
                                            width: 2,
                                          ),
                                          right: BorderSide(
                                            color: AppColors.background,
                                            width: 2,
                                          ))),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    : const SizedBox()
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _buildResult(String imagePath, double maxWidth, Function onClose,
      Function onTakePhoto, Function onDone) {
    return Scaffold(
        bottomSheet: Container(
          height: 128,
          width: maxWidth,
          color: AppColors.black,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TouchableOpacity(
                  child: const Icon(
                    Icons.check,
                    color: AppColors.background,
                    size: 40,
                  ),
                  onTap: () => onDone()),
              TouchableOpacity(
                  child: SvgPicture.asset(IconEnums.takePhotoButton),
                  onTap: () => onTakePhoto()),
              TouchableOpacity(
                child: const Icon(
                  Icons.close,
                  color: AppColors.background,
                  size: 40,
                ),
                onTap: () => onClose(),
              ),
            ],
          ),
        ),
        body: Image.file(File(imagePath)));
  }
}
