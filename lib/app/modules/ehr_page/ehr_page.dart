import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/ehr_page/ehr_store.dart';
import 'package:pstb/app/modules/ehr_page/widgets/ehr_list_booking.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/app_bar.dart';
import 'package:mobx/mobx.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../app_store.dart';
import '../../route_guard.dart';
import '../auth_guard/auth_guard_page.dart';

class EHRPage extends StatefulWidget {
  final String patientId;
  final String phone;

  const EHRPage({
    Key? key,
    required this.patientId,
    required this.phone,
  }) : super(key: key);

  @override
  State<EHRPage> createState() => _EHRPageState();
}

class _EHRPageState extends State<EHRPage> {
  final AppStore _appStore = Modular.get<AppStore>();
  final UserGuard _userGuard = UserGuard();
  final EHRStore controller = Modular.get<EHRStore>();

  void checkLogin() async {
    UserStatus isLogin = await _userGuard.canActivate();
    if (isLogin == UserStatus.Signed) {
      await controller.loadMedicalRecord(
        widget.patientId,
      );
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
  void dispose() {
    Modular.dispose<EHRStore>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Hồ sơ sức khỏe',
        isBack: true,
        // actionIcon: const Icon(Icons.search, color: AppColors.primary,),
        // actionFunc: () {
        //   // Modular.to.pushNamed(AppRoutes.searchMedical, arguments: false);
        // },
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
        return Column(
          children: [
            controller.loading
                ? const SizedBox()
                : controller.data.patient != null
                    ? Expanded(
                        child: EHRListBooking(
                        patientId: widget.patientId,
                        phone: widget.phone,
                      ))
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
          ],
        );
      }),
    );
  }
}
