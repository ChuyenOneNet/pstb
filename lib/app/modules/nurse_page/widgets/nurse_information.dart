import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pstb/app/modules/nurse_page/nurse_searching_store.dart';
import 'package:pstb/app/modules/nurse_page/widgets/description_paper_widget.dart';
import 'package:pstb/utils/gender_utils.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateful/app_input.dart';
import 'package:pstb/widgets/stateless/bottom_sheets/picker_image_bottomsheet.dart';
import 'package:permission_handler/permission_handler.dart';

import 'button_healthcare_widget.dart';
import 'input_field_patient_widget.dart';

class NurseWidget extends StatefulWidget {
  NurseWidget({
    Key? key,
    this.validatorPatient,
    required this.controller,
    required this.nameEditingController,
    required this.patientEditingController,
  }) : super(key: key);

  final String? Function(String?)? validatorPatient;
  final TextEditingController controller;
  final TextEditingController nameEditingController;
  final TextEditingController patientEditingController;

  @override
  State<NurseWidget> createState() => _NurseWidgetState();
}

class _NurseWidgetState extends State<NurseWidget> {
  final nurseController = Modular.get<NurseSearchingStore>();

  late TextEditingController controllerTextBreath;

  late TextEditingController controllerTextTemperature;

  late TextEditingController controllerTextMax;

  late TextEditingController controllerTextMin;

  late TextEditingController controllerTextVessel;

  late TextEditingController controllerDevelopments;

  late TextEditingController controllerTakeCare;

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
    controllerDevelopments = TextEditingController()
      ..addListener(() {
        nurseController.attentionInformation = controllerDevelopments.text;
      });
    controllerTakeCare = TextEditingController()
      ..addListener(() {
        nurseController.progression = controllerTakeCare.text;
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
    controllerTextVessel.dispose();
    controllerTakeCare.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Text(
              'Mã NVYT: ${nurseController.nurseModel.code ?? ''}',
              style: Styles.content,
            ),
          ),
          Text(
            'Tên NVYT: ${nurseController.nurseModel.name ?? ''}',
            style: Styles.content,
          ),
          if (nurseController.isActiveButton) const ButtonHealthcareWidget(),
          nurseController.isActivePatient
              ? const Divider(
                  color: AppColors.black,
                  thickness: 2,
                  height: 24,
                )
              : SizedBox(
                  height: heightConvert(context, 24),
                ),
          nurseController.isActiveButton
              ? const SizedBox()
              : nurseController.isActivePatient
                  ? Text(
                      'Mã BN: ${nurseController.patientModel.code}',
                      style: Styles.content,
                    )
                  : Row(
                      children: [
                        Expanded(
                          child: AppInput(
                            controller: widget.patientEditingController,
                            hintText: l10n(context).input_code_patient,
                            autofocus: true,
                            fillColor: AppColors.surfaceLight,
                            onChangeValue: nurseController.setCodePatient,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Không được để trống';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        InkWell(
                          onTap: () async {
                            final value =
                                await Modular.to.pushNamed(AppRoutes.qrCode);
                            widget.patientEditingController.text =
                                (value as String)
                                    .replaceAll(RegExp(r'[^\w\s]+'), '');
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(
                              IconEnums.qrCode1,
                              color: AppColors.primary,
                              width: 60,
                            ),
                          ),
                        ),
                      ],
                    ),
          if (nurseController.isActivePatient)
            Text(
              'Tên BN: ${nurseController.patientModel.name}',
              style: Styles.content,
            ),
          if (nurseController.isActivePatient)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (nurseController.patientModel.age != null)
                  Text(
                    'Tuổi: ${nurseController.patientModel.age}',
                    style: Styles.content,
                  ),
                if (nurseController.patientModel.gender != null)
                  Text(
                    'Giới tính: ${GenderUtils.parseGender(nurseController.patientModel.gender ?? 4)}',
                    style: Styles.content,
                  )
              ],
            ),
          const SizedBox(
            height: 8,
          ),
          if (nurseController.isActivePatient &&
              nurseController.isActiveInputHealthCare)
            InputFieldPatientWidget(
              // textVessel: "",
              // textMin: "",
              // textTemperature: "",
              // textBreath: "",
              // textMax: "",
              // takeCare: "",
              // developments: "",
              enableField: true,
              controllerTextMax: controllerTextMax,
              controllerTextMin: controllerTextMin,
              controllerTextVessel: controllerTextVessel,
              controllerTextBreath: controllerTextBreath,
              controllerDevelopments: controllerDevelopments,
              controllerTakeCare: controllerTakeCare,
              controllerTextTemperature: controllerTextTemperature,
            ),
          if (nurseController.isActivePatient && nurseController.isActivePaper)
            DescriptionPaperWidget(
              onPickImage: () async {
                final permissionStatus = await Permission.camera.request();
                if (permissionStatus == PermissionStatus.granted ||
                    permissionStatus == PermissionStatus.permanentlyDenied) {
                  PickerImageBottomSheet.show(
                      context: context,
                      title: l10n(context).push_document,
                      checkOpenFile: true,
                      onDone: (file) {
                        nurseController.onChangeImage(file);
                        widget.nameEditingController.text = file.name;
                        nurseController.setNameFile(file.name);
                      },
                      onDoneFile: (file) {
                        widget.nameEditingController.text = file.name;
                        nurseController.onChangeFile(file);
                      });
                } else {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => CupertinoAlertDialog(
                            title: Text(l10n(context)!.camera_permission),
                            content:
                                Text(l10n(context)!.camera_permission_content),
                            actions: <Widget>[
                              CupertinoDialogAction(
                                child: Text(l10n(context)!.deny),
                                onPressed: () => Navigator.of(context).pop(),
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
                widget.controller.clear();
                widget.nameEditingController.clear();
              },
              controller: widget.controller,
              nameEditingController: widget.nameEditingController,
            )
        ],
      );
    });
  }
}
