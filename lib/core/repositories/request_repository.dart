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
    if (response.data != null) {
      // if (response.data?.pathPdf != null) {
      //   final bytes = base64Decode(response.data?.pathPdf ?? "");
      //   final dir = await getApplicationDocumentsDirectory();
      //   final pdfPath = '${dir.path}/${response.data?.cccd}.pdf';
      //   await File(pdfPath).writeAsBytes(bytes);
      // }
      print(response.data?.pathPdf ?? "");
      final history =
          // RequestHistory(
          //   requestId: "REQ123456",
          //   patientName: "Nguyễn Văn A",
          //   examTypeName: "Khám tổng quát",
          //   roomName: "Phòng 101",
          //   createdAt: "2025-08-12 10:30",
          //   pdfPath: "/fake/path/REQ123456.pdf",
          //   userPhone: userPhone,
          // );
          RequestHistory(
        requestId: "",
        patientName: model.name,
        examTypeName: model.examTypeName ?? "",
        roomName: model.clinicRoomName ?? "",
        createdAt: model.scheduledAt,
        pdfPath: response.data?.pathPdf ?? "",
        userPhone: userPhone,
      );
      await dao.insertHistory(history);
      // Lưu SQLite
    }
    //Lưu PDF local
  }

  Future<List<RequestHistory>> getHistory(String userPhone) {
    return dao.getHistoryByUser(userPhone);
  }
}
