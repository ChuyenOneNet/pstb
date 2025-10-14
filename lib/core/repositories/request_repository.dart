import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../../app/modules/booking_v2/model/create_request_model.dart';
import '../../app/modules/booking_v2/model/request_history.dart';
import '../../app/modules/booking_v2/sqlite_dao/request_history_dao.dart';
import '../services/booking_service.dart';

class RequestRepository {
  final BookingService apiService;
  final RequestHistoryDao dao;

  RequestRepository(this.apiService, this.dao);

  Future<void> createRequest(CreateRequestModel model, String userPhone) async {
    final response = await apiService.createRequest(model);
    if (response != null) {
      if (response.pathPdf != null) {
        final bytes = base64Decode(response.pathPdf ?? "");
        final dir = await getApplicationDocumentsDirectory();
        final pdfPath = '${dir.path}/${response.cccd}.pdf';
        await File(pdfPath).writeAsBytes(bytes);
      }

      final history = RequestHistory(
        requestId: "",
        userPhone: userPhone,
        patientName: model.name,
        cccd: model.cccd,
        age: model.age,
        gender: model.gender,
        birthDate: model.birthDate,
        jobName: model.jobName ?? "",
        job: model.job,
        addressDetail: model.addressDetail,
        phone: model.phone,
        fatherName: model.fatherName,
        motherName: model.motherName,
        idIssueDate: model.idIssueDate,
        idIssuePlace: model.idIssuePlace,
        nationalId: model.nationalId,
        ethnic: model.ethnic,
        provinceId: model.provinceId,
        communeWardId: model.communeWardId,
        nationalName: model.nationalName ?? "",
        ethnicName: model.ethnicName ?? "",
        communeWardName: model.communeWardName ?? "",
        provinceName: model.provinceName ?? "",
        examTypeId: model.examTypeId,
        examTypeName: model.examTypeName ?? "",
        clinicRoomCode: model.clinicRoomCode,
        roomName: model.clinicRoomName ?? "",
        reason: model.reason,
        priority: model.priority,
        arrivalMethod: model.arrivalMethod,
        createdAt: model.scheduledAt,
        pdfPath: response.pathPdf ?? "",
        hasInsurance: model.hasInsurance,
        price: model.price ?? "",
      );

      await dao.insertHistory(history);
    }
  }

  Future<List<RequestHistory>> getHistory(String userPhone) {
    return dao.getHistoryByUser(userPhone);
  }
}
