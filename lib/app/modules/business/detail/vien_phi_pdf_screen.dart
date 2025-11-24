import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:pstb/utils/colors.dart';

class VienPhiPdfScreen extends StatefulWidget {
  final String maGiaoDich;
  final String ngayPhatHanh;
  final Future<String?> Function(String) fetchPdfCallback;

  const VienPhiPdfScreen({
    Key? key,
    required this.maGiaoDich,
    required this.ngayPhatHanh,
    required this.fetchPdfCallback,
  }) : super(key: key);

  @override
  State<VienPhiPdfScreen> createState() => _VienPhiPdfScreenState();
}

class _VienPhiPdfScreenState extends State<VienPhiPdfScreen> {
  Uint8List? _pdfBytes;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  Future<void> _loadPdf() async {
    try {
      final pdfBase64 = await widget.fetchPdfCallback(widget.maGiaoDich);

      if (pdfBase64 != null && pdfBase64.isNotEmpty) {
        final bytes = base64Decode(pdfBase64);
        setState(() {
          _pdfBytes = bytes;
          _isLoading = false;
        });
      } else {
        setState(() {
          _error = 'Không có dữ liệu PDF';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Lỗi giải mã PDF: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primary,
        title: Text(
          'Chi phí khám chữa bệnh',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          if (_pdfBytes != null)
            IconButton(
              onPressed: _downloadPdf,
              icon: const Icon(Icons.download, color: Colors.white),
              tooltip: 'Tải xuống',
            ),
        ],
      ),
      body: Column(
        children: [
          // Info header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              border: Border(
                bottom: BorderSide(
                  color: AppColors.primary.withOpacity(0.3),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mã tra cứu',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.maGiaoDich,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Ngày phát hành',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.ngayPhatHanh,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // PDF Viewer
          Expanded(
            child: _buildContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(
              'Đang tải PDF...',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
          ],
        ),
      );
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: Colors.red[400],
            ),
            const SizedBox(height: 16),
            Text(
              _error!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.red[400],
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              style:
                  ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
              onPressed: () {
                setState(() {
                  _isLoading = true;
                  _error = null;
                });
                _loadPdf();
              },
              icon: Icon(
                Icons.refresh,
                color: AppColors.background,
              ),
              label: const Text(
                'Tải lại',
                style: TextStyle(color: AppColors.background),
              ),
            ),
          ],
        ),
      );
    }

    if (_pdfBytes == null) {
      return Center(
        child: Text(
          'Không có dữ liệu PDF',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
        ),
      );
    }

    return SfPdfViewer.memory(_pdfBytes!);
  }

  void _downloadPdf() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Chức năng tải xuống sắp có')),
    );
  }
}
