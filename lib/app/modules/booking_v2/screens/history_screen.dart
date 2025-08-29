import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../utils/colors.dart';
import '../sqlite_dao/request_history_dao.dart';
import '../model/request_history.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart';

class RequestHistoryScreen extends StatelessWidget {
  final String userPhone;

  const RequestHistoryScreen({Key? key, required this.userPhone})
      : super(key: key);

  Future<List<RequestHistory>> _loadHistories() async {
    final dao = GetIt.I<RequestHistoryDao>();
    return dao.getHistoryByUser(userPhone);
  }

  Future<void> _openPdf(BuildContext context, String imgBase64) async {
    try {
      // final bytes = base64Decode(imgBase64); // decode base64 ra bytes
      // final tempDir = await getTemporaryDirectory();
      // final localPath =
      //     '${tempDir.path}/temp_${DateTime.now().millisecondsSinceEpoch}.png';
      // await File(localPath).writeAsBytes(bytes); // lưu tạm file

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => Base64ImageView(base64String: imgBase64),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Không thể mở ảnh')),
      );
    }
  }

  Widget _buildHistoryItem(BuildContext context, RequestHistory h) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    h.patientName,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary),
                  ),
                ),
                InkWell(
                  onTap: () => _openPdf(context, h.pdfPath ?? ''),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.2),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                      border:
                          Border.all(color: AppColors.primary.withOpacity(0.4)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.visibility, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          'Xem phiếu khám',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            _buildInfoRow(Icons.phone, "SĐT", h.userPhone),
            _buildInfoRow(
                Icons.medical_services, "Loại khám", h.examTypeName ?? '—'),
            _buildInfoRow(Icons.meeting_room, "Phòng", h.roomName ?? '—'),
            _buildInfoRow(Icons.calendar_today, "Ngày hẹn khám",
                formatNgayKham(h.createdAt) ?? '—'),
          ],
        ),
      ),
    );
  }

  String formatNgayKham(String ngayKham) {
    try {
      // parse string datetime
      DateTime dateTime = DateTime.parse(ngayKham);

      // format về hh:mm dd/MM/yyyy
      String formatted = DateFormat('HH:mm dd/MM/yyyy').format(dateTime);
      return formatted;
    } catch (e) {
      return ngayKham; // nếu lỗi thì trả lại string gốc
    }
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey[600]),
          const SizedBox(width: 6),
          Text(
            "$label: ",
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(color: Colors.black87)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Lịch sử yêu cầu",
            style: TextStyle(color: Colors.white)),
      ),
      body: FutureBuilder<List<RequestHistory>>(
        future: _loadHistories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Lỗi: ${snapshot.error}"));
          }
          final histories = snapshot.data ?? [];
          if (histories.isEmpty) {
            return const Center(child: Text("Không có dữ liệu"));
          }
          return ListView.builder(
            itemCount: histories.length,
            itemBuilder: (context, index) {
              return _buildHistoryItem(context, histories[index]);
            },
          );
        },
      ),
    );
  }
}

class Base64ImageView extends StatelessWidget {
  final String base64String;

  const Base64ImageView({Key? key, required this.base64String})
      : super(key: key);

  Future<void> _saveImage(BuildContext context) async {
    PermissionStatus status;

    // Android 13+ cần READ_MEDIA_IMAGES
    if (Platform.isAndroid) {
      status = await Permission.photos.request();
    } else {
      status = await Permission.storage.request();
    }

    if (!status.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Không có quyền lưu ảnh")),
      );
      return;
    }

    Uint8List bytes = base64Decode(base64String);

    final result = await ImageGallerySaver.saveImage(bytes,
        quality: 100, name: "saved_image");

    if (result['isSuccess'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Ảnh đã được lưu vào thư viện")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Lưu ảnh thất bại")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Uint8List bytes = base64Decode(base64String);

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.chevron_left,
            size: 36,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        title: const Text(
          "View Image",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.download,
              color: Colors.white,
            ),
            onPressed: () => _saveImage(context),
          ),
        ],
      ),
      body: Center(
        child: Image.memory(
          bytes,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
