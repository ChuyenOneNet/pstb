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
  final ScrollController _horizontalScroll = ScrollController();
  final ScrollController _verticalScroll = ScrollController();

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
    if (value == null || range == null) return true;
    return !range.contains('cao') &&
        !range.contains('thấp') &&
        !value.contains('dương tính');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primary,
        title: Text(
          'Kết quả xét nghiệm',
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Header: loại xét nghiệm + dịch vụ
          Container(
            width: double.maxFinite,
            padding: const EdgeInsets.all(12),
            color: AppColors.primary.withOpacity(0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Loại xét nghiệm:',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.tenLoai,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                      fontSize: 16),
                ),
                // const SizedBox(height: 4),
                // Text(
                //   'Dịch vụ: ${widget.danhSach.first.tenDichVu ?? '-'}',
                //   style: TextStyle(color: Colors.grey[700], fontSize: 12),
                // ),
              ],
            ),
          ),

          // Search bar
          Padding(
            padding: const EdgeInsets.all(12),
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

          // Table header + scroll
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
                : Scrollbar(
                    thumbVisibility: true,
                    controller: _verticalScroll,
                    child: SingleChildScrollView(
                      controller: _verticalScroll,
                      scrollDirection: Axis.vertical,
                      child: SingleChildScrollView(
                        controller: _horizontalScroll,
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          headingRowColor: MaterialStateProperty.all(
                              AppColors.primary.withOpacity(0.1)),
                          columnSpacing: 12,
                          columns: const [
                            DataColumn(
                                label: SizedBox(width: 20, child: Text('STT'))),
                            DataColumn(
                                label:
                                    SizedBox(width: 80, child: Text('Chỉ số'))),
                            DataColumn(
                                label: SizedBox(
                                    width: 60, child: Text('Kết quả'))),
                            DataColumn(
                                label: SizedBox(
                                    width: 90, child: Text('Tham chiếu'))),
                            DataColumn(
                                label:
                                    SizedBox(width: 60, child: Text('Đơn vị'))),
                            DataColumn(
                                label: SizedBox(
                                    width: 100, child: Text('Trạng thái'))),
                          ],
                          rows: _filteredList.asMap().entries.map((entry) {
                            final idx = entry.key;
                            final item = entry.value;
                            final isNormal =
                                _isValueNormal(item.giaTri, item.normalRange);

                            return DataRow(cells: [
                              DataCell(Text('${idx + 1}')),
                              DataCell(
                                SizedBox(
                                  width: 80,
                                  child: Text(
                                    item.tenChiSo ?? '-',
                                    softWrap: true,
                                  ),
                                ),
                              ),
                              DataCell(Text(
                                item.giaTri ?? '-',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: isNormal
                                        ? Colors.green
                                        : Colors.orange),
                              )),
                              DataCell(
                                SizedBox(
                                  width: 90,
                                  child: Text(
                                    item.normalRange ?? '-',
                                    softWrap: true,
                                  ),
                                ),
                              ),
                              DataCell(Text(item.donViTinh ?? '-')),
                              DataCell(
                                Text(
                                  isNormal ? '✓ Bình thường' : '⚠ Chú ý',
                                  style: TextStyle(
                                      color: isNormal
                                          ? Colors.green
                                          : Colors.orange,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ]);
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _horizontalScroll.dispose();
    _verticalScroll.dispose();
    super.dispose();
  }
}
