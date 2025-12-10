import 'package:flutter/material.dart';
import 'package:pstb/app/models/business_detail_model.dart';
import 'package:pstb/utils/colors.dart';

class XetNghiemResultScreen extends StatefulWidget {
  final String tenLoai;
  final List<XetNghiemInfo> danhSach;

  const XetNghiemResultScreen({
    Key? key,
    required this.tenLoai,
    required this.danhSach,
  }) : super(key: key);

  @override
  State<XetNghiemResultScreen> createState() => _XetNghiemResultScreenState();
}

class _XetNghiemResultScreenState extends State<XetNghiemResultScreen> {
  late TextEditingController _searchController;
  late List<XetNghiemInfo> _filteredList;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _filteredList = widget.danhSach;
  }

  void _filterSearch(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredList = widget.danhSach;
      } else {
        _filteredList = widget.danhSach
            .where((item) =>
                item.tenChiSo?.toLowerCase().contains(query.toLowerCase()) ??
                false)
            .toList();
      }
    });
  }

  bool _isValueNormal(String? value, String? range) {
    if (value == null || range == null) return false;

    // Chuẩn hoá toàn bộ: đổi dấu phẩy thành dấu chấm
    String normalizeNumber(String s) => s.replaceAll(',', '.').trim();

    final double? v = double.tryParse(normalizeNumber(value));
    if (v == null) return false;
    ;

    final r = range.trim();

    // ---- < , <=
    if (r.startsWith("<=")) {
      final limit = double.tryParse(normalizeNumber(r.substring(2)));
      if (limit == null) return false;
      ;
      return v <= limit;
    }

    if (r.startsWith("<")) {
      final limit = double.tryParse(normalizeNumber(r.substring(1)));
      if (limit == null) return false;
      ;
      return v < limit;
    }

    // ---- > , >=
    if (r.startsWith(">=")) {
      final limit = double.tryParse(normalizeNumber(r.substring(2)));
      if (limit == null) return false;
      ;
      return v >= limit;
    }

    if (r.startsWith(">")) {
      final limit = double.tryParse(normalizeNumber(r.substring(1)));
      if (limit == null) return false;
      ;
      return v > limit;
    }

    // ---- Trường hợp khoảng: "6,5 - 8,5" hoặc "6.5-8.5"
    final rangeRegex = RegExp(r'^\s*([0-9.,+-]+)\s*-\s*([0-9.,+-]+)\s*$');
    final match = rangeRegex.firstMatch(r);
    if (match != null) {
      final min = double.tryParse(normalizeNumber(match.group(1)!));
      final max = double.tryParse(normalizeNumber(match.group(2)!));

      if (min == null || max == null) return false;
      ;

      return v >= min && v <= max;
    }

    // Format khác → coi như OK
    return false;
    ;
  }

  int _getAbnormalCount() {
    return _filteredList
        .where((item) => !_isValueNormal(item.giaTri, item.normalRange))
        .length;
  }

  @override
  Widget build(BuildContext context) {
    final abnormalCount = _getAbnormalCount();
    final normalCount = _filteredList.length - abnormalCount;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primary,
        centerTitle: true,
        title: Text(
          widget.tenLoai,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Header: loại xét nghiệm
          Container(
            width: double.maxFinite,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primary.withOpacity(0.1),
                  AppColors.primary.withOpacity(0.05),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   'Loại xét nghiệm',
                //   style: TextStyle(color: Colors.grey[600], fontSize: 12),
                // ),
                // const SizedBox(height: 8),
                // Text(
                //   widget.tenLoai,
                //   style: const TextStyle(
                //       fontWeight: FontWeight.bold,
                //       color: AppColors.primary,
                //       fontSize: 18),
                // ),
                // const SizedBox(height: 12),
                // // Summary stats
                Row(
                  children: [
                    _buildStatCard(
                      icon: Icons.check_circle,
                      count: normalCount,
                      label: 'Bình thường',
                      color: Colors.green,
                    ),
                    const SizedBox(width: 12),
                    _buildStatCard(
                      icon: Icons.warning_amber_rounded,
                      count: abnormalCount,
                      label: 'Cần chú ý',
                      color: Colors.orange,
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              onChanged: _filterSearch,
              decoration: InputDecoration(
                hintText: 'Tìm kiếm chỉ số...',
                prefixIcon: const Icon(Icons.search, color: AppColors.primary),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      const BorderSide(color: AppColors.primary, width: 2),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
          ),
          // Results list
          Expanded(
            child: _filteredList.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off,
                            size: 48, color: Colors.grey[400]),
                        const SizedBox(height: 8),
                        Text(
                          'Không tìm thấy kết quả',
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 14),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    itemCount: _filteredList.length,
                    itemBuilder: (context, index) {
                      final item = _filteredList[index];
                      final isNormal =
                          _isValueNormal(item.giaTri, item.normalRange);

                      return _buildResultCard(
                        index: index,
                        item: item,
                        isNormal: isNormal,
                      );
                    },
                  ),
          )
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required int count,
    required String label,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$count',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: color, fontSize: 16),
                ),
                Text(
                  label,
                  style: TextStyle(color: Colors.grey[600], fontSize: 11),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultCard({
    required int index,
    required XetNghiemInfo item,
    required bool isNormal,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isNormal
              ? Colors.green.withOpacity(0.2)
              : Colors.orange.withOpacity(0.2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: STT + Tên chỉ số + Status
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.tenChiSo ?? '-',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      // const SizedBox(height: 4),
                      // Text(
                      //   item.tenDichVu ?? '',
                      //   style: TextStyle(
                      //     fontSize: 12,
                      //     color: Colors.grey[500],
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isNormal
                        ? Colors.green.withOpacity(0.1)
                        : Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isNormal
                            ? Icons.check_circle
                            : Icons.warning_amber_rounded,
                        size: 16,
                        color: isNormal ? Colors.green : Colors.orange,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        isNormal ? 'Bình thường' : 'Chú ý',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isNormal ? Colors.green : Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // const SizedBox(height: 12),
            // // Divider
            // Container(
            //   height: 1,
            //   color: Colors.grey.withOpacity(0.1),
            // ),
            const SizedBox(height: 12),
            // Details grid
            Row(
              children: [
                Expanded(
                  child: _buildDetailItem(
                    label: 'Kết quả',
                    value: item.giaTri ?? '-',
                    isHighlight: true,
                    valueColor: isNormal ? Colors.green : Colors.orange,
                  ),
                ),
                // Expanded(
                //   child: _buildDetailItem(
                //     label: 'Kết quả',
                //     value: item.giaTri ?? '-',
                //     unit: item.donViTinh ?? '',
                //     isHighlight: true,
                //     valueColor: isNormal ? Colors.green : Colors.orange,
                //   ),
                // ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildDetailItem(
                    label: 'Đơn vị',
                    value: item.donViTinh ?? '-',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildDetailItem(
                    label: 'Tham chiếu',
                    value: item.normalRange ?? '-',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem({
    required String label,
    required String value,
    String unit = '',
    bool isHighlight = false,
    Color? valueColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Expanded(
              child: Text(
                value,
                style: TextStyle(
                  fontSize: isHighlight ? 16 : 14,
                  fontWeight: isHighlight ? FontWeight.bold : FontWeight.w500,
                  color: valueColor ?? Colors.black,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (unit.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Text(
                  unit,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[500],
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
