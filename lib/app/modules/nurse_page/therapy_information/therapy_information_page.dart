import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pstb/app/modules/nurse_page/therapy_information/therapy_information_store.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateful/app_input.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';

class TherapyInformationPage extends StatefulWidget {
  const TherapyInformationPage({Key? key}) : super(key: key);

  @override
  State<TherapyInformationPage> createState() => _TherapyInformationPageState();
}

class _TherapyInformationPageState extends State<TherapyInformationPage> {
  late TextEditingController _patientController;
  final _controller = Modular.get<TherapyInformationStore>();
  @override
  void initState() {
    _patientController = TextEditingController()..addListener(() {});
    super.initState();
  }

  @override
  void dispose() {
    Modular.dispose<TherapyInformationStore>();
    _patientController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Tra cứu thông tin điều trị',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: AppInput(
                      controller: _patientController,
                      hintText: l10n(context).input_code_patient,
                      autofocus: true,
                      fillColor: AppColors.surfaceLight,
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
                      _patientController.text =
                          (value as String).replaceAll(RegExp(r'[^\w\s]+'), '');
                      Future.delayed(const Duration(milliseconds: 500),
                          () async {
                        await _controller.getPatient(
                            patientCode: _patientController.text);
                        if (_controller.errorMessage == null) {
                          Modular.to
                              .pushNamed(AppRoutes.detailTherapy, arguments: {
                            'id': _patientController.text,
                          });
                          return;
                        }
                        Fluttertoast.showToast(msg: _controller.errorMessage!);
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
                      onPressed: () async {
                        await _controller.getPatient(
                            patientCode: _patientController.text);
                        if (_controller.errorMessage == null) {
                          Modular.to
                              .pushNamed(AppRoutes.detailTherapy, arguments: {
                            'id': _patientController.text,
                          });
                          return;
                        }
                        Fluttertoast.showToast(msg: _controller.errorMessage!);
                      },
                      title: l10n(context).confirm,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              Image.asset(ImageEnum.imageTherapy)
            ],
          ),
        ),
      ),
    );
  }
}
