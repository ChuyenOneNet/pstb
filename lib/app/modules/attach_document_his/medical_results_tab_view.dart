import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/models/user_business_model.dart';
import 'package:pstb/utils/colors.dart';
import 'package:pstb/utils/routes.dart';
import 'package:pstb/widgets/stateless/app_bar.dart';

class AdminInfoWithAttachmentPage extends StatelessWidget {
  final UserBusinessModel userBusiness;
  final String dangKyId;
  final String? benhNhanId;

  const AdminInfoWithAttachmentPage({
    super.key,
    required this.userBusiness,
    required this.dangKyId,
    this.benhNhanId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Đính kèm tài liệu HSBA',
        isBack: true,
      ),
      backgroundColor: const Color(0xFFF6F7FB),
      body: SafeArea(
        child: Column(
          children: [
            // ===== CONTENT =====
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _ExpandableSectionCard(
                      title: 'Thông tin hành chính',
                      leading: Icons.badge_outlined,
                      initiallyExpanded: true,
                      child: _KeyValues(
                        items: [
                          _KV('Mã bệnh nhân', userBusiness.ma),
                          _KV('Họ tên', userBusiness.hoTen),
                          _KV(
                            'Giới tính',
                            userBusiness.gioiTinh == 1
                                ? 'Nam'
                                : (userBusiness.gioiTinh == 0 ? 'Nữ' : '-'),
                          ),
                          _KV('Ngày sinh', userBusiness.ngaySinhText),
                          _KV('SĐT', userBusiness.dienThoai),
                          _KV('Địa chỉ', userBusiness.diaChiLienHe),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    _ExpandableSectionCard(
                      title: 'Thông tin điều trị',
                      leading: Icons.local_hospital_outlined,
                      initiallyExpanded: false,
                      child: _KeyValues(
                        items: [
                          _KV('Mã điều trị', '-'),
                          _KV('Loại điều trị', '-'),
                          _KV('Khoa', '-'),
                          _KV('Buồng', '-'),
                          _KV('Giường', '-'),
                          _KV('Thời gian vào', '-'),
                          _KV('Chẩn đoán', '-'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    _ExpandableSectionCard(
                      title: 'Thông tin BHYT',
                      leading: Icons.verified_user_outlined,
                      initiallyExpanded: false,
                      child: _KeyValues(
                        items: [
                          _KV('Số thẻ', userBusiness.maTheBHYT),
                          _KV('Nơi KCB ban đầu', '-'),
                          _KV('Mức hưởng', '-'),
                        ],
                      ),
                    ),

                    const SizedBox(height: 80), // chừa chỗ cho nút
                  ],
                ),
              ),
            ),

            // ===== BUTTON BOTTOM =====
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: benhNhanId != null
                      ? () {
                          Modular.to.pushNamed(
                            AppRoutes.uploadMedicalDocument,
                            arguments: {
                              'dangKyId': dangKyId,
                              'benhNhanId': benhNhanId!,
                            },
                          );
                        }
                      : null,
                  icon: const Icon(Icons.attach_file, color: Colors.white),
                  label: const Text(
                    'Đính kèm tài liệu',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExpandableSectionCard extends StatelessWidget {
  final String title;
  final IconData? leading;
  final Widget child;
  final bool initiallyExpanded;

  const _ExpandableSectionCard({
    required this.title,
    required this.child,
    this.leading,
    this.initiallyExpanded = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [BoxShadow(blurRadius: 10, color: Color(0x11000000))],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Theme(
          // Loại divider mặc định của ExpansionTile để card trông gọn hơn
          data: theme.copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            initiallyExpanded: initiallyExpanded,
            tilePadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            childrenPadding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
            iconColor: AppColors.primary,
            collapsedIconColor: Colors.black54,
            leading: leading == null
                ? null
                : Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.10),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(leading, color: AppColors.primary, size: 18),
                  ),
            title: Text(
              title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
            ),
            children: [child],
          ),
        ),
      ),
    );
  }
}

// ───────────────────────────────────────────────
// Key-Value list (đẹp + divider + tùy chọn ẩn field rỗng)
// ───────────────────────────────────────────────

class _KV {
  final String k;
  final String? v;
  _KV(this.k, this.v);
}

class _KeyValues extends StatelessWidget {
  final List<_KV> items;
  final bool hideEmpty;

  const _KeyValues({
    required this.items,
    this.hideEmpty = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final viewItems = hideEmpty
        ? items
            .where((e) => (e.v ?? '').trim().isNotEmpty && (e.v ?? '-') != '-')
            .toList()
        : items;

    // if (viewItems.isEmpty) {
    //   return const Text(
    //     'Chưa có thông tin',
    //     style: TextStyle(color: Colors.black54, fontStyle: FontStyle.italic),
    //   );
    // }

    return LayoutBuilder(
      builder: (context, constraints) {
        final keyWidth = (constraints.maxWidth * 0.38).clamp(110.0, 170.0);

        return Column(
          children: List.generate(viewItems.length, (i) {
            final e = viewItems[i];
            final raw = (e.v ?? '').trim();
            final isEmpty = raw.isEmpty || raw == '-';
            final displayValue = isEmpty ? '-' : raw;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: keyWidth,
                        child: Text(
                          e.k,
                          style: const TextStyle(
                            color: Colors.black54,
                            height: 1.2,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          displayValue,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            height: 1.2,
                            color: isEmpty ? Colors.black38 : Colors.black87,
                            fontStyle:
                                isEmpty ? FontStyle.italic : FontStyle.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (i != viewItems.length - 1)
                    const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Divider(height: 1, thickness: 0.6),
                    ),
                ],
              ),
            );
          }),
        );
      },
    );
  }
}
