import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:pstb/app/app_store.dart';
import 'package:pstb/app/modules/medical_appointment/medical_appointment_store.dart';
import 'package:pstb/app/modules/medical_appointment/pages/confirm_and_payment/confirm_and_payment_store.dart';
import 'package:pstb/app/modules/medical_appointment/pages/confirm_and_payment/widgets/header_bill_widget.dart';
import 'package:pstb/app/modules/medical_appointment/pages/confirm_and_payment/widgets/infor_unit.dart';
import 'package:pstb/app/modules/medical_appointment/pages/medical_date_picker/medical_store.dart';
import 'package:pstb/app/user_app_store.dart';
import 'package:pstb/utils/image_utils.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';
import '../../../home/home_store.dart';

class ConfirmAndPaymentSuccess extends StatefulWidget {
  const ConfirmAndPaymentSuccess({Key? key, this.code, this.qrCode})
      : super(key: key);
  final String? code;
  final String? qrCode;
  @override
  State<StatefulWidget> createState() {
    return _ConfirmAndPaymentState();
  }
}

class _ConfirmAndPaymentState extends State<ConfirmAndPaymentSuccess> {
  final AppStore _appStore = Modular.get<AppStore>();
  final _userAppStore = Modular.get<UserAppStore>();
  final MedicalAppointmentStore _medicalAppointmentStore =
      Modular.get<MedicalAppointmentStore>();
  final MedicalStore _medicalStore = Modular.get<MedicalStore>();
  final _homeStore = Modular.get<HomeStore>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    Modular.dispose<MedicalStore>();
    Modular.dispose<MedicalAppointmentStore>();
    Modular.dispose<ConfirmAndPaymentStore>();
    super.dispose();
  }

  void onClickHome() {
    _appStore.setReload(!_appStore.reload);
    Modular.to.popUntil(
      ModalRoute.withName("${AppRoutes.main}/"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: widthConvert(context, 16)),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 32.0,
                      ),
                      InformationUnit(
                        imageQr:
                            ImageUtils.dataFromBase64String(widget.qrCode!),
                        confirm: 'Đặt lịch thành công',
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      HeaderBillWidget(
                        codeBill: widget.code,
                        name: _userAppStore.getUserName,
                        date: DateFormat(DateTimeFormatPattern.formatddMMyyyy)
                            .format(_medicalStore.getTimeSeeDoctor ??
                                DateTime.now()),
                        timer: DateFormat(DateTimeFormatPattern.formatHHmm)
                            .format(_medicalStore.getTimeSeeDoctor ??
                                DateTime.now()),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: Observer(
                    builder: (context) {
                      if (!_medicalAppointmentStore.consultation) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                await _homeStore.getBookings();
                                Modular.to.popUntil(
                                    ModalRoute.withName(AppRoutes.main));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color.fromRGBO(
                                                194, 198, 201, 0.3),
                                            offset: Offset(2, 3),
                                          ),
                                        ],
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(4),
                                            bottomRight: Radius.circular(4))),
                                    padding: const EdgeInsets.only(
                                        left: 16, top: 4, bottom: 2),
                                    margin: const EdgeInsets.only(
                                        top: 10, left: 44),
                                    child: Text(
                                      'QUAY LẠI TRANG CHỦ ',
                                      style: Styles.titleItem
                                          .copyWith(color: AppColors.primary),
                                    ),
                                  ),
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: const BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color.fromRGBO(
                                                194, 198, 201, 0.3),
                                            offset: Offset(0, 5),
                                          ),
                                        ],
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25))),
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      margin: const EdgeInsets.all(6),
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          color: AppColors.primary),
                                      child: SvgPicture.asset(
                                        IconEnums.yellowArrow,
                                        color: AppColors.background,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BuildBtn extends StatelessWidget {
  final Function() onClickHome;

  const BuildBtn({
    Key? key,
    required this.onClickHome,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heightConvert(context, 812),
      width: widthConvert(context, 375),
      padding: EdgeInsets.symmetric(horizontal: widthConvert(context, 16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const SizedBox(),
          Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: heightConvert(context, 16)),
                child: AppButtonOutline(
                  text: l10n(context)!.forgotSuccess_btn_back_home,
                  onClick: onClickHome,
                  color: AppColors.primary500,
                  buttonSize: 48,
                  borderRadius: BorderRadius.circular(24),
                  labelStyle: Styles.titleButton.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary500,
                    height: 1,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: heightConvert(context, 44)),
                child: AppButtonOutline(
                  text: l10n(context)!.hotline.toString().toUpperCase(),
                  phoneNumber: Constants.contactPhone,
                  buttonSize: 40,
                  labelStyle: Styles.titleButton.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.error900,
                    height: 1,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
