// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_detail_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ScheduleDetailStore on _ScheduleDetailStoreBase, Store {
  Computed<List<BottomSheetOptionModel>>? _$optionComputed;

  @override
  List<BottomSheetOptionModel> get option => (_$optionComputed ??=
          Computed<List<BottomSheetOptionModel>>(() => super.option,
              name: '_ScheduleDetailStoreBase.option'))
      .value;
  Computed<List<DonThuoc>?>? _$prescriptionDetailListComputed;

  @override
  List<DonThuoc>? get prescriptionDetailList =>
      (_$prescriptionDetailListComputed ??= Computed<List<DonThuoc>?>(
              () => super.prescriptionDetailList,
              name: '_ScheduleDetailStoreBase.prescriptionDetailList'))
          .value;
  Computed<List<ExaminationResults>>? _$resultExamListComputed;

  @override
  List<ExaminationResults> get resultExamList => (_$resultExamListComputed ??=
          Computed<List<ExaminationResults>>(() => super.resultExamList,
              name: '_ScheduleDetailStoreBase.resultExamList'))
      .value;
  Computed<String?>? _$titleComputed;

  @override
  String? get title => (_$titleComputed ??= Computed<String?>(() => super.title,
          name: '_ScheduleDetailStoreBase.title'))
      .value;
  Computed<String>? _$doctorComputed;

  @override
  String get doctor =>
      (_$doctorComputed ??= Computed<String>(() => super.doctor,
              name: '_ScheduleDetailStoreBase.doctor'))
          .value;
  Computed<String>? _$scheduleExamTimeComputed;

  @override
  String get scheduleExamTime => (_$scheduleExamTimeComputed ??=
          Computed<String>(() => super.scheduleExamTime,
              name: '_ScheduleDetailStoreBase.scheduleExamTime'))
      .value;
  Computed<String>? _$scheduleExamTimeDateComputed;

  @override
  String get scheduleExamTimeDate => (_$scheduleExamTimeDateComputed ??=
          Computed<String>(() => super.scheduleExamTimeDate,
              name: '_ScheduleDetailStoreBase.scheduleExamTimeDate'))
      .value;
  Computed<String>? _$scheduleExamTimeHourComputed;

  @override
  String get scheduleExamTimeHour => (_$scheduleExamTimeHourComputed ??=
          Computed<String>(() => super.scheduleExamTimeHour,
              name: '_ScheduleDetailStoreBase.scheduleExamTimeHour'))
      .value;
  Computed<String>? _$scheduleSampleTimeComputed;

  @override
  String get scheduleSampleTime => (_$scheduleSampleTimeComputed ??=
          Computed<String>(() => super.scheduleSampleTime,
              name: '_ScheduleDetailStoreBase.scheduleSampleTime'))
      .value;
  Computed<String>? _$diagnoseComputed;

  @override
  String get diagnose =>
      (_$diagnoseComputed ??= Computed<String>(() => super.diagnose,
              name: '_ScheduleDetailStoreBase.diagnose'))
          .value;
  Computed<String>? _$examTimeComputed;

  @override
  String get examTime =>
      (_$examTimeComputed ??= Computed<String>(() => super.examTime,
              name: '_ScheduleDetailStoreBase.examTime'))
          .value;
  Computed<String>? _$resultTimeComputed;

  @override
  String get resultTime =>
      (_$resultTimeComputed ??= Computed<String>(() => super.resultTime,
              name: '_ScheduleDetailStoreBase.resultTime'))
          .value;
  Computed<String>? _$prescriptionPresciptionStatusComputed;

  @override
  String get prescriptionPresciptionStatus =>
      (_$prescriptionPresciptionStatusComputed ??= Computed<String>(
              () => super.prescriptionPresciptionStatus,
              name: '_ScheduleDetailStoreBase.prescriptionPresciptionStatus'))
          .value;
  Computed<String>? _$prescriptionDoctorComputed;

  @override
  String get prescriptionDoctor => (_$prescriptionDoctorComputed ??=
          Computed<String>(() => super.prescriptionDoctor,
              name: '_ScheduleDetailStoreBase.prescriptionDoctor'))
      .value;
  Computed<String>? _$profileCodeComputed;

  @override
  String get profileCode =>
      (_$profileCodeComputed ??= Computed<String>(() => super.profileCode,
              name: '_ScheduleDetailStoreBase.profileCode'))
          .value;

  late final _$idBookingAtom =
      Atom(name: '_ScheduleDetailStoreBase.idBooking', context: context);

  @override
  String get idBooking {
    _$idBookingAtom.reportRead();
    return super.idBooking;
  }

  @override
  set idBooking(String value) {
    _$idBookingAtom.reportWrite(value, super.idBooking, () {
      super.idBooking = value;
    });
  }

  late final _$bookingInfoAtom =
      Atom(name: '_ScheduleDetailStoreBase.bookingInfo', context: context);

  @override
  BookingInfo get bookingInfo {
    _$bookingInfoAtom.reportRead();
    return super.bookingInfo;
  }

  @override
  set bookingInfo(BookingInfo value) {
    _$bookingInfoAtom.reportWrite(value, super.bookingInfo, () {
      super.bookingInfo = value;
    });
  }

  late final _$loadingAtom =
      Atom(name: '_ScheduleDetailStoreBase.loading', context: context);

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  late final _$prescriptionDetailAtom = Atom(
      name: '_ScheduleDetailStoreBase.prescriptionDetail', context: context);

  @override
  NewPrescriptionModel get prescriptionDetail {
    _$prescriptionDetailAtom.reportRead();
    return super.prescriptionDetail;
  }

  @override
  set prescriptionDetail(NewPrescriptionModel value) {
    _$prescriptionDetailAtom.reportWrite(value, super.prescriptionDetail, () {
      super.prescriptionDetail = value;
    });
  }

  late final _$bookingDetailAtom =
      Atom(name: '_ScheduleDetailStoreBase.bookingDetail', context: context);

  @override
  booking_detail.Booking? get bookingDetail {
    _$bookingDetailAtom.reportRead();
    return super.bookingDetail;
  }

  @override
  set bookingDetail(booking_detail.Booking? value) {
    _$bookingDetailAtom.reportWrite(value, super.bookingDetail, () {
      super.bookingDetail = value;
    });
  }

  late final _$resultExamAtom =
      Atom(name: '_ScheduleDetailStoreBase.resultExam', context: context);

  @override
  m_r_detail.Data get resultExam {
    _$resultExamAtom.reportRead();
    return super.resultExam;
  }

  @override
  set resultExam(m_r_detail.Data value) {
    _$resultExamAtom.reportWrite(value, super.resultExam, () {
      super.resultExam = value;
    });
  }

  late final _$deleteScheduleAsyncAction =
      AsyncAction('_ScheduleDetailStoreBase.deleteSchedule', context: context);

  @override
  Future<void> deleteSchedule(int? id) {
    return _$deleteScheduleAsyncAction.run(() => super.deleteSchedule(id));
  }

  late final _$getPrescriptionDetailAsyncAction = AsyncAction(
      '_ScheduleDetailStoreBase.getPrescriptionDetail',
      context: context);

  @override
  Future<void> getPrescriptionDetail(
      dynamic _maHoSo, dynamic _id, bool isCompleted) {
    return _$getPrescriptionDetailAsyncAction
        .run(() => super.getPrescriptionDetail(_maHoSo, _id, isCompleted));
  }

  late final _$_ScheduleDetailStoreBaseActionController =
      ActionController(name: '_ScheduleDetailStoreBase', context: context);

  @override
  void changeBuildContext(BuildContext newContext) {
    final _$actionInfo = _$_ScheduleDetailStoreBaseActionController.startAction(
        name: '_ScheduleDetailStoreBase.changeBuildContext');
    try {
      return super.changeBuildContext(newContext);
    } finally {
      _$_ScheduleDetailStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onChangePaymentInfo(BookingInfo value) {
    final _$actionInfo = _$_ScheduleDetailStoreBaseActionController.startAction(
        name: '_ScheduleDetailStoreBase.onChangePaymentInfo');
    try {
      return super.onChangePaymentInfo(value);
    } finally {
      _$_ScheduleDetailStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
idBooking: ${idBooking},
bookingInfo: ${bookingInfo},
loading: ${loading},
prescriptionDetail: ${prescriptionDetail},
bookingDetail: ${bookingDetail},
resultExam: ${resultExam},
option: ${option},
prescriptionDetailList: ${prescriptionDetailList},
resultExamList: ${resultExamList},
title: ${title},
doctor: ${doctor},
scheduleExamTime: ${scheduleExamTime},
scheduleExamTimeDate: ${scheduleExamTimeDate},
scheduleExamTimeHour: ${scheduleExamTimeHour},
scheduleSampleTime: ${scheduleSampleTime},
diagnose: ${diagnose},
examTime: ${examTime},
resultTime: ${resultTime},
prescriptionPresciptionStatus: ${prescriptionPresciptionStatus},
prescriptionDoctor: ${prescriptionDoctor},
profileCode: ${profileCode}
    ''';
  }
}
