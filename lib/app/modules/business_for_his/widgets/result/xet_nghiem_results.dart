import 'package:flutter/material.dart';
import 'package:pstb/app/models/business_detail_model.dart';
import 'package:pstb/app/modules/business_for_his/widgets/result/components/xn_filter_bar.dart';
import 'package:pstb/app/modules/business_for_his/widgets/result/components/xn_statistics_card.dart';
import 'package:pstb/app/modules/business_for_his/widgets/result/components/xn_type_card.dart';

import '../../../../../../utils/colors.dart';
import '../../../business/detail/xet_nghiem_result_screen.dart';
import '../../utils/date_utils.dart';
import '../../utils/grouping_utils.dart';

/// XÉT NGHIỆM RESULTS - with filter, search, and timeline
class XetNghiemResults extends StatefulWidget {
  final Map<String, List<XetNghiemInfo>> groupedData;

  const XetNghiemResults({
    Key? key,
    required this.groupedData,
  }) : super(key: key);

  @override
  State<XetNghiemResults> createState() => _XetNghiemResultsState();
}

class _XetNghiemResultsState extends State<XetNghiemResults>
    with AutomaticKeepAliveClientMixin {
  DateTime? _startDate;
  DateTime? _endDate;
  String _searchQuery = '';
  String? _selectedQuickFilter;
  Map<String, bool> _expandedCards = {};
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

  Map<String, List<XetNghiemInfo>> _filterByDateRange(
      Map<String, List<XetNghiemInfo>> data) {
    if (_startDate == null || _endDate == null) return data;
    return Map.fromEntries(data.entries.where((e) {
      final date = DateUtilsHelper.parseDate(e.key);
      return date.isAfter(_startDate!) &&
          date.isBefore(_endDate!.add(const Duration(days: 1)));
    }));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final filteredData = _filterByDateRange(widget.groupedData);

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      children: [
        XNFilterBar(
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
          // XNStatisticsCard(data: filteredData),
          // const SizedBox(height: 12),
          _buildDateRangeSelector(),
          const SizedBox(height: 12),
          _buildSearchBar(),
          const SizedBox(height: 16),
          ..._buildXetNghiemByDateSection(filteredData),
        ] else
          _buildEmptyState('Không có kết quả xét nghiệm'),
      ],
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      onChanged: (v) => setState(() => _searchQuery = v.toLowerCase()),
      decoration: InputDecoration(
        hintText: 'Tìm loại xét nghiệm...',
        hintStyle: TextStyle(color: Colors.grey[400], fontSize: 13),
        prefixIcon: Icon(Icons.search, color: Colors.grey[400], size: 20),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey[200]!)),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      ),
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

  List<Widget> _buildXetNghiemByDateSection(
      Map<String, List<XetNghiemInfo>> grouped) {
    return grouped.entries.map((entry) {
      final groupedByType = GroupingUtils.groupXetNghiemByType(entry.value);

      final filtered = groupedByType.entries
          .where((e) =>
              _searchQuery.isEmpty ||
              e.key.toLowerCase().contains(_searchQuery))
          .toList();

      if (filtered.isEmpty && _searchQuery.isNotEmpty) {
        return const SizedBox.shrink();
      }

      final displayDate = DateUtilsHelper.getDisplayDateLabel(entry.key);

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.08),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.primary.withOpacity(0.2))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(displayDate,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: AppColors.primary)),
                Text('${filtered.length} loại',
                    style: TextStyle(
                        fontSize: 12,
                        color: AppColors.primary.withOpacity(0.7),
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          const SizedBox(height: 12),
          ...filtered.map((e) {
            final key = '${e.key}-${e.value.length}';
            final isExpanded = _expandedCards[key] ?? false;
            return XNTypeCard(
              typeName: e.key,
              items: e.value,
              isExpanded: isExpanded,
              onToggle: () => setState(() => _expandedCards[key] = !isExpanded),
              onShowDetails: () =>
                  _showKetQuaXetNghiemDialog(context, e.key, e.value),
            );
          }),
          const SizedBox(height: 20),
        ],
      );
    }).toList();
  }

  void _showKetQuaXetNghiemDialog(
    BuildContext context,
    String tenLoai,
    List<XetNghiemInfo> danhSach,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => XetNghiemResultScreen(
          tenLoai: tenLoai,
          danhSach: danhSach,
        ),
      ),
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
