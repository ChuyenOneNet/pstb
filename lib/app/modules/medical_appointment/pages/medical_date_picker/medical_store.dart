import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:pstb/app/modules/home/home_store.dart';
import 'package:pstb/app/modules/medical_appointment/pages/medical_date_picker/widget/type_gender_widget.dart';
import 'package:pstb/app/models/schedule_time_visit_doctor.dart' as Schedule;
import 'package:pstb/app/models/user_info_model.dart';
import 'package:pstb/services/api_base_helper.dart';
import 'package:pstb/services/api_exception.dart';
import 'package:pstb/widgets/stateless/app_snack_bar.dart';
import 'package:mobx/mobx.dart';
import '../../../../../utils/api_url.dart';
import '../../../../../utils/constants.dart';
import '../../../../../utils/l10n.dart';
import '../../../../../utils/time_util.dart';
import '../../../../app_store.dart';
import 'model/TimeObject.dart';
import 'widget/type_personal_widget.dart';

part 'medical_store.g.dart';

class MedicalStore = MedicalStoreBase with _$MedicalStore;

const Duration timeDuration = Duration(days: 1);

abstract class MedicalStoreBase with Store {
  late BuildContext mContext;
  final ApiBaseHelper _apiBaseHelper = Modular.get<ApiBaseHelper>();
  final AppStore _appStore = Modular.get<AppStore>();
  final HomeStore _homeStore = Modular.get<HomeStore>();

  //! Observable
  @observable
  int listDayPickerLength = 7;
  @observable
  int listDaySampleLength = 7;

  @observable
  int idDayPicked = 0;

  @observable
  int idSampleDayPicked = 0;

  @observable
  int countDateFromTimeVisitDoctor = 0;

  @observable
  int countDateFromTimeGetSample = 0;

  @observable
  ObservableList<DateTime> listDayVisitDoctor = ObservableList.of([]);

  @observable
  ObservableList<DateTime> listDayGetSample = ObservableList.of([]);
  @observable
  GenderType genderType = GenderType.f;
  @observable
  PersonalType? personalType = PersonalType.personal;
  @observable
  String namePersonal = '';
  @observable
  String insuranceNumber = '';
  @observable
  String personalId = '';
  @observable
  String phoneNumber = '';
  @observable
  String dob = '';

  @action
  void setDateFromTimeVisitDoctor(int days) =>
      countDateFromTimeVisitDoctor = days;

  @action
  void setGenderType(GenderType? gender) {
    genderType = gender ?? GenderType.f;
  }

  @action
  void setPersonalType(PersonalType? personal) {
    personalType = personal ?? PersonalType.personal;
  }

  // @action
  // void setDateTime (String dateTime){
  //   dobController.text = text.split(" ")[0];
  // }
  @computed
  int get getDateFromTimeVisitDoctor =>
      countDateFromTimeVisitDoctor + idDayPicked;

  @action
  void setDateFromTimeGetSample(int days) => countDateFromTimeGetSample = days;

  @computed
  int get getDateFromTimeGetSample =>
      countDateFromTimeGetSample + idSampleDayPicked;

  void initFirstTimeVisit() {
    listDayVisitDoctor.clear();
    listDayPickerLength = 7;
    idDayPicked = 0;
    listTimeVisit.clear();
    addDayVisitDoctor();
  }

  void initFirstTimeGetSample() {
    listDayGetSample.clear();
    listDaySampleLength = 7;
    idSampleDayPicked = 0;
    listTimeGetSample.clear();
    addDayGetSample();
  }

  @action
  void initGetSampleData(int days, DateTime? getSampleDate) {
    //Set về ban đầu
    // idTimeGetSample = 0;
    idSampleDayPicked = 0;
    listDaySampleLength = 7;
    listTimeGetSample.clear();
    listDayGetSample.clear();
    firstResultTest.clear();
    // setDateFromTimeGetSample(days);
    //Tạo danh sách ngày lấy mẫu từ ngày cố định
    createListDayGetSample(days);

    //Tạo danh sách giờ khám ban đầu
    if (listTimeGetSample.isNotEmpty) {
      listTimeGetSample.clear();
    }

    List<TimeObject> list = TimeUtil.createListTimeObject(
        int.parse(_homeStore.timeStart.split(':')[0]),
        int.parse(_homeStore.timeEnd.split(':')[0]),
        _homeStore.timeStart.split(':')[1],
        _homeStore.timeEnd.split(':')[1],
        days);
    for (var item in list) {
      listTimeGetSample.add(item);
    }

    DateTime dateGetSample = getSampleDate ?? DateTime.now();

    for (var item in listTimeGetSample) {
      if (!dateGetSample.isAfter(item.date) &&
          !dateGetSample.isAtSameMomentAs(item.date)) {
        firstResultTest.add(item);
      }
    }
  }

  @action
  void createListDayGetSample(int fromDay) {
    int count = 0;
    while (count < 14) {
      listDayGetSample.add(
        DateTimeFormatPattern.startOfDay(
          DateTime.now().add(Duration(days: fromDay + count)),
        ),
      );
      count++;
    }
  }

  // @computed
  @action
  void addDayVisitDoctor() {
    if (listDayVisitDoctor.length == 12) return;
    int count = 1;
    while (count < 7) {
      listDayVisitDoctor.add(
        DateTimeFormatPattern.startOfDay(
          DateTime.now().add(Duration(
              days: getDateFromTimeVisitDoctor + listDayVisitDoctor.length)),
        ),
      );
      count++;
    }
  }

  @action
  void addDayGetSample() {
    if (listDayVisitDoctor.length == 12) return;
    int count = 1;
    while (count < 7) {
      listDayGetSample.add(
        DateTimeFormatPattern.startOfDay(
          DateTime.now().add(Duration(days: listDayGetSample.length)),
        ),
      );
      count++;
    }
  }

  @computed
  DateTime get getDayPicked {
    // print(listDayVisitDoctor[idDayPicked]);
    return listDayVisitDoctor[idDayPicked];
  }

  @computed
  DateTime get getSampleDayPicked {
    return listDayGetSample[idSampleDayPicked];
  }

  //TODO time visit
  @observable
  ObservableList<TimeObject> listTimeVisit = ObservableList<TimeObject>.of([]);

  //TODO time visit
  @observable
  ObservableList<TimeObject> listTimeGetSample =
      ObservableList<TimeObject>.of([]);

  @observable
  ObservableList<TimeObject> firstListTimeVisit =
      ObservableList<TimeObject>.of([]);

  @observable
  ObservableList<TimeObject> firstResultTest =
      ObservableList<TimeObject>.of([]);

  @observable
  int? idTimeVisit;

  @observable
  int? idTimeGetSample;

  @action
  void setBaseTimeVisit() {
    if (listTimeVisit.isNotEmpty) {
      listTimeVisit.clear();
    }
    List<TimeObject> list = TimeUtil.createListTimeObject(
        int.parse(_homeStore.timeStart.split(':')[0]),
        int.parse(_homeStore.timeEnd.split(':')[0]),
        _homeStore.timeStart.split(':')[1],
        _homeStore.timeEnd.split(':')[1],
        getDateFromTimeVisitDoctor);
    for (var item in list) {
      listTimeVisit.add(item);
    }
  }

  @action
  void setBaseTimeGetSample(int fromDays) {
    if (listTimeGetSample.isNotEmpty) {
      listTimeGetSample.clear();
    }

    List<TimeObject> list = TimeUtil.createListTimeObject(
        int.parse(_homeStore.timeStart.split(':')[0]),
        int.parse(_homeStore.timeEnd.split(':')[0]),
        _homeStore.timeStart.split(':')[1],
        _homeStore.timeEnd.split(':')[1],
        fromDays);
    for (var item in list) {
      listTimeGetSample.add(item);
    }
  }

  @computed
  DateTime? get getTimeSeeDoctor {
    if (idTimeVisit == null) {
      return null;
    }
    return listTimeVisit[idTimeVisit!].date;
  }

  @computed
  DateTime? get getTimeGetResult {
    if (idTimeGetSample == null) {
      return null;
    }
    var date =
        "${getSampleDayPicked.toString().split(' ')[0]} ${(listTimeGetSample[idTimeGetSample!].date.toString()).split(' ')[1]}";
    return DateFormat("yyyy-MM-dd hh:mm:ss").parse(date);
  }

  @observable
  UserAddress? aLocationPicked;
  @observable
  var listHome = ObservableList<UserAddress>.of([]);
  @observable
  var listCompany = ObservableList<UserAddress>.of([]);

  @action
  void changeListHomeCompany(List<UserAddress> value) {
    listHome = ObservableList<UserAddress>.of([]);
    listCompany = ObservableList<UserAddress>.of([]);
    if (value.isNotEmpty) {
      for (var el in value) {
        if (el.type == "home") {
          listHome.add(el);
        }
        if (el.type == "company") {
          listCompany.add(el);
        }
      }
    }
  }

  //! Action
  @action
  Future<bool> onLoadMore() async {
    addDayVisitDoctor();
    return true;
  }

  @action
  void onListDayPickerLength(int value) {
    listDayPickerLength = value;
  }

  @action
  void onChangeIdDayPicked(int value) {
    idDayPicked = value;
    // setDateFromTimeVisitDoctor(getDateFromTimeVisitDoctor + 1 + value);
    setBaseTimeVisit();
    // onChangeListTimeGetResultTest();
  }

  @action
  void onChangeIdGetSample(int value) {
    idSampleDayPicked = value;
    int days = (listDayGetSample[idSampleDayPicked].month * 30 +
            listDayGetSample[idSampleDayPicked].day) -
        (DateTime.now().month * 30 + DateTime.now().day);
    // setDateFromTimeVisitDoctor(getDateFromTimeVisitDoctor + 1 + value);
    // setBaseTimeVisit();
    setBaseTimeGetSample(days);
  }

  @action
  onChangeListTimeVisit(List<TimeObject> list) {
    if (idDayPicked == 0) {
      listTimeVisit = firstListTimeVisit;
    } else {
      for (var item in list) {
        listTimeVisit.add(item);
      }
    }
  }

  @action
  void onChangeIdTimeVisit(int? value) {
    idTimeVisit = value;
  }

  @action
  void onChangeIdTimeGetResultTest(int? value) {
    idTimeGetSample = value;
  }

  @action
  void onChangeLocation(UserAddress value) {
    aLocationPicked = value;
  }

  //! Computed

  ///* list time visit AM and PM
  @computed
  List<TimeObject> get listTimeVisitAM {
    DateTime at12 =
        DateTime(getDayPicked.year, getDayPicked.month, getDayPicked.day, 12);
    List<TimeObject> listAM = [];
    List<TimeObject> listAll =
        idDayPicked == 0 ? firstListTimeVisit : listTimeVisit;
    for (var el in listAll) {
      {
        // print(el.date.isBefore(at12));
        if (el.date.isBefore(at12)) {
          // print(el.date);
          listAM.add(el);
        }
      }
    }
    return listAM;
  }

  @computed
  List<TimeObject> get listTimeVisitPM {
    DateTime at12 =
        DateTime(getDayPicked.year, getDayPicked.month, getDayPicked.day, 12);
    List<TimeObject> listPM = [];
    List<TimeObject> listAll =
        idDayPicked == 0 ? firstListTimeVisit : listTimeVisit;
    for (var el in listAll) {
      {
        if (el.date.isAfter(at12) || el.date.isAtSameMomentAs(at12)) {
          listPM.add(el);
        }
      }
    }
    return listPM;
  }

  ///* list TimeGetResultTest AM and PM
  @computed
  List<TimeObject> get listTimeGetResultTestAM {
    DateTime at12 = DateTime(getSampleDayPicked.year, getSampleDayPicked.month,
        getSampleDayPicked.day, 12);
    List<TimeObject> listAM = [];
    List<TimeObject> listAll =
        idSampleDayPicked == 0 ? firstResultTest : listTimeGetSample;

    for (var el in listAll) {
      {
        // print(el.date.isBefore(at12));
        if (el.date.isBefore(at12)) {
          // print(el.date);
          listAM.add(el);
        }
      }
    }
    return listAM;
  }

  @computed
  List<TimeObject> get listTimeGetResultTestPM {
    DateTime at12 = DateTime(getSampleDayPicked.year, getSampleDayPicked.month,
        getSampleDayPicked.day, 12);
    List<TimeObject> listPM = [];
    List<TimeObject> listAll =
        idSampleDayPicked == 0 ? firstResultTest : listTimeGetSample;
    for (var el in listAll) {
      {
        if (el.date.isAfter(at12) || el.date.isAtSameMomentAs(at12)) {
          listPM.add(el);
        }
      }
    }
    return listPM;
  }

  // API
  @observable
  Schedule.ScheduleTimeVisitDoctor? resScheduleDoctor;

  @action
  Future<void> updateBooking(int bookingId) async {
    EasyLoading.show();
    try {
      final response = await _apiBaseHelper.patch(
          ApiUrl.appointment,
          jsonEncode({
            "timeSeeDoctor": getTimeSeeDoctor == null
                ? ""
                : DateFormat(DateTimeFormatPattern.backendTimeFormat)
                    .format(getTimeSeeDoctor!),
            "timeGetSample": getTimeGetResult == null
                ? ""
                : DateFormat(DateTimeFormatPattern.backendTimeFormat)
                    .format(getTimeGetResult!),
            "id": bookingId,
            // "id": bookingId,
          }));
      AppSnackBar.show(
          mContext, AppSnackBarType.Success, l10n(mContext)!.update_success);
      EasyLoading.dismiss();
      Modular.to.pop();
      Modular.to.pop();
      Modular.to.pop();
      return;
    } catch (e) {
      AppSnackBar.show(
          mContext, AppSnackBarType.Error, l10n(mContext)!.wrong_when_try);
    }
    // finally {
    //   // AppSnackBar.show(
    //   //     mContext, AppSnackBarType.Success, l10n(mContext)!.update_success);
    //   EasyLoading.dismiss();
    // }
  }

  @action
  Future<void> updateTimeVisit(int bookingId, DateTime pickedTime) async {
    EasyLoading.show();
    try {
      final response = await _apiBaseHelper.patch(
        ApiUrl.appointment,
        jsonEncode(
          {
            "timeSeeDoctor": getTimeSeeDoctor == null
                ? ""
                : DateFormat(DateTimeFormatPattern.backendTimeFormat)
                    .format(pickedTime),
            "timeGetSample": getTimeGetResult == null
                ? ""
                : DateFormat(DateTimeFormatPattern.backendTimeFormat)
                    .format(pickedTime),
            "id": bookingId,
          },
        ),
      );
      AppSnackBar.show(
          mContext, AppSnackBarType.Success, l10n(mContext)!.update_success);
      EasyLoading.dismiss();
      Modular.to.pop();
      Modular.to.pop();
    } catch (e) {
      AppSnackBar.show(
          mContext, AppSnackBarType.Error, l10n(mContext)!.wrong_when_try);
    }
    // finally {
    //   // AppSnackBar.show(
    //   //     mContext, AppSnackBarType.Success, l10n(mContext)!.update_success);
    //   EasyLoading.dismiss();
    // }
    EasyLoading.dismiss();
  }

  @action
  Future<void> getUserInfo() async {
    try {
      final response = await _apiBaseHelper.get(ApiUrl.getAccountInfo);
      final userInfo = UserInfoModel.fromJson(response);
      changeListHomeCompany(userInfo.userAddress!);
      onChangeLocation(userInfo.userAddress![0]);
    } on AppException catch (e) {
      AppSnackBar.show(mContext, AppSnackBarType.Error, e.toString());
    } on Exception catch (e) {
      AppSnackBar.show(mContext, AppSnackBarType.Error, e.toString());
    }
  }

  @action
  void changeBuildContext(BuildContext value) {
    mContext = value;
  }

  @action
  void resetState() {
    idTimeVisit = null;
    idTimeGetSample = null;
  }
}
