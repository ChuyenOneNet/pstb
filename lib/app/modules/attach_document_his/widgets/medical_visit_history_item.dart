import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pstb/utils/colors.dart';

import '../../../models/kham_chua_benh_model.dart';

class MedicalVisitHistoryItem extends StatelessWidget {
  final KhamChuaBenhModel visit;
  final VoidCallback onTap;

  const MedicalVisitHistoryItem({
    Key? key,
    required this.visit,
    required this.onTap,
  }) : super(key: key);

  String _formatDate(String? iso) {
    if (iso == null || iso.isEmpty) return '';
    try {
      final dt = DateTime.parse(iso);
      return DateFormat('dd/MM/yyyy HH:mm').format(dt);
    } catch (_) {
      return iso;
    }
  }

  @override
  Widget build(BuildContext context) {
    /// ===== Mapping đúng nghiệp vụ =====
    final String chanDoanChinh = visit.moTaIcd?.trim().isNotEmpty == true
        ? visit.moTaIcd!
        : 'Chưa có chẩn đoán';

    final String chanDoanPhanBiet = visit.chanDoanPhanBiet?.trim() ?? '';

    final String benhKemTheo = visit.benhKemTheo?.trim() ?? '';

    final String thoiGianRa = _formatDate(visit.thoiGianRa);
    final String thoiGianVao = _formatDate(visit.thoiGianVao);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.black.withOpacity(0.06)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.10),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.medical_information,
                color: AppColors.primary,
              ),
            ),

            const SizedBox(width: 10),

            // Nội dung
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Chẩn đoán chính
                  Text(
                    chanDoanChinh,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 14.5,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  // Chẩn đoán phân biệt
                  if (chanDoanPhanBiet.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      'Chẩn đoán PB: $chanDoanPhanBiet',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.65),
                        fontSize: 12.5,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],

                  // Bệnh kèm theo
                  if (benhKemTheo.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      'Bệnh kèm theo: $benhKemTheo',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.6),
                        fontSize: 12.5,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],

                  const SizedBox(height: 6),

                  // Thời gian vào / ra
                  Column(
                    children: [
                      if (thoiGianVao.isNotEmpty)
                        Text(
                          'Vào: $thoiGianVao',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black.withOpacity(0.55),
                          ),
                        ),
                      if (thoiGianRa.isNotEmpty) ...[
                        const SizedBox(width: 10),
                        Text(
                          'Ra: $thoiGianRa',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black.withOpacity(0.55),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),

            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}
