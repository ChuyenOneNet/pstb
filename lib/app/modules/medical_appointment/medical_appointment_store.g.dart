// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medical_appointment_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MedicalAppointmentStore on MedicalAppointmentStoreBase, Store {
  Computed<bool>? _$isGetSampleInPackageComputed;

  @override
  bool get isGetSampleInPackage => (_$isGetSampleInPackageComputed ??=
          Computed<bool>(() => super.isGetSampleInPackage,
              name: 'MedicalAppointmentStoreBase.isGetSampleInPackage'))
      .value;

  late final _$consultationAtom =
      Atom(name: 'MedicalAppointmentStoreBase.consultation', context: context);

  @override
  bool get consultation {
    _$consultationAtom.reportRead();
    return super.consultation;
  }

  @override
  set consultation(bool value) {
    _$consultationAtom.reportWrite(value, super.consultation, () {
      super.consultation = value;
    });
  }

  late final _$testAtHomeAtom =
      Atom(name: 'MedicalAppointmentStoreBase.testAtHome', context: context);

  @override
  bool get testAtHome {
    _$testAtHomeAtom.reportRead();
    return super.testAtHome;
  }

  @override
  set testAtHome(bool value) {
    _$testAtHomeAtom.reportWrite(value, super.testAtHome, () {
      super.testAtHome = value;
    });
  }

  late final _$visibleAtom =
      Atom(name: 'MedicalAppointmentStoreBase.visible', context: context);

  @override
  bool get visible {
    _$visibleAtom.reportRead();
    return super.visible;
  }

  @override
  set visible(bool value) {
    _$visibleAtom.reportWrite(value, super.visible, () {
      super.visible = value;
    });
  }

  late final _$checkTimeVisitDoctorAtom = Atom(
      name: 'MedicalAppointmentStoreBase.checkTimeVisitDoctor',
      context: context);

  @override
  bool get checkTimeVisitDoctor {
    _$checkTimeVisitDoctorAtom.reportRead();
    return super.checkTimeVisitDoctor;
  }

  @override
  set checkTimeVisitDoctor(bool value) {
    _$checkTimeVisitDoctorAtom.reportWrite(value, super.checkTimeVisitDoctor,
        () {
      super.checkTimeVisitDoctor = value;
    });
  }

  late final _$examAtHomeAtom =
      Atom(name: 'MedicalAppointmentStoreBase.examAtHome', context: context);

  @override
  bool get examAtHome {
    _$examAtHomeAtom.reportRead();
    return super.examAtHome;
  }

  @override
  set examAtHome(bool value) {
    _$examAtHomeAtom.reportWrite(value, super.examAtHome, () {
      super.examAtHome = value;
    });
  }

  late final _$dataForAtHomeAtom =
      Atom(name: 'MedicalAppointmentStoreBase.dataForAtHome', context: context);

  @override
  bool get dataForAtHome {
    _$dataForAtHomeAtom.reportRead();
    return super.dataForAtHome;
  }

  @override
  set dataForAtHome(bool value) {
    _$dataForAtHomeAtom.reportWrite(value, super.dataForAtHome, () {
      super.dataForAtHome = value;
    });
  }

  late final _$selectedCategoryGroupIdAtom = Atom(
      name: 'MedicalAppointmentStoreBase.selectedCategoryGroupId',
      context: context);

  @override
  String get selectedCategoryGroupId {
    _$selectedCategoryGroupIdAtom.reportRead();
    return super.selectedCategoryGroupId;
  }

  @override
  set selectedCategoryGroupId(String value) {
    _$selectedCategoryGroupIdAtom
        .reportWrite(value, super.selectedCategoryGroupId, () {
      super.selectedCategoryGroupId = value;
    });
  }

  late final _$isMedicalFacilAtom = Atom(
      name: 'MedicalAppointmentStoreBase.isMedicalFacil', context: context);

  @override
  bool get isMedicalFacil {
    _$isMedicalFacilAtom.reportRead();
    return super.isMedicalFacil;
  }

  @override
  set isMedicalFacil(bool value) {
    _$isMedicalFacilAtom.reportWrite(value, super.isMedicalFacil, () {
      super.isMedicalFacil = value;
    });
  }

  late final _$packagesListAtom =
      Atom(name: 'MedicalAppointmentStoreBase.packagesList', context: context);

  @override
  ObservableList<PackageModel> get packagesList {
    _$packagesListAtom.reportRead();
    return super.packagesList;
  }

  @override
  set packagesList(ObservableList<PackageModel> value) {
    _$packagesListAtom.reportWrite(value, super.packagesList, () {
      super.packagesList = value;
    });
  }

  late final _$listPackageShowedAtom = Atom(
      name: 'MedicalAppointmentStoreBase.listPackageShowed', context: context);

  @override
  ObservableList<PackageModel> get listPackageShowed {
    _$listPackageShowedAtom.reportRead();
    return super.listPackageShowed;
  }

  @override
  set listPackageShowed(ObservableList<PackageModel> value) {
    _$listPackageShowedAtom.reportWrite(value, super.listPackageShowed, () {
      super.listPackageShowed = value;
    });
  }

  late final _$searchObjAtom =
      Atom(name: 'MedicalAppointmentStoreBase.searchObj', context: context);

  @override
  SearchModel get searchObj {
    _$searchObjAtom.reportRead();
    return super.searchObj;
  }

  @override
  set searchObj(SearchModel value) {
    _$searchObjAtom.reportWrite(value, super.searchObj, () {
      super.searchObj = value;
    });
  }

  late final _$loadingPackageAtom = Atom(
      name: 'MedicalAppointmentStoreBase.loadingPackage', context: context);

  @override
  bool get loadingPackage {
    _$loadingPackageAtom.reportRead();
    return super.loadingPackage;
  }

  @override
  set loadingPackage(bool value) {
    _$loadingPackageAtom.reportWrite(value, super.loadingPackage, () {
      super.loadingPackage = value;
    });
  }

  late final _$errloadPackageAtom = Atom(
      name: 'MedicalAppointmentStoreBase.errloadPackage', context: context);

  @override
  bool get errloadPackage {
    _$errloadPackageAtom.reportRead();
    return super.errloadPackage;
  }

  @override
  set errloadPackage(bool value) {
    _$errloadPackageAtom.reportWrite(value, super.errloadPackage, () {
      super.errloadPackage = value;
    });
  }

  late final _$selectedPackageAtom = Atom(
      name: 'MedicalAppointmentStoreBase.selectedPackage', context: context);

  @override
  PackageModel get selectedPackage {
    _$selectedPackageAtom.reportRead();
    return super.selectedPackage;
  }

  @override
  set selectedPackage(PackageModel value) {
    _$selectedPackageAtom.reportWrite(value, super.selectedPackage, () {
      super.selectedPackage = value;
    });
  }

  late final _$doctorDetailAtom =
      Atom(name: 'MedicalAppointmentStoreBase.doctorDetail', context: context);

  @override
  DoctorPagingItem? get doctorDetail {
    _$doctorDetailAtom.reportRead();
    return super.doctorDetail;
  }

  @override
  set doctorDetail(DoctorPagingItem? value) {
    _$doctorDetailAtom.reportWrite(value, super.doctorDetail, () {
      super.doctorDetail = value;
    });
  }

  late final _$getPackagesAsyncAction =
      AsyncAction('MedicalAppointmentStoreBase.getPackages', context: context);

  @override
  Future<void> getPackages() {
    return _$getPackagesAsyncAction.run(() => super.getPackages());
  }

  late final _$MedicalAppointmentStoreBaseActionController =
      ActionController(name: 'MedicalAppointmentStoreBase', context: context);

  @override
  void changeSearchDataAtHome(bool val) {
    final _$actionInfo =
        _$MedicalAppointmentStoreBaseActionController.startAction(
            name: 'MedicalAppointmentStoreBase.changeSearchDataAtHome');
    try {
      return super.changeSearchDataAtHome(val);
    } finally {
      _$MedicalAppointmentStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTestAtHome(bool val) {
    final _$actionInfo = _$MedicalAppointmentStoreBaseActionController
        .startAction(name: 'MedicalAppointmentStoreBase.setTestAtHome');
    try {
      return super.setTestAtHome(val);
    } finally {
      _$MedicalAppointmentStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setExamAtHome(bool val) {
    final _$actionInfo = _$MedicalAppointmentStoreBaseActionController
        .startAction(name: 'MedicalAppointmentStoreBase.setExamAtHome');
    try {
      return super.setExamAtHome(val);
    } finally {
      _$MedicalAppointmentStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setVisible(bool val) {
    final _$actionInfo = _$MedicalAppointmentStoreBaseActionController
        .startAction(name: 'MedicalAppointmentStoreBase.setVisible');
    try {
      return super.setVisible(val);
    } finally {
      _$MedicalAppointmentStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setcheckTimeVisitDoctor(bool val) {
    final _$actionInfo =
        _$MedicalAppointmentStoreBaseActionController.startAction(
            name: 'MedicalAppointmentStoreBase.setcheckTimeVisitDoctor');
    try {
      return super.setcheckTimeVisitDoctor(val);
    } finally {
      _$MedicalAppointmentStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCategoryGroupId(String categoryGroup) {
    final _$actionInfo = _$MedicalAppointmentStoreBaseActionController
        .startAction(name: 'MedicalAppointmentStoreBase.setCategoryGroupId');
    try {
      return super.setCategoryGroupId(categoryGroup);
    } finally {
      _$MedicalAppointmentStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addPackageToShowed(PackageModel data) {
    final _$actionInfo = _$MedicalAppointmentStoreBaseActionController
        .startAction(name: 'MedicalAppointmentStoreBase.addPackageToShowed');
    try {
      return super.addPackageToShowed(data);
    } finally {
      _$MedicalAppointmentStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removePackageToShow(PackageModel data) {
    final _$actionInfo = _$MedicalAppointmentStoreBaseActionController
        .startAction(name: 'MedicalAppointmentStoreBase.removePackageToShow');
    try {
      return super.removePackageToShow(data);
    } finally {
      _$MedicalAppointmentStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMedicaFacil(bool isMedicalFacility) {
    final _$actionInfo = _$MedicalAppointmentStoreBaseActionController
        .startAction(name: 'MedicalAppointmentStoreBase.setMedicaFacil');
    try {
      return super.setMedicaFacil(isMedicalFacility);
    } finally {
      _$MedicalAppointmentStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setConsultation(bool isConsultation) {
    final _$actionInfo = _$MedicalAppointmentStoreBaseActionController
        .startAction(name: 'MedicalAppointmentStoreBase.setConsultation');
    try {
      return super.setConsultation(isConsultation);
    } finally {
      _$MedicalAppointmentStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPackageDetail(PackageModel data) {
    final _$actionInfo = _$MedicalAppointmentStoreBaseActionController
        .startAction(name: 'MedicalAppointmentStoreBase.setPackageDetail');
    try {
      return super.setPackageDetail(data);
    } finally {
      _$MedicalAppointmentStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void chooseDoctor(DoctorPagingItem data) {
    final _$actionInfo = _$MedicalAppointmentStoreBaseActionController
        .startAction(name: 'MedicalAppointmentStoreBase.chooseDoctor');
    try {
      return super.chooseDoctor(data);
    } finally {
      _$MedicalAppointmentStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
consultation: ${consultation},
testAtHome: ${testAtHome},
visible: ${visible},
checkTimeVisitDoctor: ${checkTimeVisitDoctor},
examAtHome: ${examAtHome},
dataForAtHome: ${dataForAtHome},
selectedCategoryGroupId: ${selectedCategoryGroupId},
isMedicalFacil: ${isMedicalFacil},
packagesList: ${packagesList},
listPackageShowed: ${listPackageShowed},
searchObj: ${searchObj},
loadingPackage: ${loadingPackage},
errloadPackage: ${errloadPackage},
selectedPackage: ${selectedPackage},
doctorDetail: ${doctorDetail},
isGetSampleInPackage: ${isGetSampleInPackage}
    ''';
  }
}
