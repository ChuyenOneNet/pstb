// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_appointment_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DoctorAppointmentStore on _DoctorAppointmentStoreBase, Store {
  late final _$listAppointmentAtom = Atom(
      name: '_DoctorAppointmentStoreBase.listAppointment', context: context);

  @override
  ObservableList<AppointmentModel> get listAppointment {
    _$listAppointmentAtom.reportRead();
    return super.listAppointment;
  }

  @override
  set listAppointment(ObservableList<AppointmentModel> value) {
    _$listAppointmentAtom.reportWrite(value, super.listAppointment, () {
      super.listAppointment = value;
    });
  }

  late final _$listAppointmentEventAtom = Atom(
      name: '_DoctorAppointmentStoreBase.listAppointmentEvent',
      context: context);

  @override
  ObservableList<AppointmentModel> get listAppointmentEvent {
    _$listAppointmentEventAtom.reportRead();
    return super.listAppointmentEvent;
  }

  @override
  set listAppointmentEvent(ObservableList<AppointmentModel> value) {
    _$listAppointmentEventAtom.reportWrite(value, super.listAppointmentEvent,
        () {
      super.listAppointmentEvent = value;
    });
  }

  late final _$mySelectedEventsAtom = Atom(
      name: '_DoctorAppointmentStoreBase.mySelectedEvents', context: context);

  @override
  Map<String, List<dynamic>> get mySelectedEvents {
    _$mySelectedEventsAtom.reportRead();
    return super.mySelectedEvents;
  }

  @override
  set mySelectedEvents(Map<String, List<dynamic>> value) {
    _$mySelectedEventsAtom.reportWrite(value, super.mySelectedEvents, () {
      super.mySelectedEvents = value;
    });
  }

  late final _$isDataListAtom =
      Atom(name: '_DoctorAppointmentStoreBase.isDataList', context: context);

  @override
  bool get isDataList {
    _$isDataListAtom.reportRead();
    return super.isDataList;
  }

  @override
  set isDataList(bool value) {
    _$isDataListAtom.reportWrite(value, super.isDataList, () {
      super.isDataList = value;
    });
  }

  late final _$pageIndexAtom =
      Atom(name: '_DoctorAppointmentStoreBase.pageIndex', context: context);

  @override
  int get pageIndex {
    _$pageIndexAtom.reportRead();
    return super.pageIndex;
  }

  @override
  set pageIndex(int value) {
    _$pageIndexAtom.reportWrite(value, super.pageIndex, () {
      super.pageIndex = value;
    });
  }

  late final _$statusAtom =
      Atom(name: '_DoctorAppointmentStoreBase.status', context: context);

  @override
  String get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(String value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  late final _$getAllAppointmentAsyncAction = AsyncAction(
      '_DoctorAppointmentStoreBase.getAllAppointment',
      context: context);

  @override
  Future<void> getAllAppointment({String? fromDate, String? toDate}) {
    return _$getAllAppointmentAsyncAction
        .run(() => super.getAllAppointment(fromDate: fromDate, toDate: toDate));
  }

  late final _$getAllAppointmentEventAsyncAction = AsyncAction(
      '_DoctorAppointmentStoreBase.getAllAppointmentEvent',
      context: context);

  @override
  Future<void> getAllAppointmentEvent(String? fromDate, String? toDate) {
    return _$getAllAppointmentEventAsyncAction
        .run(() => super.getAllAppointmentEvent(fromDate, toDate));
  }

  late final _$loadMoreAppointmentAsyncAction = AsyncAction(
      '_DoctorAppointmentStoreBase.loadMoreAppointment',
      context: context);

  @override
  Future<void> loadMoreAppointment() {
    return _$loadMoreAppointmentAsyncAction
        .run(() => super.loadMoreAppointment());
  }

  late final _$_DoctorAppointmentStoreBaseActionController =
      ActionController(name: '_DoctorAppointmentStoreBase', context: context);

  @override
  dynamic onChangeStatus(String value) {
    final _$actionInfo = _$_DoctorAppointmentStoreBaseActionController
        .startAction(name: '_DoctorAppointmentStoreBase.onChangeStatus');
    try {
      return super.onChangeStatus(value);
    } finally {
      _$_DoctorAppointmentStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
listAppointment: ${listAppointment},
listAppointmentEvent: ${listAppointmentEvent},
mySelectedEvents: ${mySelectedEvents},
isDataList: ${isDataList},
pageIndex: ${pageIndex},
status: ${status}
    ''';
  }
}
