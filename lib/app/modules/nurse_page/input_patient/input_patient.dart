import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pstb/app/modules/home/home_store.dart';
import 'package:pstb/app/modules/nurse_page/nurse_searching_store.dart';
import 'package:pstb/services/api_base_helper.dart';
import 'package:pstb/services/profile_personal_service.dart';
import 'package:pstb/utils/colors.dart';
import 'package:pstb/utils/icons.dart';
import 'package:pstb/utils/l10n.dart';
import 'package:pstb/utils/routes.dart';
import 'package:pstb/utils/styles.dart';
import 'package:pstb/utils/time_util.dart';
import 'package:pstb/widgets/stateful/app_input.dart';
import 'package:pstb/widgets/stateless/app_bar.dart';
import 'package:pstb/widgets/stateless/app_button.dart';
import 'package:pstb/widgets/stateless/app_snack_bar.dart';
import 'package:pstb/widgets/stateless/button_back.dart';
import 'package:pstb/widgets/stateless/item_text_row.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InputPatient extends StatefulWidget {
  const InputPatient({Key? key}) : super(key: key);

  @override
  State<InputPatient> createState() => _InputPatientState();
}

class _InputPatientState extends State<InputPatient> {
  final _form = GlobalKey<FormState>();
  final nurseController = Modular.get<NurseSearchingStore>();
  final homeController = Modular.get<HomeStore>();
  final _profileService = ProfilePersonalService(
      baseHelper: Modular.get<ApiBaseHelper>(),
      sharedPreferences: Modular.getAsync<SharedPreferences>());
  late TextEditingController patientEditingController;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      await nurseController.initState();
    });
    patientEditingController =
        TextEditingController(text: nurseController.codePatient)
          ..addListener(() {
            nurseController.codePatient = patientEditingController.text;
          });
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    patientEditingController.dispose();
    Modular.dispose<NurseSearchingStore>();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: Styles.defaultPageMargin,
              child: Form(
                key: _form,
                child: ListView(
                  physics: const ClampingScrollPhysics(),
                  padding: EdgeInsets.only(
                      top: 50,
                      bottom: MediaQuery.of(context).viewPadding.bottom + 12),
                  children: [
                    Container(
                      decoration: Styles.cardShadow.copyWith(
                        color: AppColors.background, borderRadius: BorderRadius.circular(8),),
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
                          Observer(
                              builder: (context) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ItemTextRow(title: 'Thời gian: ', content: TimeUtil.format(DateTime.now(), TimeUtil.HHMMDDMMYYYY)),
                                    ItemTextRow(title: 'Mã NVYT: ', content: nurseController.codeNurse ?? ''),
                                    ItemTextRow(title: 'Tên NVYT: ', content: nurseController.nameNurse ?? ''),
                                  ],
                                );
                              }
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16.0,),
                    Row(
                      children: [
                        Expanded(
                          child: AppInput(
                            controller: patientEditingController,
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
                            patientEditingController.text = (value as String)
                                .replaceAll(RegExp(r'[^\w\s]+'), '');
                            Future.delayed(const Duration(milliseconds: 500), () async {
                              await nurseController.pressActivePatient();
                              if (!nurseController.isActivePatient) {
                                AppSnackBar.show(context, AppSnackBarType.Error,
                                    'Không tìm thấy thông tin bệnh nhân');
                                return;
                              }
                              Modular.to.pushNamed(AppRoutes.inputHeathycare);
                            });
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
                              await nurseController.pressActivePatient();
                              if (!nurseController.isActivePatient) {
                                AppSnackBar.show(context, AppSnackBarType.Error,
                                    'Không tìm thấy thông tin bệnh nhân');
                                return;
                              }
                              Modular.to.pushNamed(AppRoutes.inputHeathycare);
                            },
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                    SvgPicture.asset(IconEnums.healthTeam),
                  ],
                ),
              ),
            ),
            const ButtonBackWidget(),
          ],
        ),
      ),
    );
  }
}
