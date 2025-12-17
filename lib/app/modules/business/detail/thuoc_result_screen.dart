import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  late final TextEditingController _searchController;
  late List<ToaThuocInfo> _filteredList;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _filteredList = _sorted(widget.danhSach);
  }

  List<ToaThuocInfo> _sorted(List<ToaThuocInfo> input) {
    final list = List<ToaThuocInfo>.from(input);
    list.sort((a, b) {
      final an = (a.tenHang ?? '').trim().toLowerCase();
      final bn = (b.tenHang ?? '').trim().toLowerCase();
      return an.compareTo(bn);
    });
    return list;
  }

  void _filterSearch(String query) {
    final q = query.trim().toLowerCase();
    setState(() {
      if (q.isEmpty) {
        _filteredList = _sorted(widget.danhSach);
        return;
      }

      _filteredList = _sorted(
        widget.danhSach.where((item) {
          final name = (item.tenHang ?? '').toLowerCase();
          final active = (item.hoatChat ?? '').toLowerCase();
          final usage = (item.cachDung ?? '').toLowerCase();
          return name.contains(q) || active.contains(q) || usage.contains(q);
        }).toList(),
      );
    });
  }

  String _buildPrescriptionText(List<ToaThuocInfo> list) {
    final buffer = StringBuffer();
    buffer.writeln('Loại đơn: ${widget.loai}');
    buffer.writeln('Tổng: ${list.length} thuốc');
    buffer.writeln('---');
    for (int i = 0; i < list.length; i++) {
      final t = list[i];
      buffer.writeln('${i + 1}. ${t.tenHang ?? "-"}');
      buffer.writeln('   - Hoạt chất: ${t.hoatChat ?? "-"}');
      buffer.writeln(
          '   - Số lượng: ${(t.soLuong ?? "-").trim()} ${(t.donViTinh ?? "").trim()}'
              .trim());
      buffer.writeln('   - Đường dùng: ${t.duongDung ?? "-"}');
      buffer.writeln('   - Cách dùng: ${t.cachDung ?? "-"}');
      buffer.writeln('');
    }
    return buffer.toString().trim();
  }

  Future<void> _copyToClipboard(String text, {String? toast}) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(toast ?? 'Đã sao chép')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 700;

    final total = widget.danhSach.length;
    final showing = _filteredList.length;

    final doctorsSet = LinkedHashSet<String>();
    for (final t in widget.danhSach) {
      final bs = (t.bacSi ?? '').trim();
      if (bs.isNotEmpty) doctorsSet.add(bs);
    }
    final doctors = doctorsSet.toList();

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.primary,
        title: Text(
          'Danh sách thuốc',
          style: TextStyle(
              color: AppColors.background,
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            tooltip: 'Sao chép đơn thuốc',
            icon: const Icon(Icons.copy, color: Colors.white),
            onPressed: () => _copyToClipboard(
              _buildPrescriptionText(_filteredList),
              toast: 'Đã sao chép đơn thuốc',
            ),
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
                child:
                    _Header(loai: widget.loai, total: total, doctors: doctors)),
            SliverToBoxAdapter(
                child: _SearchBar(
              controller: _searchController,
              onChanged: _filterSearch,
              onClear: () {
                _searchController.clear();
                _filterSearch('');
              },
            )),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 10),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(
                            color: AppColors.primary.withOpacity(0.18)),
                      ),
                      child: Text(
                        'Hiển thị $showing / $total',
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                    ),
                    const Spacer(),
                    if (_searchController.text.trim().isNotEmpty)
                      TextButton.icon(
                        onPressed: () {
                          _searchController.clear();
                          _filterSearch('');
                        },
                        icon: const Icon(Icons.clear, size: 18),
                        label: const Text('Xóa lọc'),
                      ),
                  ],
                ),
              ),
            ),
            if (_filteredList.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.local_pharmacy_outlined,
                            size: 56, color: Colors.grey.shade400),
                        const SizedBox(height: 14),
                        Text(
                          'Không tìm thấy thuốc',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w800,
                                    color: Colors.grey.shade700,
                                  ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Thử tìm theo tên thuốc, hoạt chất hoặc cách dùng.',
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.grey.shade600,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            else if (isMobile)
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                sliver: SliverList.separated(
                  itemCount: _filteredList.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final t = _filteredList[index];
                    return _DrugCard(
                      index: index + 1,
                      item: t,
                      query: _searchController.text.trim(),
                      onCopyUsage: () => _copyToClipboard(t.cachDung ?? '-',
                          toast: 'Đã sao chép cách dùng'),
                      onCopyName: () => _copyToClipboard(t.tenHang ?? '-',
                          toast: 'Đã sao chép tên thuốc'),
                    );
                  },
                ),
              )
            else
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: _DesktopTable(
                    list: _filteredList,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

class _Header extends StatelessWidget {
  final String loai;
  final int total;
  final List<String> doctors;

  const _Header({
    required this.loai,
    required this.total,
    required this.doctors,
  });

  @override
  Widget build(BuildContext context) {
    final hasDoctor = doctors.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.receipt_long, color: AppColors.primary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Loại đơn thuốc:',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        loai,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.primary,
                                ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _Pill(
                      text: 'Tổng $total thuốc',
                      icon: Icons.medication_outlined),
                  const SizedBox(height: 8),
                  if (hasDoctor)
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ...doctors.expand((bs) => [
                                _Pill(
                                    text: 'BS: $bs',
                                    icon: Icons.person_outline),
                                const SizedBox(width: 8),
                              ]),
                        ],
                      ),
                    )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final String text;
  final IconData icon;

  const _Pill({required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.grey.shade700),
          const SizedBox(width: 6),
          Text(
            text,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Colors.grey.shade800,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ],
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  const _SearchBar({
    required this.controller,
    required this.onChanged,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: 'Tìm theo tên thuốc / hoạt chất / cách dùng...',
          prefixIcon: const Icon(Icons.search, color: AppColors.primary),
          suffixIcon: controller.text.trim().isEmpty
              ? null
              : IconButton(
                  tooltip: 'Xóa',
                  icon: const Icon(Icons.clear),
                  onPressed: onClear,
                ),
          filled: true,
          fillColor: AppColors.background,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AppColors.primary, width: 2),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        ),
      ),
    );
  }
}

String formatSoLuong(String? raw) {
  if (raw == null) return '-';
  var s = raw.trim();
  if (s.isEmpty) return '-';

  // Nếu có nhiều dấu '.' kiểu 1.234.567 => coi là phân tách hàng nghìn
  final dotCount = '.'.allMatches(s).length;
  if (dotCount > 1) {
    s = s.replaceAll('.', '');
  }

  // Hỗ trợ trường hợp dùng ',' làm thập phân
  s = s.replaceAll(',', '.');

  final v = double.tryParse(s);
  if (v == null) return raw.trim();

  // Nếu là số nguyên (7.000 -> 7)
  final rounded = v.roundToDouble();
  if ((v - rounded).abs() < 1e-9) return rounded.toInt().toString();

  // Nếu có phần lẻ thì bỏ các số 0 dư
  var out = v.toStringAsFixed(3);
  out = out.replaceFirst(RegExp(r'\.?0+$'), '');
  return out;
}

class _DrugCard extends StatelessWidget {
  final int index;
  final ToaThuocInfo item;
  final String query;
  final VoidCallback onCopyUsage;
  final VoidCallback onCopyName;

  const _DrugCard({
    required this.index,
    required this.item,
    required this.query,
    required this.onCopyUsage,
    required this.onCopyName,
  });

  @override
  Widget build(BuildContext context) {
    final name = (item.tenHang ?? 'Không xác định').trim();
    final qty = formatSoLuong(item.soLuong);
    final unit = (item.donViTinh ?? '').trim();
    final route = (item.duongDung ?? '-').trim();
    final active = (item.hoatChat ?? '-').trim();
    final usage = (item.cachDung ?? '-').trim();

    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.fromLTRB(12, 10, 10, 10),
          childrenPadding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
          leading: Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                '$index',
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          title: _HighlightText(
            text: name,
            query: query,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: Colors.grey.shade900,
                ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _MiniTag(
                    icon: Icons.numbers,
                    text: '$qty ${unit.isNotEmpty ? unit : ""}'.trim()),
                _MiniTag(icon: Icons.alt_route, text: route),
              ],
            ),
          ),
          children: [
            const SizedBox(height: 8),
            _KeyValue(label: 'Hoạt chất', value: active),
            const SizedBox(height: 8),
            _KeyValue(label: 'Đường dùng', value: route),
            const SizedBox(height: 8),
            _KeyValue(
                label: 'Số lượng',
                value: '$qty ${unit.isNotEmpty ? unit : ""}'.trim()),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cách dùng',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                          color: Colors.grey.shade800,
                        ),
                  ),
                  const SizedBox(height: 8),
                  _HighlightText(
                    text: usage,
                    query: query,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey.shade800,
                          height: 1.35,
                        ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: onCopyUsage,
                          icon: const Icon(Icons.copy, size: 18),
                          label: const Text('Sao chép cách dùng'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        tooltip: 'Sao chép tên thuốc',
                        onPressed: onCopyName,
                        icon: const Icon(Icons.content_copy),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MiniTag extends StatelessWidget {
  final IconData icon;
  final String text;

  const _MiniTag({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.grey.shade700),
          const SizedBox(width: 6),
          Text(
            text,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Colors.grey.shade800,
                ),
          ),
        ],
      ),
    );
  }
}

class _KeyValue extends StatelessWidget {
  final String label;
  final String value;

  const _KeyValue({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 92,
          child: Text(
            '$label:',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: Colors.grey.shade600,
                ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Colors.grey.shade900,
                ),
          ),
        ),
      ],
    );
  }
}

class _HighlightText extends StatelessWidget {
  final String text;
  final String query;
  final TextStyle? style;

  const _HighlightText({
    required this.text,
    required this.query,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final q = query.trim();
    if (q.isEmpty) return Text(text, style: style);

    final lower = text.toLowerCase();
    final qLower = q.toLowerCase();
    final idx = lower.indexOf(qLower);
    if (idx < 0) return Text(text, style: style);

    final before = text.substring(0, idx);
    final match = text.substring(idx, idx + q.length);
    final after = text.substring(idx + q.length);

    final base = style ?? Theme.of(context).textTheme.bodyMedium;

    return RichText(
      text: TextSpan(
        style: base,
        children: [
          TextSpan(text: before),
          TextSpan(
            text: match,
            style: base?.copyWith(
              backgroundColor: AppColors.primary.withOpacity(0.18),
              fontWeight: FontWeight.w900,
            ),
          ),
          TextSpan(text: after),
        ],
      ),
    );
  }
}

class _DesktopTable extends StatelessWidget {
  final List<ToaThuocInfo> list;

  const _DesktopTable({required this.list});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowHeight: 48,
          dataRowMinHeight: 46,
          dataRowMaxHeight: 72,
          headingRowColor:
              WidgetStatePropertyAll(AppColors.primary.withOpacity(0.08)),
          columns: const [
            DataColumn(
                label: Text('STT',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: AppColors.primary))),
            DataColumn(
                label: Text('Tên thuốc',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: AppColors.primary))),
            DataColumn(
                label: Text('Hoạt chất',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: AppColors.primary))),
            DataColumn(
                label: Text('Số lượng',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: AppColors.primary))),
            DataColumn(
                label: Text('Đơn vị',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: AppColors.primary))),
            DataColumn(
                label: Text('Đường dùng',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: AppColors.primary))),
            DataColumn(
                label: Text('Cách dùng',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: AppColors.primary))),
          ],
          rows: list.asMap().entries.map((e) {
            final i = e.key + 1;
            final t = e.value;

            return DataRow(
              cells: [
                DataCell(Text('$i',
                    style: const TextStyle(fontWeight: FontWeight.w800))),
                DataCell(Text(t.tenHang ?? '-',
                    style: const TextStyle(fontWeight: FontWeight.w800))),
                DataCell(Text(t.hoatChat ?? '-')),
                DataCell(Text(t.soLuong ?? '-')),
                DataCell(Text(t.donViTinh ?? '-')),
                DataCell(Text(t.duongDung ?? '-')),
                DataCell(
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 360),
                    child: Text(
                      t.cachDung ?? '-',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
