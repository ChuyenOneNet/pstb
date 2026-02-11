import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/models/business_detail_model.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../../../utils/colors.dart';
import '../../../../../utils/routes.dart';
import '../../utils/date_utils.dart';
import 'components/image_card.dart';
import 'components/image_filter_bar.dart';

/// CHẨN ĐOÁN HÌNH ẢNH RESULTS - with filter and timeline
class ImageDiagnosisResults extends StatefulWidget {
  final Map<String, List<UrlDataInfo>> groupedData;

  const ImageDiagnosisResults({
    Key? key,
    required this.groupedData,
  }) : super(key: key);

  @override
  State<ImageDiagnosisResults> createState() => _ImageDiagnosisResultsState();
}

class _ImageDiagnosisResultsState extends State<ImageDiagnosisResults>
    with AutomaticKeepAliveClientMixin {
  DateTime? _startDate;
  DateTime? _endDate;
  String? _selectedQuickFilter;
  String _searchQuery = '';
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    super.initState();
    _initializeDates();
  }

  void _initializeDates() {
    _endDate = DateTime.now();
    _startDate = _endDate?.subtract(const Duration(days: 7));
    _selectedQuickFilter = '7days';
  }

  void _applyQuickFilter(String filterType) {
    setState(() {
      _selectedQuickFilter = filterType;
      _endDate = DateTime.now();
      switch (filterType) {
        case '7days':
          _startDate = _endDate?.subtract(const Duration(days: 7));
          break;
        case '10days':
          _startDate = _endDate?.subtract(const Duration(days: 10));
          break;
        case '15days':
          _startDate = _endDate?.subtract(const Duration(days: 15));
          break;
        case '30days':
          _startDate = _endDate?.subtract(const Duration(days: 30));
          break;
        case 'all':
          _startDate = DateTime(2020);
          break;
      }
    });
  }

  void _selectDateRange() async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDateRange: DateTimeRange(
        start: _startDate ?? DateTime.now().subtract(const Duration(days: 7)),
        end: _endDate ?? DateTime.now(),
      ),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
        _selectedQuickFilter = null;
      });
    }
  }

  Map<String, List<UrlDataInfo>> _filterByDateRange(
      Map<String, List<UrlDataInfo>> data) {
    if (_startDate == null || _endDate == null) return data;
    return Map.fromEntries(data.entries.where((e) {
      final date = DateUtilsHelper.parseDate(e.key);
      return date.isAfter(_startDate!) &&
          date.isBefore(_endDate!.add(const Duration(days: 1)));
    }));
  }

  Widget _buildSearchBar() {
    return TextField(
      onChanged: (v) => setState(() => _searchQuery = v.toLowerCase()),
      decoration: InputDecoration(
        hintText: 'Tìm kết quả chẩn đoán...',
        hintStyle: TextStyle(color: Colors.grey[400], fontSize: 13),
        prefixIcon: Icon(Icons.search, color: Colors.grey[400], size: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey[200]!),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final filteredData = _filterByDateRange(widget.groupedData);

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      children: [
        ImageFilterBar(
          filters: [
            ('7 Ngày', '7days'),
            ('10 Ngày', '10days'),
            ('15 Ngày', '15days'),
            ('30 Ngày', '30days'),
            ('Tất cả', 'all'),
            ('Tuỳ chọn', 'custom')
          ],
          selectedQuickFilter: _selectedQuickFilter,
          onFilterTap: (type) =>
              type == 'custom' ? _selectDateRange() : _applyQuickFilter(type),
        ),
        const SizedBox(height: 12),
        if (filteredData.isNotEmpty) ...[
          _buildDateRangeSelector(),
          const SizedBox(height: 12),
          _buildSearchBar(),
          const SizedBox(height: 16),
          ..._buildImageByDateSection(filteredData),
        ] else
          _buildEmptyState('Không có kết quả chẩn đoán hình ảnh'),
      ],
    );
  }

  Widget _buildDateRangeSelector() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[200]!),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ]),
      child: InkWell(
        onTap: _selectDateRange,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Khoảng thời gian',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500)),
                    const SizedBox(height: 6),
                    Text(
                      '${DateUtilsHelper.formatDateDisplay(_startDate)} - ${DateUtilsHelper.formatDateDisplay(_endDate)}',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey[900]),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8)),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Icon(Icons.calendar_today,
                      size: 16, color: AppColors.primary),
                  const SizedBox(width: 6),
                  Text('Chọn',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary))
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildImageByDateSection(
      Map<String, List<UrlDataInfo>> grouped) {
    return grouped.entries.map((entry) {
      final displayDate = DateUtilsHelper.getDisplayDateLabel(entry.key);

      final filteredItems = entry.value.where((data) {
        if (_searchQuery.isEmpty) return true;
        final name = (data.tenDichVu ?? '').toLowerCase();
        final url = (data.fileUrl ?? '').toLowerCase();
        return name.contains(_searchQuery) || url.contains(_searchQuery);
      }).toList();

      if (filteredItems.isEmpty) {
        return const SizedBox.shrink();
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.08),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.primary.withOpacity(0.2)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  displayDate,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: AppColors.primary,
                  ),
                ),
                Text(
                  '${filteredItems.length} kết quả',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.primary.withOpacity(0.7),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          ...filteredItems.map((data) => ImageCard(
                data: data,
                onShowPdf: () => _showPdfBase64Dialog(context, data.pdfBase64!),
                onShowPacs: () => _onShowPacs(data),
              )),
          const SizedBox(height: 20),
        ],
      );
    }).toList();
  }

  void _showPdfBase64Dialog(BuildContext context, String base64Pdf) {
    try {
      final bytes = base64Decode(base64Pdf);

      showDialog(
        context: context,
        builder: (_) => Dialog(
          insetPadding: const EdgeInsets.all(12),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.95,
            height: MediaQuery.of(context).size.height * 0.7,
            child: SfPdfViewer.memory(bytes),
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lỗi hiển thị PDF')),
      );
    }
  }

  void _onShowPacs(UrlDataInfo data) {
    final url = data.fileUrl ?? '';
    if (url.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Không có đường dẫn kết quả')),
      );
      return;
    }
    Modular.to.pushNamed(
      AppRoutes.businessWebViewPdf,
      arguments: {
        'url': url,
        'title': data.tenDichVu ?? 'Chẩn đoán hình ảnh',
      },
    );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: Column(
          children: [
            const Icon(Icons.info_outline, size: 48, color: Colors.grey),
            const SizedBox(height: 12),
            Text(
              message,
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
