import 'package:flutter/material.dart';
import 'package:pstb/app/models/business_detail_model.dart';
import '../../../../../../../utils/colors.dart';

/// Image Diagnosis Card Component
class ImageCard extends StatelessWidget {
  final UrlDataInfo data;
  final VoidCallback onShowPdf;
  final VoidCallback onShowPacs;

  const ImageCard({
    Key? key,
    required this.data,
    required this.onShowPdf,
    required this.onShowPacs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ===== HEADER =====
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.08),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.medical_services,
                    size: 20, color: AppColors.primary),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    data.tenDichVu ?? 'Chẩn đoán hình ảnh',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ===== BODY =====
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (data.ketLuan != null && data.ketLuan!.isNotEmpty) ...[
                  Text(
                    'Kết luận',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      data.ketLuan!,
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                  const SizedBox(height: 14),
                ],

                // ===== ACTIONS =====
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (data.pdfBase64 != null && data.pdfBase64!.isNotEmpty)
                      _buildActionButton(
                        icon: Icons.picture_as_pdf,
                        label: 'Xem PDF',
                        color: AppColors.primary,
                        onTap: onShowPdf,
                      ),
                    if (data.fileUrl != null && data.fileUrl!.isNotEmpty) ...[
                      const SizedBox(width: 10),
                      _buildActionButton(
                        icon: Icons.open_in_new,
                        label: 'Xem PACS',
                        color: Colors.blue,
                        onTap: onShowPacs,
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
