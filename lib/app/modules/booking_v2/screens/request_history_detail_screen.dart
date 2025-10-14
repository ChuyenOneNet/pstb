import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../model/request_history.dart';
import '../../../../utils/colors.dart';

class RequestHistoryDetailScreen extends StatelessWidget {
  final RequestHistory history;

  RequestHistoryDetailScreen({Key? key, required this.history})
      : super(key: key);

  String _formatDate(String? date) {
    if (date == null || date.isEmpty) return '—';
    try {
      final d = DateTime.parse(date);
      return DateFormat('HH:mm dd/MM/yyyy').format(d);
    } catch (_) {
      return date;
    }
  }

  final f = NumberFormat('#,###', 'vi_VN');
  Widget _buildInfoRow(String label, String? value, {IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null)
            Icon(icon, size: 20, color: AppColors.primary.withOpacity(0.8)),
          if (icon != null) const SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                text: "$label: ",
                style: const TextStyle(
                    fontWeight: FontWeight.w600, color: Colors.black87),
                children: [
                  TextSpan(
                    text: value?.isNotEmpty == true ? value : "—",
                    style: const TextStyle(
                        fontWeight: FontWeight.normal, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, IconData icon, List<Widget> children) {
    return Card(
      color: Colors.white,
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: AppColors.primary),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(height: 20),
            ...children,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final genderText = history.gender == 1
        ? 'Nam'
        : history.gender == 0
            ? 'Nữ'
            : 'Không xác định';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết yêu cầu',
            style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 🔹 Thông tin cá nhân
            _buildSection("Thông tin bệnh nhân", Icons.person, [
              _buildInfoRow("Tên bệnh nhân", history.patientName),
              _buildInfoRow("CCCD", history.cccd),
              _buildInfoRow("Ngày sinh", history.birthDate),
              _buildInfoRow("Giới tính", genderText),
              _buildInfoRow("Nghề nghiệp", history.jobName),
              _buildInfoRow("Thành phố", history.provinceName),
              _buildInfoRow("Xã/phường", history.communeWardName),
              _buildInfoRow("Địa chỉ", history.addressDetail),
              _buildInfoRow("SĐT", history.phone),
              _buildInfoRow("Quốc tịch", history.nationalName),
              _buildInfoRow("Dân tộc", history.ethnicName),
              _buildInfoRow("Bảo hiểm", history.hasInsurance ? "Có" : "Không"),
            ]),

            // 🔹 Thông tin khám
            _buildSection("Thông tin khám", Icons.local_hospital, [
              _buildInfoRow("Loại khám", history.examTypeName),
              _buildInfoRow(
                  "Giá tiền",
                  history.price != null
                      ? "${f.format(int.tryParse(history.price!))} đ"
                      : "- đ"),
              _buildInfoRow("Phòng khám", history.roomName),
              _buildInfoRow("Lý do khám", history.reason),
              _buildInfoRow("Độ ưu tiên", history.priority),
              _buildInfoRow("Phương thức đến", history.arrivalMethod),
              _buildInfoRow("Ngày hẹn", _formatDate(history.createdAt)),
            ]),

            const SizedBox(height: 10),

            // 🔹 Nút xem phiếu khám
            //if (history.pdfPath.isNotEmpty) ...[
            Text(
              "Mã QR phiếu khám",
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),

            // 🟦 QR Code hiển thị
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(20),
              child: Center(
                child: QrImageView(
                  data: "",
                  //history.pdfPath, // có thể là URL hoặc base64
                  version: QrVersions.auto,
                  size: 110.0,
                  backgroundColor: Colors.white,
                  eyeStyle: QrEyeStyle(
                    eyeShape: QrEyeShape.square,
                    color: AppColors.primary,
                  ),
                  dataModuleStyle: QrDataModuleStyle(
                    dataModuleShape: QrDataModuleShape.circle,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),
            Text(
              "Quét mã QR để xem hoặc tải phiếu khám",
              style: TextStyle(color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),

            // 🟩 Nút mở PDF (nếu vẫn muốn giữ)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                icon: const Icon(Icons.picture_as_pdf, color: Colors.white),
                label: const Text("Xem phiếu khám",
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                onPressed: () {
                  // TODO: mở file PDF / base64 viewer
                },
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
