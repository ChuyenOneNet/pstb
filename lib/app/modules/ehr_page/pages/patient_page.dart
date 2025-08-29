import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/ehr_page/widgets/patient_information_page.dart';
import 'package:mobx/mobx.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/helper.dart';
import '../../../../utils/styles.dart';
import '../../../../widgets/stateless/app_bar.dart';
import '../../../app_store.dart';
import '../../../route_guard.dart';
import '../../auth_guard/auth_guard_page.dart';
import '../../notification/widget/hotline_phone_widget.dart';
import '../ehr_store.dart';

class PatientPage extends StatefulWidget {
  const PatientPage({Key? key}) : super(key: key);

  @override
  State<PatientPage> createState() => _PatientPageState();
}

class _PatientPageState extends State<PatientPage> {
  final AppStore _appStore = Modular.get<AppStore>();
  final UserGuard _userGuard = UserGuard();
  final EHRStore controller = Modular.get<EHRStore>();

  void checkLogin() async {
    UserStatus isLogin = await _userGuard.canActivate();
    if (isLogin == UserStatus.Signed) {
      controller.loadPatientRecord();
    }
    controller.setIsLogin(isLogin);
  }

  @override
  void initState() {
    reaction((_) => _appStore.reload, (__) {
      controller.setIsLogin(UserStatus.Checking);
      checkLogin();
    });
    checkLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Danh sách hồ sơ',
        isBack: true,
      ),
      floatingActionButton: FloatingActionButton(
          elevation: 0.0,
          child: const Icon(
            Icons.call,
            color: Colors.white,
          ),
          backgroundColor: AppColors.primary,
          onPressed: () async {
            await launchUrlString("tel://${controller.supportPhoneNumber}");
          }),
      body: Observer(builder: (context) {
        return Column(children: [
          controller.isLogin == UserStatus.Signed
              ? controller.loading
                  ? const SizedBox()
                  : controller.listPatient.isNotEmpty
                      ? Expanded(child: PatientInfomation())
                      : Expanded(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                'Chưa có thông tin hồ sơ sức khỏe. Vui lòng quay lại sau!',
                                textAlign: TextAlign.center,
                                style: Styles.content,
                              ),
                            ),
                          ),
                        )
              : Expanded(child: AuthGuardPage()),
        ]);
      }),
    );
  }
}
