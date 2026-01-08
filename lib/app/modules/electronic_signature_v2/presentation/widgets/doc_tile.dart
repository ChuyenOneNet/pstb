import 'package:flutter/material.dart';
import 'package:pstb/app/models/electronic_signature_model.dart';
import '../../../../../../constant/color.dart';
import '../../data/signing_status.dart';
import 'package:intl/intl.dart';

class DocTile extends StatefulWidget {
  final DocumentModel item;
  final VoidCallback? onTap;

  // selection
  final bool selectionMode;
  final bool isSelected;
  final ValueChanged<bool>? onSelectionChanged;

  const DocTile({
    super.key,
    required this.item,
    this.onTap,
    this.selectionMode = false,
    this.isSelected = false,
    this.onSelectionChanged,
  });

  @override
  State<DocTile> createState() => _DocTileState();
}

class _DocTileState extends State<DocTile> with SingleTickerProviderStateMixin {
  late AnimationController _hoverCtrl;
  late Animation<double> _elevationAnim;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _hoverCtrl = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    _elevationAnim = Tween<double>(begin: 2, end: 8)
        .animate(CurvedAnimation(parent: _hoverCtrl, curve: Curves.easeOut));
    _scaleAnim = Tween<double>(begin: 1, end: 1.02)
        .animate(CurvedAnimation(parent: _hoverCtrl, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _hoverCtrl.dispose();
    super.dispose();
  }

  Color _getStatusColor(int? status) {
    switch (status) {
      case 0:
        return const Color(0xFFF59E0B);
      case 1:
        return const Color(0xFF10B981);
      default:
        return const Color(0xFF9CA3AF);
    }
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return 'N/A';
    try {
      DateTime date;
      if (dateStr.contains('-')) {
        date = DateTime.parse(dateStr);
      } else {
        date = DateFormat('dd/MM/yyyy').parse(dateStr);
      }
      return DateFormat('dd/MM/yyyy').format(date);
    } catch (_) {
      return dateStr;
    }
  }

  Widget _buildStatusBadge(int? status) {
    final color = _getStatusColor(status);
    final label = mapIntToLabel(status) ?? 'Không xác định';

    final badge = Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.25), width: 1),
      ),
      child: Text(label,
          style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: color,
              letterSpacing: 0.2)),
    );

    if (status == 1) {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          badge,
          Positioned(
            right: -4,
            bottom: -4,
            child: Container(
              padding: const EdgeInsets.all(1),
              decoration: const BoxDecoration(
                  color: Colors.white, shape: BoxShape.circle),
              child: Icon(Icons.check_circle, size: 14, color: color),
            ),
          ),
        ],
      );
    }
    return badge;
  }

  Widget _meta({required IconData icon, required String label}) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: const Color(0xFF9CA3AF)),
          const SizedBox(width: 6),
          Flexible(
              child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF6B7280),
                fontWeight: FontWeight.w500,
                letterSpacing: -0.2),
          )),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _hoverCtrl,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnim.value,
          child: Material(
            color: AppColors.whiteColor,
            child: InkWell(
              onTap: widget.selectionMode
                  ? () => widget.onSelectionChanged?.call(!widget.isSelected)
                  : (widget.onTap ??
                      () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'Xem chi tiết: ${widget.item.documentTypeCode}')),
                        );
                      }),
              onLongPress: () => widget.onSelectionChanged
                  ?.call(true), // long-press => bật chọn
              onHover: (h) => h ? _hoverCtrl.forward() : _hoverCtrl.reverse(),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: widget.isSelected
                      ? const Color(0xFFEFF6FF)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: widget.isSelected
                      ? Border.all(color: const Color(0xFF1E7FFF), width: 1.5)
                      : null,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.18),
                        blurRadius: _elevationAnim.value,
                        offset: Offset(0, _elevationAnim.value * 0.5))
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (widget.selectionMode)
                                Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Checkbox(
                                    activeColor: AppColors.primaryColor,
                                    value: widget.isSelected,
                                    onChanged: (v) => widget.onSelectionChanged
                                        ?.call(v ?? false),
                                  ),
                                ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      const Color(0xFF1E7FFF).withOpacity(0.15),
                                      const Color(0xFF1E7FFF).withOpacity(0.08)
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(Icons.description,
                                    color: Color(0xFF1E7FFF), size: 22),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Text(
                                  widget.item.documentTypeName ??
                                      widget.item.documentTypeCode ??
                                      'Tài liệu',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF1F2937),
                                      letterSpacing: -0.3),
                                ),
                              ),
                              const SizedBox(width: 12),
                              _buildStatusBadge(widget.item.signingStatus),
                            ]),
                        const SizedBox(height: 14),
                        Wrap(
                          spacing: 16,
                          runSpacing: 8,
                          children: [
                            _meta(
                                icon: Icons.person,
                                label: widget.item.patientName ??
                                    'Không xác định'),
                            _meta(
                                icon: Icons.domain,
                                label: widget.item.departmentName ??
                                    'Không xác định'),
                            _meta(
                                icon: Icons.calendar_today,
                                label:
                                    'Tạo: ${_formatDate(widget.item.createdDate)}'),
                            if (widget.item.signingStatus == 1)
                              _meta(
                                  icon: Icons.calendar_today,
                                  label:
                                      'Ký: ${_formatDate(widget.item.signedDate)}'),
                          ],
                        ),
                        const SizedBox(height: 12),
                      ]),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
