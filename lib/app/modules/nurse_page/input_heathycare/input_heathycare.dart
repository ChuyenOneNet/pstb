import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/home/home_store.dart';
import 'package:pstb/app/modules/nurse_page/nurse_searching_store.dart';
import 'package:pstb/app/modules/nurse_page/widgets/description_paper_widget.dart';
import 'package:pstb/app/modules/nurse_page/widgets/input_field_patient_widget.dart';
import 'package:pstb/utils/colors.dart';
import 'package:pstb/utils/gender_utils.dart';
import 'package:pstb/utils/l10n.dart';
import 'package:pstb/utils/styles.dart';
import 'package:pstb/utils/time_util.dart';
import 'package:pstb/widgets/stateless/app_bar.dart';
import 'package:pstb/widgets/stateless/app_button.dart';
import 'package:pstb/widgets/stateless/app_snack_bar.dart';
import 'package:pstb/widgets/stateless/bottom_sheets/picker_image_bottomsheet.dart';
import 'package:pstb/widgets/stateless/item_text_row.dart';
import 'package:permission_handler/permission_handler.dart';

class InputHealthyCare extends StatefulWidget {
  const InputHealthyCare({Key? key}) : super(key: key);

  @override
  State<InputHealthyCare> createState() => _InputHealthyCareState();
}

class _InputHealthyCareState extends State<InputHealthyCare> {
  final homeController = Modular.get<HomeStore>();
  final nurseController = Modular.get<NurseSearchingStore>();
  final _form = GlobalKey<FormState>();

  late TextEditingController controllerTextBreath;

  late TextEditingController controllerTextTemperature;

  late TextEditingController controllerTextMax;

  late TextEditingController controllerTextMin;

  late TextEditingController controllerTextVessel;

  late TextEditingController controllerDevelopments;

  late TextEditingController controllerTakeCare;

  late TextEditingController _controllerInfoPaper;

  late TextEditingController _controllerNamePaper;

  @override
  void initState() {
    // TODO: implement initState
    controllerTextBreath = TextEditingController()
      ..addListener(() {
        nurseController.breathing = controllerTextBreath.text;
      });
    controllerTextTemperature = TextEditingController()
      ..addListener(() {
        nurseController.temperature = controllerTextTemperature.text;
      });
    controllerTextMax = TextEditingController()
      ..addListener(() {
        nurseController.max = controllerTextMax.text;
      });
    controllerTextMin = TextEditingController()
      ..addListener(() {
        nurseController.min = controllerTextMin.text;
      });
    controllerTextVessel = TextEditingController()
      ..addListener(() {
        nurseController.pulse = controllerTextVessel.text;
      });
    controllerDevelopments = TextEditingController.fromValue(
      TextEditingValue(
          text: nurseController.progression,
          selection: TextSelection(
            baseOffset: nurseController.progression.length,
            extentOffset: nurseController.progression.length,
          )),
    );
    controllerTakeCare = TextEditingController.fromValue(
      TextEditingValue(
          text: nurseController.attentionInformation,
          selection: TextSelection(
            baseOffset: nurseController.attentionInformation.length,
            extentOffset: nurseController.attentionInformation.length,
          )),
    );
    _controllerInfoPaper = TextEditingController()
      ..addListener(() {
        nurseController.descriptionPaper = _controllerInfoPaper.text;
      });
    _controllerNamePaper = TextEditingController()
      ..addListener(() {
        nurseController.nameFile = _controllerNamePaper.text;
      });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controllerTextMax.dispose();
    controllerTextTemperature.dispose();
    controllerTextBreath.dispose();
    controllerTextMin.dispose();
    controllerDevelopments.dispose();
    nurseController.progression = "";
    nurseController.attentionInformation = "";
    controllerTextVessel.dispose();
    controllerTakeCare.dispose();
    _controllerInfoPaper.dispose();
    _controllerNamePaper.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Scaffold(
        appBar: CustomAppBar(
          title: homeController.isActiveInputHealthCare
              ? 'Nhập chăm sóc'
              : 'Giấy tờ kèm theo',
          isBack: true,
        ),
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Form(
            key: _form,
            child: ListView(
              physics: const ClampingScrollPhysics(),
              padding: const EdgeInsets.all(16),
              children: [
                Container(
                  decoration: Styles.cardShadow.copyWith(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Thông tin nhân viên y tế',
                            style: Styles.titleItem,
                          ),
                        ],
                      ),
                      const Divider(
                        color: AppColors.primary,
                      ),
                      Observer(builder: (context) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ItemTextRow(
                                title: 'Thời gian: ',
                                content: TimeUtil.format(
                                    DateTime.now(), TimeUtil.HHMMDDMMYYYY)),
                            ItemTextRow(
                                title: 'Mã NVYT: ',
                                content: nurseController.codeNurse ?? ''),
                            ItemTextRow(
                                title: 'Tên NVYT: ',
                                content: nurseController.nameNurse ?? ''),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Container(
                  decoration: Styles.cardShadow.copyWith(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Thông tin bệnh nhân',
                            style: Styles.titleItem,
                          ),
                        ],
                      ),
                      const Divider(
                        color: AppColors.primary,
                      ),
                      Observer(builder: (context) {
                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ItemTextRow(
                                  title: 'Mã BN: ',
                                  content:
                                      nurseController.patientModel.code ?? ""),
                              ItemTextRow(
                                  title: 'Tên BN: ',
                                  content:
                                      nurseController.patientModel.name ?? ""),
                              ItemTextRow(
                                  title: 'Tuổi: ',
                                  content:
                                      nurseController.patientModel.age ?? ""),
                              ItemTextRow(
                                  title: 'Giới tính: ',
                                  content: GenderUtils.parseGender(
                                      nurseController.patientModel.gender ??
                                          20)),
                            ]);
                      }),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                if (homeController.isActiveInputHealthCare)
                  InputFieldPatientWidget(
                    enableField: true,
                    controllerTextMax: controllerTextMax,
                    controllerTextMin: controllerTextMin,
                    controllerTextVessel: controllerTextVessel,
                    controllerTextBreath: controllerTextBreath,
                    controllerDevelopments: TextEditingController.fromValue(
                      TextEditingValue(
                          text: nurseController.progression,
                          selection: TextSelection(
                            baseOffset: nurseController.progression.length,
                            extentOffset: nurseController.progression.length,
                          )),
                    ),
                    controllerTakeCare: TextEditingController.fromValue(
                      TextEditingValue(
                          text: nurseController.attentionInformation,
                          selection: TextSelection(
                            baseOffset:
                                nurseController.attentionInformation.length,
                            extentOffset:
                                nurseController.attentionInformation.length,
                          )),
                    ),
                    controllerTextTemperature: controllerTextTemperature,
                  )
                else
                  DescriptionPaperWidget(
                    onPickImage: () async {
                      final permissionStatus =
                          await Permission.camera.request();
                      if (permissionStatus == PermissionStatus.granted ||
                          permissionStatus ==
                              PermissionStatus.permanentlyDenied) {
                        PickerImageBottomSheet.show(
                            context: context,
                            title: l10n(context).push_document,
                            checkOpenFile: true,
                            onDone: (file) {
                              nurseController.onChangeImage(file);
                              _controllerNamePaper.text = file.name;
                              nurseController.setNameFile(file.name);
                            },
                            onDoneFile: (file) {
                              _controllerNamePaper.text = file.name;
                              nurseController.onChangeFile(file);
                            });
                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                CupertinoAlertDialog(
                                  title: Text(l10n(context)!.camera_permission),
                                  content: Text(
                                      l10n(context)!.camera_permission_content),
                                  actions: <Widget>[
                                    CupertinoDialogAction(
                                      child: Text(l10n(context)!.deny),
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                    ),
                                    CupertinoDialogAction(
                                        child: Text(l10n(context)!.setting),
                                        onPressed: () {
                                          openAppSettings();
                                          Navigator.of(context).pop();
                                        }),
                                  ],
                                ));
                      }
                    },
                    imagePicker: nurseController.displayImage,
                    onDeletePhoto: () {
                      nurseController.pickImage = '';
                      nurseController.displayImage = '';
                      _controllerInfoPaper.clear();
                      _controllerNamePaper.clear();
                    },
                    controller: _controllerInfoPaper,
                    nameEditingController: _controllerNamePaper,
                  ),
                Row(
                  children: [
                    const Spacer(),
                    Flexible(
                      flex: 2,
                      child: AppButton(
                        title: l10n(context).confirm,
                        onPressed: () async {
                          if (!_form.currentState!.validate()) {
                            return;
                          }
                          if (homeController.isActiveInputHealthCare) {
                            await nurseController.setNursingWithPatient();
                            EasyLoading.dismiss();
                            if (nurseController.isDone) {
                              AppSnackBar.show(context, AppSnackBarType.Success,
                                  'Nhập thông tin bệnh nhân thành công.');
                              Modular.to.pop();
                            } else {
                              AppSnackBar.show(context, AppSnackBarType.Error,
                                  'Cập nhật thông tin thất bại');
                              return;
                            }
                          } else {
                            if (nurseController.pickImage != null &&
                                nurseController.pickImage!.isNotEmpty) {
                              await nurseController.uploadDocumentImage(
                                  nurseController.codePatient,
                                  nurseController.codeNurse);
                              if (nurseController.isDone) {
                                AppSnackBar.show(
                                    context,
                                    AppSnackBarType.Success,
                                    'Gửi tài liệu ảnh thành công.');
                                Modular.to.pop();
                              } else {
                                AppSnackBar.show(context, AppSnackBarType.Error,
                                    'Gửi tài liệu ảnh thất bại');
                                return;
                              }
                            } else {
                              await nurseController.uploadDocument(
                                  nurseController.codePatient,
                                  nurseController.codeNurse);
                              if (nurseController.isDone) {
                                AppSnackBar.show(
                                    context,
                                    AppSnackBarType.Success,
                                    'Gửi tài liệu thành công.');
                                Modular.to.pop();
                              } else {
                                AppSnackBar.show(context, AppSnackBarType.Error,
                                    'Gửi tài liệu thất bại');
                                return;
                              }
                            }
                          }
                        },
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
