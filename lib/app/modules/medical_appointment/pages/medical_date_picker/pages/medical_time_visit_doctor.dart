import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pstb/app/modules/medical_appointment/medical_appointment_store.dart';
import 'package:pstb/app/modules/medical_appointment/pages/medical_date_picker/widget/type_gender_widget.dart';
import 'package:pstb/app/modules/medical_appointment/pages/medical_date_picker/widget/type_personal_widget.dart';
import 'package:pstb/app/modules/profile/pages/new_edit_profile_page/widgets/new_edit_profile_tf.dart';
import 'package:pstb/app/user_app_store.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/custom_tabbar.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';
import '../../../../../models/booking_detail_model.dart';
import '../medical_store.dart';
import '../widget/dob_medical.dart';
import '../widget/list_day_visit.dart';
import '../widget/list_time_visit.dart';

class MedicalTimeVisitDoctor extends StatefulWidget {
  const MedicalTimeVisitDoctor({Key? key, required this.doctorId, this.booking})
      : super(key: key);
  final int? doctorId;
  final Booking? booking;

  @override
  _MedicalTimeVisitDoctorState createState() => _MedicalTimeVisitDoctorState();
}

class _MedicalTimeVisitDoctorState extends State<MedicalTimeVisitDoctor>
    with TickerProviderStateMixin {
  final MedicalAppointmentStore _medicalAppointmentStore =
      Modular.get<MedicalAppointmentStore>();
  final MedicalStore _controller = Modular.get<MedicalStore>();
  final _userStore = Modular.get<UserAppStore>();
  final _keyForm = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _personalIdController;
  late final TextEditingController _insuranceNumberController;
  late final TextEditingController _dobController;
  late TabController _tabController;
  late final List<Tab> _tab = const [
    Tab(
      text: 'Cá nhân',
    ),
    Tab(
      text: 'Người thân',
    ),
  ];

  @override
  void initState() {
    _controller.changeBuildContext(context);
    _nameController = TextEditingController(text: _userStore.user.fullName)
      ..addListener(() {
        _controller.namePersonal = _nameController.text;
      });
    _phoneController = TextEditingController(text: _userStore.user.phone)
      ..addListener(() {
        _controller.phoneNumber = _phoneController.text;
      });
    _personalIdController =
        TextEditingController(text: _userStore.user.personalId)
          ..addListener(() {
            _controller.personalId = _personalIdController.text;
          });
    _insuranceNumberController =
        TextEditingController(text: _userStore.user.insuranceNumber)
          ..addListener(() {
            _controller.insuranceNumber = _insuranceNumberController.text;
          });
    _dobController = TextEditingController(text: _userStore.user.dob)
      ..addListener(() {
        _controller.dob = _dobController.text;
      });
    _controller.genderType =
        _userStore.getUserGender == 'm' ? GenderType.m : GenderType.f;
    _controller.phoneNumber = _userStore.user.phone ?? '';
    _controller.namePersonal = _userStore.user.fullName ?? '';
    _controller.insuranceNumber = _userStore.user.insuranceNumber ?? '';
    _controller.personalId = _userStore.user.personalId ?? '';
    _controller.dob = _userStore.user.dob ?? '01/01/1900';
    if (widget.booking != null) {
      // var dateSeeDoctor =
      //     widget.booking!.timeSeeDoctor ?? widget.booking!.timeGetSample;
      var dateSeeDoctor = DateTime.now();
      // int days = widget.booking!.timeSeeDoctor != null
      //     ? widget.booking!.timeSeeDoctor!.difference(DateTime.now()).inDays
      //     : widget.booking!.timeGetSample!.difference(DateTime.now()).inDays;
      // _controller.setDateFromTimeVisitDoctor(days);
      _controller.initFirstTimeVisit();
      _controller.setBaseTimeVisit();
      _controller.firstListTimeVisit.clear();
      for (var item in _controller.listTimeVisit) {
        if (!dateSeeDoctor.isAfter(item.date) &&
            !dateSeeDoctor.isAtSameMomentAs(item.date)) {
          _controller.firstListTimeVisit.add(item);
        }
      }
    } else {
      var dateSeeDoctor = DateTime.now();
      _controller.initFirstTimeVisit();
      _controller.setBaseTimeVisit();
      _controller.firstListTimeVisit.clear();
      for (var item in _controller.listTimeVisit) {
        if (!dateSeeDoctor.isAfter(item.date) &&
            !dateSeeDoctor.isAtSameMomentAs(item.date)) {
          _controller.firstListTimeVisit.add(item);
        }
      }
    }
    _tabController = TabController(length: 2, vsync: this);
    _tabController.animateTo(0);
    _tabController.addListener(_handleTabSelection);
    super.initState();
  }

  void _handleTabSelection() {
    setState(() {});
  }

  void refreshDataPicked() {
    _controller.onChangeIdTimeVisit(null);
    // _controller.onChangeIdTimeGetResultTest(null);
  }

  void onClickDayVisit(idDayPicked) {
    _controller.onChangeIdDayPicked(idDayPicked);
    refreshDataPicked();
  }

  void onContinue() {
    if (widget.booking != null) {
      if (widget.booking!.timeSeeDoctor != null &&
          widget.booking!.timeGetSample == null) {
        _controller.updateTimeVisit(
            widget.booking!.id!, _controller.getTimeSeeDoctor!);
      } else if (widget.booking!.timeSeeDoctor == null &&
          widget.booking!.timeGetSample != null) {
        _controller.updateTimeVisit(
            widget.booking!.id!, _controller.getTimeGetResult!);
      } else {
        // var dateSeeDoctor = widget.booking!.timeGetSample;
        // int days =
        //     widget.booking!.timeGetSample!.difference(DateTime.now()).inDays;
        // _controller.setDateFromTimeVisitDoctor(days);
        // _controller.initFirstTimeVisit();
        // _controller.setBaseTimeVisit();
        // if (dateSeeDoctor != null) {
        //   for (var item in _controller.listTimeGetSample) {
        //     if (!dateSeeDoctor.isAfter(item.date) &&
        //         !dateSeeDoctor.isAtSameMomentAs(item.date)) {
        //       _controller.firstResultTest.add(item);
        //     }
        //   }
        // }
        Modular.to.pushNamed(AppRoutes.medicalTimeGetResultTest,
            arguments: {"booking": widget.booking!});
      }
    } else {
      // print('next ${_controller.getTimeSeeDoctor} ${_controller.idSampleDayPicked}');
      if (_medicalAppointmentStore.isGetSampleInPackage) {
        Modular.to.pushNamed(AppRoutes.medicalTimeGetResultTest);
      } else {
        Modular.to.pushNamed(AppRoutes.appointmentConfirmAndPayment);
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _personalIdController.dispose();
    _insuranceNumberController.dispose();
    _dobController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: 'Thông tin lịch đặt khám',
          isBack: true,
        ),
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Observer(builder: (context) {
              return Form(
                  key: _keyForm,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TabbarWithNoContainer(
                        tabController: _tabController,
                        tabs: _tab,
                        onTap: (index) async {
                          if (index == 0) {
                            print('0');
                            _phoneController.text = _userStore.user.phone ?? '';
                            _nameController.text =
                                _userStore.user.fullName ?? '';
                            _insuranceNumberController.text =
                                _userStore.user.insuranceNumber ?? '';
                            _personalIdController.text =
                                _userStore.user.personalId ?? '';
                            _dobController.text = _userStore.user.dob ?? '';
                            _controller.genderType =
                                _userStore.getUserGender == 'm'
                                    ? GenderType.m
                                    : GenderType.f;
                            _keyForm.currentState!.validate();
                          } else if (index == 1) {
                            print('1');
                            _phoneController.clear();
                            _nameController.clear();
                            _insuranceNumberController.clear();
                            _dobController.clear();
                            _nameController.clear();
                            _personalIdController.clear();
                            _controller.genderType = GenderType.m;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      NewEditProfileTextField(
                        controller: _nameController,
                        hintText: 'Nhập họ và tên *',
                        padding: EdgeInsets.zero,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Không được để trống';
                          }
                          return null;
                        },
                        readOnly: false,
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      DobMedicalWidget(
                        controller: _dobController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Không được để trống';
                          }
                          return null;
                        },
                        dob: _controller.dob,
                        personalType: _controller.personalType,
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      TypeGenderWidget(
                        onChanged: _controller.setGenderType,
                        groupValue: _controller.genderType,
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      NewEditProfileTextField(
                        hintText: 'Số điện thoại đặt khám *',
                        padding: EdgeInsets.zero,
                        controller: _phoneController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Không được để trống';
                          }
                          // else if (value.length != 10) {
                          //   return 'Không được khác 10 ký tự';
                          // }
                          return null;
                        },
                        readOnly: false,
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      NewEditProfileTextField(
                        hintText: 'Số CMND',
                        padding: EdgeInsets.zero,
                        controller: _personalIdController,
                        readOnly: false,
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      NewEditProfileTextField(
                        hintText: 'Số thẻ bảo hiểm y tế',
                        padding: EdgeInsets.zero,
                        controller: _insuranceNumberController,
                        readOnly: false,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'Lịch khám',
                          style: Styles.titleItem,
                        ),
                      ),
                      SizedBox(
                        height: 60,
                        child: BuildListDayVisit(
                          listDayPickerLength: _controller.listDayPickerLength,
                          onClickDayVisit: onClickDayVisit,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        height: 50,
                        child: BuildListTimeVisit(
                          listAM: _controller.listTimeVisitAM,
                          listPM: _controller.listTimeVisitPM,
                          onTap: _controller.onChangeIdTimeVisit,
                          idTimePicked: _controller.idTimeVisit,
                        ),
                      ),
                      Row(
                        children: [
                          const Spacer(),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 12.0),
                              child: AppButton(
                                labelStyle: Styles.titleButton,
                                title: 'Tiếp tục',
                                onPressed: () {
                                  if (_controller.idTimeVisit == null) {
                                    Fluttertoast.showToast(
                                        msg: 'Hãy chọn thời gian đặt khám',
                                        backgroundColor: AppColors.error500,
                                        gravity: ToastGravity.BOTTOM);
                                    return;
                                  }
                                  if (_keyForm.currentState!.validate()) {
                                    onContinue();
                                  }
                                },
                              ),
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ],
                  ));
            }),
          ),
        ));
  }
}
