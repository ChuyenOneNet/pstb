import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:open_filex/open_filex.dart';
import 'package:pstb/app/modules/attach_document_his/widgets/image_preview_page.dart';
import 'package:pstb/app/modules/attach_document_his/widgets/upload_form_widgets.dart';

import 'package:pstb/utils/colors.dart';
import 'package:pstb/widgets/stateless/app_bar.dart';

class UploadMedicalDocumentPage extends StatefulWidget {
  final String dangKyId;
  final String? benhNhanId;

  const UploadMedicalDocumentPage({
    Key? key,
    required this.dangKyId,
    this.benhNhanId,
  }) : super(key: key);

  @override
  State<UploadMedicalDocumentPage> createState() =>
      _UploadMedicalDocumentPageState();
}

class _UploadMedicalDocumentPageState extends State<UploadMedicalDocumentPage> {
  File? _file;
  final _fileNameCtrl = TextEditingController();

  String _loaiTaiLieu = 'Tài liệu đính kèm';
  String _nhomTaiLieu = 'Bệnh án';
  String _khoaPhong = 'Khoa Sản';

  bool _uploading = false;
  bool _isPickingFile = false;

  static const int _maxFileSizeBytes = 20 * 1024 * 1024; // 20MB
  double? _readProgress;
  bool get _isReadingFile => _readProgress != null;

  Future<File> _copyFileWithProgress(File source) async {
    final totalBytes = await source.length();
    int copiedBytes = 0;

    final tempDir = Directory.systemTemp;
    final fileName = source.uri.pathSegments.last;
    final tempFile = File(
      '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}_$fileName',
    );

    final input = source.openRead();
    final output = tempFile.openWrite();

    await for (final chunk in input) {
      copiedBytes += chunk.length;
      output.add(chunk);

      setState(() {
        _readProgress = copiedBytes / totalBytes;
      });
    }

    await output.flush();
    await output.close();

    return tempFile;
  }

  String _readableFileSize(int bytes) {
    final mb = bytes / (1024 * 1024);
    return '${mb.toStringAsFixed(2)} MB';
  }

  @override
  void dispose() {
    _fileNameCtrl.dispose();
    super.dispose();
  }

  bool get _isImage {
    if (_file == null) return false;
    final ext = _file!.path.toLowerCase();
    return ext.endsWith('.jpg') ||
        ext.endsWith('.jpeg') ||
        ext.endsWith('.png');
  }

  bool get _isPdf {
    if (_file == null) return false;
    return _file!.path.toLowerCase().endsWith('.pdf');
  }

  Future<void> _openFile() async {
    if (_file == null) return;

    if (_isImage) {
      // mở viewer ảnh custom
      Modular.to.push(
        MaterialPageRoute(
          builder: (_) => ImagePreviewPage(file: _file!),
        ),
      );
    } else {
      // PDF hoặc file khác → mở bằng app hệ thống
      await OpenFilex.open(_file!.path);
    }
  }

  Future<void> _pickFile() async {
    if (_uploading || _isReadingFile || _isPickingFile) return;

    _isPickingFile = true; // 🔒 khóa picker

    try {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
      );

      if (result == null || result.files.single.path == null) return;

      final picked = result.files.single;
      final sourceFile = File(picked.path!);

      // ✅ Validate dung lượng ≤ 20MB
      final fileSize = sourceFile.lengthSync();
      if (fileSize > _maxFileSizeBytes) {
        Fluttertoast.showToast(
          msg: 'Dung lượng file (${_readableFileSize(fileSize)}) vượt quá 20MB',
        );
        return;
      }

      // 👉 bật progress đọc file
      setState(() {
        _readProgress = 0;
      });

      final copiedFile = await _copyFileWithProgress(sourceFile);

      if (!mounted) return;

      setState(() {
        _file = copiedFile;
        _fileNameCtrl.text = result.files.single.name;
        //_isImage ? 'Tài liệu ảnh' : 'Tài liệu PDF';
        _readProgress = null;
      });
    } on PlatformException catch (e) {
      // ✅ BẮT LỖI already_active
      if (e.code != 'already_active') {
        Fluttertoast.showToast(msg: 'Không thể mở trình chọn file');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Lỗi khi đọc file');
      if (mounted) setState(() => _readProgress = null);
    } finally {
      _isPickingFile = false; // 🔓 mở khóa
    }
  }

  Future<void> _upload() async {
    if (_file == null) {
      Fluttertoast.showToast(msg: 'Vui lòng chọn file');
      return;
    }

    if (_fileNameCtrl.text.trim().isEmpty) {
      Fluttertoast.showToast(msg: 'Vui lòng nhập tên file');
      return;
    }

    setState(() => _uploading = true);

    try {
      // TODO: gọi API upload HIS tại đây
      // await store.uploadMedicalDocument(...)

      await Future.delayed(const Duration(seconds: 1)); // mock

      Fluttertoast.showToast(msg: 'Upload thành công');
      setState(() {
        _file = null;
        _fileNameCtrl.clear();
        _readProgress = null;
      });
    } catch (e) {
      Fluttertoast.showToast(msg: 'Upload thất bại');
    } finally {
      if (mounted) setState(() => _uploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Scan giấy tờ kèm theo',
        isBack: true,
      ),
      backgroundColor: const Color(0xFFF6F7FB),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== Box chọn file =====
            GestureDetector(
              onTap: (_uploading || _isReadingFile || _isPickingFile)
                  ? null
                  : _pickFile,
              child: Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.shade400,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: Center(
                  child: _file == null
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.image_outlined, size: 48),
                            SizedBox(height: 8),
                            Text('Chọn ảnh từ máy tính'),
                            Text(
                              'Nhấn để chọn file',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        )
                      : _FilePreviewCard(
                          file: _file!,
                          fileName: _fileNameCtrl.text,
                          isImage: _isImage,
                          isPdf: _isPdf,
                        ),
                ),
              ),
            ),

            const SizedBox(height: 16),
            if (_readProgress != null) ...[
              const SizedBox(height: 12),
              const Text(
                'Đang đọc file từ thiết bị...',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 6),
              LinearProgressIndicator(
                value: _readProgress,
                minHeight: 6,
                backgroundColor: Colors.grey.shade300,
                color: AppColors.primary,
              ),
              const SizedBox(height: 4),
              Text(
                '${(_readProgress! * 100).toStringAsFixed(0)}%',
                style: const TextStyle(fontSize: 12),
              ),
            ],
            const SizedBox(height: 16),
            SizedBox(
              height: 48,
              child: ElevatedButton.icon(
                onPressed: (_file == null || _uploading) ? null : _openFile,
                icon: const Icon(
                  Icons.remove_red_eye,
                  color: AppColors.background,
                ),
                label: const Text(
                  'Xem file',
                  style: TextStyle(color: AppColors.background),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: AppColors.primary,
                ),
              ),
            ),

            const SizedBox(height: 16),
            Input(label: 'Tên file', controller: _fileNameCtrl),

            Dropdown(
              label: 'Loại tài liệu',
              value: _loaiTaiLieu,
              items: const ['Tài liệu đính kèm', 'Kết quả', 'Đơn thuốc'],
              onChanged: (v) => setState(() => _loaiTaiLieu = v),
            ),

            Dropdown(
              label: 'Nhóm tài liệu',
              value: _nhomTaiLieu,
              items: const ['Bệnh án', 'Xét nghiệm', 'Chẩn đoán hình ảnh'],
              onChanged: (v) => setState(() => _nhomTaiLieu = v),
            ),

            Dropdown(
              label: 'Khoa phòng',
              value: _khoaPhong,
              items: const [
                'Khoa Sản',
                'Khoa Xét nghiệm',
                'Khoa Chẩn đoán',
              ],
              onChanged: (v) => setState(() => _khoaPhong = v),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: _uploading ? null : _upload,
                icon: const Icon(
                  Icons.cloud_upload,
                  color: AppColors.background,
                ),
                label: _uploading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Upload',
                        style: TextStyle(color: AppColors.background),
                      ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilePreviewCard extends StatelessWidget {
  final File file;
  final String fileName;
  final bool isImage;
  final bool isPdf;

  const _FilePreviewCard({
    required this.file,
    required this.fileName,
    required this.isImage,
    required this.isPdf,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Nền preview
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            width: double.infinity,
            height: 180,
            child: isImage
                ? Image.file(
                    file,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _pdfFallbackBackground(),
                  )
                : _pdfFallbackBackground(),
          ),
        ),

        // lớp phủ tối nhẹ để chữ rõ
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.25),
                  Colors.black.withOpacity(0.45),
                ],
              ),
            ),
          ),
        ),

        // badge PDF nếu là pdf
        if (isPdf)
          Positioned(
            top: 12,
            left: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFB71C1C),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'PDF',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),

        // info + hướng dẫn
        Positioned(
          left: 12,
          right: 12,
          bottom: 12,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                fileName,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 13.5,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: const [
                  Icon(Icons.touch_app, color: Colors.white, size: 16),
                  SizedBox(width: 6),
                  Text(
                    'Nhấn để chọn file',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _pdfFallbackBackground() {
    // “Nền PDF”: xám + icon pdf to
    return Container(
      color: const Color(0xFFF2F3F5),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.picture_as_pdf, size: 54, color: Color(0xFFB71C1C)),
            SizedBox(height: 8),
            Text(
              'Tài liệu PDF',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Color(0xFF111827),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
