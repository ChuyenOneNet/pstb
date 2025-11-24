import 'package:flutter/material.dart';
import 'package:pstb/app/models/business_detail_model.dart';
import 'package:pstb/utils/colors.dart';

class ThuocResultScreen extends StatefulWidget {
  final String loai;
  final List<ToaThuocInfo> danhSach;

  const ThuocResultScreen({
    Key? key,
    required this.loai,
    required this.danhSach,
  }) : super(key: key);

  @override
  State<ThuocResultScreen> createState() => _ThuocResultScreenState();
}

class _ThuocResultScreenState extends State<ThuocResultScreen> {
  late TextEditingController _searchController;
  late List<ToaThuocInfo> _filteredList;

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
                item.tenHang?.toLowerCase().contains(query.toLowerCase()) ??
                false)
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primary,
        title: Text(
          'Danh sách thuốc',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header with prescription type
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Loại đơn thuốc',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.loai,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tổng ${widget.danhSach.length} loại thuốc',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[700],
                        ),
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
                  hintText: 'Tìm kiếm thuốc...',
                  prefixIcon:
                      const Icon(Icons.search, color: AppColors.primary),
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

            // Results count
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Hiển thị ${_filteredList.length} / ${widget.danhSach.length}',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                ],
              ),
            ),

            // List
            _filteredList.isEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 48),
                    child: Column(
                      children: [
                        Icon(
                          Icons.local_pharmacy_outlined,
                          size: 48,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Không tìm thấy thuốc',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Colors.grey[600],
                                  ),
                        ),
                      ],
                    ),
                  )
                : isMobile
                    ? _buildMobileList()
                    : _buildDesktopTable(),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _filteredList.length,
      itemBuilder: (context, index) {
        final thuoc = _filteredList[index];

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  width: double.infinity,
                  child: Row(
                    children: [
                      const Icon(Icons.medical_services,
                          color: AppColors.primary, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        '${index + 1}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  thuoc.tenHang ?? 'Không xác định',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                _buildMobileInfoRow('Hoạt chất', thuoc.hoatChat ?? '-'),
                _buildMobileInfoRow('Số lượng',
                    '${thuoc.soLuong ?? '-'} ${thuoc.donViTinh ?? ''}'),
                _buildMobileInfoRow('Đường dùng', thuoc.duongDung ?? '-'),
                _buildMobileInfoRow('Cách dùng', thuoc.cachDung ?? '-'),
                if (thuoc.bacSi != null && thuoc.bacSi!.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.person_outline,
                            size: 16, color: Colors.blue),
                        const SizedBox(width: 8),
                        Text(
                          'Bác sĩ: ${thuoc.bacSi}',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDesktopTable() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Table(
          columnWidths: const {
            0: FixedColumnWidth(50),
            1: FixedColumnWidth(200),
            2: FixedColumnWidth(120),
            3: FixedColumnWidth(100),
            4: FixedColumnWidth(100),
            5: FixedColumnWidth(120),
            6: FixedColumnWidth(150),
          },
          border: TableBorder(
            horizontalInside: BorderSide(color: Colors.grey.shade200),
            bottom: BorderSide(color: Colors.grey.shade300),
            top: BorderSide(color: Colors.grey.shade300),
          ),
          children: [
            // Header
            TableRow(
              decoration:
                  BoxDecoration(color: AppColors.primary.withOpacity(0.1)),
              children: [
                _buildTableHeader('STT'),
                _buildTableHeader('Tên thuốc'),
                _buildTableHeader('Hoạt chất'),
                _buildTableHeader('Số lượng'),
                _buildTableHeader('Đơn vị'),
                _buildTableHeader('Cách dùng'),
                _buildTableHeader('Đường dùng'),
              ],
            ),
            // Rows
            ..._filteredList.asMap().entries.map((entry) {
              final idx = entry.key;
              final thuoc = entry.value;

              return TableRow(
                children: [
                  _buildTableCell('${idx + 1}'),
                  _buildTableCell(thuoc.tenHang ?? '-', bold: true),
                  _buildTableCell(thuoc.hoatChat ?? '-'),
                  _buildTableCell(thuoc.soLuong ?? '-'),
                  _buildTableCell(thuoc.donViTinh ?? '-'),
                  _buildTableCell(thuoc.cachDung ?? '-'),
                  _buildTableCell(thuoc.duongDung ?? '-'),
                ],
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildTableHeader(String text) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildTableCell(String text, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: bold ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildMobileInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
