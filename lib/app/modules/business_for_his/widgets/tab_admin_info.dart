// import 'package:flutter/material.dart';
// import 'package:pstb/app/models/user_business_model.dart';
// import 'package:pstb/app/modules/business_for_his/widgets/shared_widget/expandable_section.dart';
// import 'package:pstb/app/modules/business_for_his/widgets/shared_widget/info_card.dart';
//
// import '../../../../../utils/colors.dart';
//
// /// TAB 1: THÔNG TIN HÀNH CHÍNH
// class TabAdminInfo extends StatefulWidget {
//   final UserBusinessModel userBusiness;
//
//   const TabAdminInfo({Key? key, required this.userBusiness}) : super(key: key);
//
//   @override
//   State<TabAdminInfo> createState() => _TabAdminInfoState();
// }
//
// class _TabAdminInfoState extends State<TabAdminInfo> {
//   bool _isExpanded = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       child: ExpandableSection(
//         title: 'I. THÔNG TIN HÀNH CHÍNH',
//         isExpanded: _isExpanded,
//         onToggle: () => setState(() => _isExpanded = !_isExpanded),
//         children: [
//           InfoCard(
//             children: [
//               _buildInfoRow('Họ tên', widget.userBusiness.hoTen),
//               _buildInfoRow('Giới tính',
//                   widget.userBusiness.gioiTinh == 1 ? "Nam" : "Nữ"),
//               _buildInfoRow('Ngày sinh', widget.userBusiness.ngaySinhText),
//               _buildInfoRow('Tuổi', widget.userBusiness.tuoi),
//               _buildInfoRow('Số BHYT', widget.userBusiness.maTheBHYT),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildInfoRow(String label, String? value) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Text(
//           label,
//           style: TextStyle(
//             fontWeight: FontWeight.w600,
//             fontSize: 13,
//             color: Colors.grey[600],
//             letterSpacing: 0.2,
//           ),
//         ),
//         const SizedBox(width: 12),
//         Expanded(
//           child: Text(
//             value ?? '-',
//             style: TextStyle(
//               fontWeight: FontWeight.w700,
//               fontSize: 13,
//               color: Colors.grey[900],
//             ),
//             textAlign: TextAlign.end,
//             overflow: TextOverflow.ellipsis,
//           ),
//         ),
//       ],
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:pstb/app/models/user_business_model.dart';
//
// import '../../../../../utils/colors.dart'; // AppColors
//
// /// TAB 1: THÔNG TIN HÀNH CHÍNH
// class TabAdminInfo extends StatelessWidget {
//   final UserBusinessModel userBusiness;
//
//   const TabAdminInfo({super.key, required this.userBusiness});
//
//   @override
//   Widget build(BuildContext context) {
//     final headerTitle = _nz(userBusiness.hoTen, fallback: '-');
//
//     final subtitleParts = <String>[
//       userBusiness.gioiTinh == 1
//           ? 'Nam'
//           : (userBusiness.gioiTinh == 0 ? 'Nữ' : '-'),
//       '${_nz(userBusiness.tuoi, fallback: '-')} tuổi',
//       _fmtDob(userBusiness.ngaySinhText),
//     ].where((e) => e.trim().isNotEmpty && e != '-').toList();
//
//     final subtitle = subtitleParts.join(' • ');
//
//     final bhytBadge = _nz(userBusiness.maTheBHYT, fallback: 'Không có BHYT');
//
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(12),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Header giống inpatient
//           // _HeaderCard(
//           //   title: headerTitle,
//           //   subtitle: subtitle,
//           //   badge: bhytBadge,
//           // ),
//           // const SizedBox(height: 12),
//
//           // Section 1: Thông tin hành chính cơ bản
//           _SectionCard(
//             title: 'Thông tin hành chính',
//             child: _KeyValues(
//               items: [
//                 _KV('Mã bệnh nhân', userBusiness.ma),
//                 _KV('Họ tên', userBusiness.hoTen),
//                 _KV(
//                     'Giới tính',
//                     userBusiness.gioiTinh == 1
//                         ? 'Nam'
//                         : (userBusiness.gioiTinh == 0 ? 'Nữ' : '-')),
//                 _KV('Ngày sinh', _fmtDob(userBusiness.ngaySinhText)),
//                 _KV('SĐT', userBusiness.dienThoai), // fake: chưa có trong model
//                 _KV('Địa chỉ', userBusiness.diaChiLienHe), // fake
//               ],
//             ),
//           ),
//
//           const SizedBox(height: 12),
//           _SectionCard(
//             title: 'Thông tin điều trị',
//             child: _KeyValues(items: [
//               _KV('Mã điều trị', "-"),
//               _KV('Loại điều trị', "-"),
//               _KV('Khoa', "-"),
//               _KV('Mã khoa', "-"),
//               _KV('Buồng', "-"),
//               _KV('Mã buồng', "-"),
//               _KV('Giường', "-"),
//               _KV('Thời gian vào', "-"),
//               _KV('Can thiệp', "-"),
//               _KV('Loại khám (ExamType)', "-"),
//               _KV('Chẩn đoán (ICD)', "-"),
//               _KV('Chẩn đoán phụ', "-"),
//               _KV('Tiền sử bệnh', "-"),
//             ]),
//           ),
//
//           const SizedBox(height: 12),
//           // Section 2: Thông tin BHYT (giống inpatient)
//           _SectionCard(
//             title: 'Thông tin BHYT',
//             child: _KeyValues(
//               items: [
//                 _KV('Số thẻ', userBusiness.maTheBHYT),
//                 _KV('Nơi KCB ban đầu', null), // fake
//                 _KV('Mã nơi KCB', null), // fake
//                 _KV('Giá trị từ', null), // fake
//                 _KV('Đến', null), // fake
//                 _KV('Mức hưởng', null), // fake: 80%, 100%,...
//               ],
//             ),
//           ),
//
//           const SizedBox(height: 16),
//
//           // Section 3: Thông tin bổ sung (fake để giống cấu trúc dài)
//         ],
//       ),
//     );
//   }
//
//   String _nz(String? value, {required String fallback}) {
//     final s = (value ?? '').trim();
//     return s.isEmpty ? fallback : s;
//   }
//
//   String _fmtDob(String? raw) {
//     final s = (raw ?? '').trim();
//     if (s.isEmpty) return '-';
//     // Có thể cải thiện parse ngày nếu backend trả ISO hoặc định dạng khác
//     return s;
//   }
// }
//
// // ───────────────────────────────────────────────
// // Các widget chung (giữ nguyên từ phiên bản trước)
// // ───────────────────────────────────────────────
//
// class _HeaderCard extends StatelessWidget {
//   final String title;
//   final String subtitle;
//   final String badge;
//
//   const _HeaderCard({
//     required this.title,
//     required this.subtitle,
//     required this.badge,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(14),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(14),
//         boxShadow: const [BoxShadow(blurRadius: 10, color: Color(0x11000000))],
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 44,
//             height: 44,
//             decoration: BoxDecoration(
//               color: AppColors.primary.withOpacity(0.12),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: const Icon(Icons.person, color: AppColors.primary),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                   style: const TextStyle(
//                       fontSize: 16, fontWeight: FontWeight.w700),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(subtitle, style: const TextStyle(color: Colors.black54)),
//               ],
//             ),
//           ),
//           const SizedBox(width: 8),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//             decoration: BoxDecoration(
//               color: AppColors.primary,
//               borderRadius: BorderRadius.circular(999),
//             ),
//             child: Text(
//               badge,
//               style: const TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.w600,
//                   fontSize: 12),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _SectionCard extends StatelessWidget {
//   final String title;
//   final Widget child;
//
//   const _SectionCard({required this.title, required this.child, super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(14),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(14),
//         boxShadow: const [BoxShadow(blurRadius: 10, color: Color(0x11000000))],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(title,
//               style:
//                   const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
//           const SizedBox(height: 10),
//           child,
//         ],
//       ),
//     );
//   }
// }
//
// class _KV {
//   final String k;
//   final String? v;
//   _KV(this.k, this.v);
// }
//
// class _KeyValues extends StatelessWidget {
//   final List<_KV> items;
//
//   const _KeyValues({required this.items, super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final filtered = items
//         .where((e) => (e.v ?? '').trim().isNotEmpty && (e.v ?? '-') != '-')
//         .toList();
//
//     // if (filtered.isEmpty) {
//     //   return const Text(
//     //     'Chưa có thông tin',
//     //     style: TextStyle(color: Colors.black54, fontStyle: FontStyle.italic),
//     //   );
//     // }
//
//     return Column(
//       children: items.map((e) {
//         final displayValue = (e.v ?? '').trim().isEmpty ? '-' : e.v!;
//         return Padding(
//           padding: const EdgeInsets.only(bottom: 8),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 width: 128,
//                 child: Text(e.k, style: const TextStyle(color: Colors.black54)),
//               ),
//               const SizedBox(width: 8),
//               Expanded(
//                 child: Text(
//                   displayValue,
//                   style: const TextStyle(fontWeight: FontWeight.w600),
//                 ),
//               ),
//             ],
//           ),
//         );
//       }).toList(),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:pstb/app/models/user_business_model.dart';

import '../../../../../utils/colors.dart'; // AppColors

/// TAB 1: THÔNG TIN HÀNH CHÍNH
class TabAdminInfo extends StatelessWidget {
  final UserBusinessModel userBusiness;

  const TabAdminInfo({super.key, required this.userBusiness});

  @override
  Widget build(BuildContext context) {
    final headerTitle = _nz(userBusiness.hoTen, fallback: '-');

    final subtitleParts = <String>[
      userBusiness.gioiTinh == 1
          ? 'Nam'
          : (userBusiness.gioiTinh == 0 ? 'Nữ' : '-'),
      '${_nz(userBusiness.tuoi, fallback: '-')} tuổi',
      _fmtDob(userBusiness.ngaySinhText),
    ].where((e) => e.trim().isNotEmpty && e != '-').toList();

    final subtitle = subtitleParts.isEmpty ? '-' : subtitleParts.join(' • ');
    final bhytBadge = _nz(userBusiness.maTheBHYT, fallback: 'Không có BHYT');

    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // _HeaderCard(
          //   title: headerTitle,
          //   subtitle: subtitle,
          //   badge: bhytBadge,
          // ),
          // const SizedBox(height: 12),
          _ExpandableSectionCard(
            title: 'Thông tin hành chính',
            leading: Icons.badge_outlined,
            initiallyExpanded: true,
            child: _KeyValues(
              hideEmpty: false, // đang có placeholder '-' => giữ lại
              items: [
                _KV('Mã bệnh nhân', userBusiness.ma),
                _KV('Họ tên', userBusiness.hoTen),
                _KV(
                  'Giới tính',
                  userBusiness.gioiTinh == 1
                      ? 'Nam'
                      : (userBusiness.gioiTinh == 0 ? 'Nữ' : '-'),
                ),
                _KV('Ngày sinh', _fmtDob(userBusiness.ngaySinhText)),
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
              hideEmpty: false,
              items: [
                _KV('Mã điều trị', "-"),
                _KV('Loại điều trị', "-"),
                _KV('Khoa', "-"),
                _KV('Mã khoa', "-"),
                _KV('Buồng', "-"),
                _KV('Mã buồng', "-"),
                _KV('Giường', "-"),
                _KV('Thời gian vào', "-"),
                _KV('Can thiệp', "-"),
                _KV('Loại khám (ExamType)', "-"),
                _KV('Chẩn đoán (ICD)', "-"),
                _KV('Chẩn đoán phụ', "-"),
                _KV('Tiền sử bệnh', "-"),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _ExpandableSectionCard(
            title: 'Thông tin BHYT',
            leading: Icons.verified_user_outlined,
            initiallyExpanded: false,
            child: _KeyValues(
              hideEmpty:
                  false, // BHYT thường thiếu nhiều field => ẩn rỗng cho gọn
              items: [
                _KV('Số thẻ', userBusiness.maTheBHYT),
                _KV('Nơi KCB ban đầu', "-"),
                _KV('Mã nơi KCB', "-"),
                _KV('Giá trị từ', "-"),
                _KV('Đến', "-"),
                _KV('Mức hưởng', "-"),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  String _nz(String? value, {required String fallback}) {
    final s = (value ?? '').trim();
    return s.isEmpty ? fallback : s;
  }

  String _fmtDob(String? raw) {
    final s = (raw ?? '').trim();
    if (s.isEmpty) return '-';
    return s;
  }
}

// ───────────────────────────────────────────────
// UI: Header + Expandable Section Card
// ───────────────────────────────────────────────

class _HeaderCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String badge;

  const _HeaderCard({
    required this.title,
    required this.subtitle,
    required this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [BoxShadow(blurRadius: 10, color: Color(0x11000000))],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.person, color: AppColors.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.black54, height: 1.2),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          _PillChip(text: badge),
        ],
      ),
    );
  }
}

class _PillChip extends StatelessWidget {
  final String text;
  const _PillChip({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 150),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 12,
          height: 1.1,
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
