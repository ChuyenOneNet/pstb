import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:pstb/services/api_exception.dart';
import 'package:mobx/mobx.dart';
import 'package:pstb/app/models/examination_results_model.dart';
//import 'package:pstb/app/modules/electronic_medical_records/models/prescription.dart';
import 'package:pstb/app/modules/schedule/schedule_store.dart';
import 'package:pstb/app/models/booking_detail_model.dart' as booking_detail;
import 'package:pstb/app/models/medical_records_detail_model.dart'
    as m_r_detail;
import 'package:pstb/app/models/new_prescription_model.dart';
import 'package:pstb/services/api_base_helper.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/app_snack_bar.dart';
import '../medical_appointment/pages/confirm_and_payment/models/booking_info.dart';
import '../../models/bottom_sheet_models.dart';
part 'schedule_detail_store.g.dart';

class ScheduleDetailStore = _ScheduleDetailStoreBase with _$ScheduleDetailStore;

abstract class _ScheduleDetailStoreBase with Store {
  final ApiBaseHelper _apiBaseHelper = ApiBaseHelper();
  final ScheduleStore _scheduleStore = Modular.get<ScheduleStore>();

  late final dynamic completed;
  late BuildContext mContext;
  late dynamic data;

  @observable
  String idBooking = "";

  @observable
  BookingInfo bookingInfo = BookingInfo(
    doctorId: 1,
    packageName: 'Gói khám sức khoẻ cơ bản',
    doctorName: 'Bs. Nguyễn Văn Toàn',
    timeSeeDoctor: DateTime.now(),
    address: 'Tầng 6 số 22 Thành Công, Ba Đì...',
    timeGetSample: DateTime.now(),
    idCost: "300000.00",
    cost: 300000,
    discount: 20000,
    packageId: 1,
  );

  @action
  void changeBuildContext(BuildContext newContext) {
    mContext = newContext;
  }

  @action
  void onChangePaymentInfo(BookingInfo value) {
    bookingInfo = value;
  }

  @computed
  List<BottomSheetOptionModel> get option {
    return [
      BottomSheetOptionModel(
        type: OptionType.title,
        label: 'Lịch hẹn khám',
        id: 1,
      ),
      // BottomSheetOptionModel(
      //   type: OptionType.option,
      //   label: l10n(context)!.schedule_detail_bottomsheet_edit_sample_address!,
      //   id: 2,
      // ),
      BottomSheetOptionModel(
        type: OptionType.option,
        label: l10n(mContext)!.schedule_detail_bottomsheet_edit_delay!,
        id: 3,
      ),
      BottomSheetOptionModel(
        type: OptionType.cancel,
        label: l10n(mContext)!.schedule_detail_bottomsheet_cancel!,
        id: 4,
      ),
    ];
  }

  // @observable
  // Prescription prescription = Prescription(
  //     dayOfTheExamination: DateTime.now(),
  //     doctorName: '',
  //     prescriptionList: [],
  //     prescriptionName: '',
  //     ui: 1);
  @observable
  bool loading = true;

  @observable
  NewPrescriptionModel prescriptionDetail = NewPrescriptionModel();

  @computed
  List<DonThuoc>? get prescriptionDetailList =>
      prescriptionDetail.data!.donThuoc ?? [];

  @observable
  booking_detail.Booking? bookingDetail = booking_detail.Booking();

  @observable
  m_r_detail.Data resultExam = m_r_detail.Data();

  @computed
  List<ExaminationResults> get resultExamList => resultExam.ketQuaCls ?? [];

  @computed
  String? get title => bookingDetail!.packageName;

  @computed
  String get doctor {
    return bookingDetail!.doctorName ?? "";
  }

  @computed
  String get scheduleExamTime {
    String examStartTime = '';
    if (bookingDetail!.timeSeeDoctor != null) {
      examStartTime = DateFormat(DateTimeFormatPattern.hh_mm_NGAY_dd_MM)
          .format(bookingDetail!.timeSeeDoctor!.toLocal());
    }
    return examStartTime;
  }

  @computed
  String get scheduleExamTimeDate {
    String examStartTime = '';
    if (bookingDetail!.timeSeeDoctor != null) {
      examStartTime = DateFormat(DateTimeFormatPattern.formatddMMyyyy)
          .format(bookingDetail!.timeSeeDoctor!.toLocal());
    }
    return examStartTime;
  }

  @computed
  String get scheduleExamTimeHour {
    String examStartTime = '';
    if (bookingDetail!.timeSeeDoctor != null) {
      examStartTime = DateFormat(DateTimeFormatPattern.formatHHmm)
          .format(bookingDetail!.timeSeeDoctor!.toLocal());
    }
    return examStartTime;
  }

  @computed
  String get scheduleSampleTime {
    /// TODO: [Chưa có ngày giờ lấy mẫu]
    String examStartTime = '';
    // if (bookingDetail!.startTestTime != null) {
    //   examStartTime = DateFormat(DateTimeFormatPattern.hh_mm_NGAY_dd_MM)
    //       .format(bookingDetail!.startTestTime);
    // }
    return examStartTime;
  }

  @computed
  String get diagnose => resultExam.hoSoKhamBenh!.first.chanDoan ?? "";

  @computed
  String get examTime {
    String examStartTime = '';
    if (resultExam.hoSoKhamBenh!.isNotEmpty &&
        resultExam.hoSoKhamBenh!.first.ngayVaoKham != null) {
      examStartTime = DateFormat(DateTimeFormatPattern.hh_mm_NGAY_dd_MM)
          .format(resultExam.hoSoKhamBenh!.first.ngayVaoKham!.toLocal());
    }
    return examStartTime;
  }

  @computed
  String get resultTime {
    String examStartTime = '';
    if (prescriptionDetail.data!.hoSoKhamBenh!.isNotEmpty &&
        prescriptionDetail.data!.hoSoKhamBenh!.first.ngayVaoKham != null) {
      examStartTime = DateFormat(DateTimeFormatPattern.hh_mm_NGAY_dd_MM)
          .format(prescriptionDetail.data!.hoSoKhamBenh!.first.ngayVaoKham!);
    }
    return examStartTime;
  }

  @computed
  String get prescriptionPresciptionStatus =>
      prescriptionDetail.data!.donThuoc![0].trangThai ?? "";

  @computed
  String get prescriptionDoctor =>
      prescriptionDetail.data!.donThuoc!.first.tenBacSy ?? "";

  @computed
  String get profileCode =>
      prescriptionDetail.data!.hoSoKhamBenh![0].maHoSo ?? "";

  @action
  Future<void> deleteSchedule(int? id) async {
    EasyLoading.show();
    try {
      await _apiBaseHelper.delete("${ApiUrl.appointment}$id", null);
      _scheduleStore.onCancel(id!);
      AppSnackBar.show(
        mContext,
        AppSnackBarType.Success,
        "Huỷ lịch hẹn thành công",
      );
      Modular.to.pop();
    } on AppException catch (e) {
      AppSnackBar.show(
        mContext,
        AppSnackBarType.Error,
        e.toString(),
      );
    } catch (e) {
      AppSnackBar.show(
        mContext,
        AppSnackBarType.Error,
        l10n(mContext)!.wrong_when_try!,
      );
    } finally {
      EasyLoading.dismiss();
    }
  }

  @action
  Future<void> getPrescriptionDetail(
    dynamic _maHoSo,
    dynamic _id,
    bool isCompleted,
  ) async {
    loading = true;

    /// [Thông tin gói khám]
    try {
      final responseBooking =
          await _apiBaseHelper.get('${ApiUrl.appointment}$_id');
      bookingDetail = booking_detail.Booking.fromJson(responseBooking);
      bookingDetail!.id = _id;
    } catch (e) {
      AppSnackBar.show(
        mContext,
        AppSnackBarType.Error,
        l10n(mContext)!.wrong_when_try!,
      );
    }
    loading = false;
  }
}
