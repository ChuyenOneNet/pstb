import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:pstb/app/models/doctor_appointment/appointment_model.dart';
import 'package:pstb/app/models/paging_model.dart';
import 'package:pstb/services/api_base_helper.dart';
import 'package:pstb/services/api_exception.dart';
import 'package:pstb/utils/api_url.dart';
import 'package:pstb/utils/constants.dart';
import 'package:pstb/utils/time_util.dart';
import 'package:pstb/widgets/stateless/app_snack_bar.dart';
import 'package:mobx/mobx.dart';

part 'doctor_appointment_store.g.dart';

class DoctorAppointmentStore = _DoctorAppointmentStoreBase
    with _$DoctorAppointmentStore;

abstract class _DoctorAppointmentStoreBase with Store {
  @observable
  ObservableList<AppointmentModel> listAppointment =
      ObservableList<AppointmentModel>.of([]);

  @observable
  ObservableList<AppointmentModel> listAppointmentEvent =
      ObservableList<AppointmentModel>.of([]);

  @observable
  Map<String, List> mySelectedEvents = {};

  @observable
  bool isDataList = true;

  @observable
  int pageIndex = 0;

  @observable
  String status = '';

  @action
  onChangeStatus(String value) {
    status = value;
  }

  @action
  Future<void> getAllAppointment({String? fromDate, String? toDate}) async {
    EasyLoading.show();
    try {
      final response = await ApiBaseHelper().get(
        ApiUrl.appointmentDoctor,
        {
          'FromDate': fromDate,
          'ToDate': toDate,
          "pageIndex": 0,
          "pageSize": 10
        },
      );
      final paging = Paging<AppointmentModel>.fromJson(
          response, (e) => AppointmentModel.fromJson(e));
      if (paging.items != null && paging.items!.isNotEmpty) {
        listAppointment.clear();
        mySelectedEvents.clear();
        listAppointment.addAll(paging.items!.map((e) => e));
        listAppointment
          ..removeWhere((element) => element.timeSeeDoctor == null)
          ..sort((a, b) => DateTime.parse(b.timeSeeDoctor.toString())
              .compareTo(DateTime.parse(a.timeSeeDoctor.toString())));
      } else {
        listAppointment.clear();
        listAppointment.addAll(_fakeAppointments());
      }
    } on AppException catch (e) {
      listAppointment.clear();
      listAppointment.addAll(_fakeAppointments());
      Fluttertoast.showToast(msg: e.getMessage());
      EasyLoading.dismiss();
    } catch (e) {
      print(e);
      EasyLoading.dismiss();
    }
    EasyLoading.dismiss();
  }

  List<AppointmentModel> _fakeAppointments() {
    return [
      AppointmentModel(
        id: 1,
        packageName: "Khám tổng quát",
        doctorName: "Nguyễn Văn Sơn",
        address: "Bệnh viện pstb",
        timeSeeDoctor: DateTime.now().add(const Duration(days: 1)),
      ),
      AppointmentModel(
        id: 2,
        packageName: "Khám tim mạch",
        doctorName: "Trần Thị Mai",
        address: "Phòng khám ABC",
        timeSeeDoctor: DateTime.now().add(const Duration(days: 2)),
      ),
    ];
  }

  @action
  Future<void> getAllAppointmentEvent(String? fromDate, String? toDate) async {
    // EasyLoading.show();
    try {
      final response = await ApiBaseHelper().get(
        ApiUrl.appointmentDoctor,
        {
          'fromDate': fromDate,
          'toDate': toDate,
          "pageIndex": 0,
          "pageSize": 10000
        },
      );
      final paging = Paging<AppointmentModel>.fromJson(
          response, (e) => AppointmentModel.fromJson(e));
      if (paging.items != null) {
        listAppointmentEvent.clear();
        mySelectedEvents.clear();
        listAppointmentEvent.addAll(paging.items!.map((e) => e));
        listAppointmentEvent
          ..forEach((element) {})
          ..removeWhere((element) => element.timeSeeDoctor == null)
          ..sort((a, b) => DateTime.parse(b.timeSeeDoctor.toString())
              .compareTo(DateTime.parse(a.timeSeeDoctor.toString())));
      }
    } on AppException catch (e) {
      Fluttertoast.showToast(msg: e.getMessage());
      // EasyLoading.dismiss();
    } catch (e) {
      print(e);
      // EasyLoading.dismiss();
    }
    // EasyLoading.dismiss();
  }

  @action
  Future<void> loadMoreAppointment() async {
    pageIndex++;
    try {
      final response = await ApiBaseHelper().get(
          ApiUrl.appointmentDoctor, {"pageIndex": pageIndex, "pageSize": 10});
      final paging = Paging<AppointmentModel>.fromJson(
          response, (e) => AppointmentModel.fromJson(e));
      if (paging.items != null) {
        listAppointment.addAll(paging.items!.map((e) => e));
        listAppointment
          ..forEach((element) {})
          ..removeWhere((element) => element.timeSeeDoctor == null)
          ..sort((a, b) => DateTime.parse(b.timeSeeDoctor.toString())
              .compareTo(DateTime.parse(a.timeSeeDoctor.toString())));
      }
    } on AppException catch (e) {
      Fluttertoast.showToast(msg: e.getMessage());
      EasyLoading.dismiss();
    } catch (e) {
      print(e);
      EasyLoading.dismiss();
    }
    EasyLoading.dismiss();
  }
}
