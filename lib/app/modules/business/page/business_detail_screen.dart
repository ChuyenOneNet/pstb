import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/models/business_detail_model.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/routes.dart';
import '../../../../widgets/stateless/app_bar.dart';
import '../../../models/user_business_model.dart';
import '../business_store.dart';

class BusinessDetailScreen extends StatefulWidget {
  final String idBusiness;
  BusinessDetailScreen({Key? key, required this.idBusiness});

  @override
  State<BusinessDetailScreen> createState() => _BusinessDetailScreenState();
}

class _BusinessDetailScreenState extends State<BusinessDetailScreen> {
  final store = Modular.get<BusinessStore>();
  UserBusinessModel userBusiness = UserBusinessModel();
  @override
  void initState() {
    super.initState();
    store.loadBusinessDetail(widget.idBusiness);
    userBusiness = store.userBusiness;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Hồ sơ sức khoẻ chi tiết",
        isBack: true,
      ),
      body: Observer(builder: (_) {
        if (store.isLoadingDetail) {
          const Center(child: CircularProgressIndicator());
        }
        final detail = store.businessDetail;
        return detail == null
            ? const Center(child: CircularProgressIndicator())
            : (() {
                final groupedToaThuoc = <String, List<ToaThuocInfo>>{};
                for (final item in detail.toaThuocInfos ?? []) {
                  final key = item.loai ?? 'Không xác định';
                  groupedToaThuoc.putIfAbsent(key, () => []).add(item);
                }
                final groupedXetNghiem = <String, List<XetNghiemInfo>>{};

                for (final info in detail.xetNghiemInfos ?? []) {
                  final loaiId = info.loaiXetNghiemId ?? 'unknown';
                  if (!groupedXetNghiem.containsKey(loaiId)) {
                    groupedXetNghiem[loaiId] = [];
                  }
                  groupedXetNghiem[loaiId]!.add(info);
                }

                // ✅ Trả về UI như bình thường
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // _buildHeader('Đợt KCB ${detail.fromDate} - ${detail.toDate}'),
                      _buildSection('I. THÔNG TIN HÀNH CHÍNH'),
                      _buildGrid([
                        _item('Họ tên', userBusiness.hoTen),
                        _item('Giới tính',
                            userBusiness.gioiTinh == 1 ? "Nam" : "Nữ"),
                        _item('Ngày sinh', userBusiness.ngaySinhText),
                        _item('Tuổi', userBusiness.tuoi),
                        _item('Số thẻ BHYT', userBusiness.maTheBHYT),
                        _item(
                          'Số CCCD',
                          userBusiness.soCmt,
                        ),
                        _item('SĐT liên hệ', userBusiness.dienThoai),
                        _item('Email', "-"),
                        _item('Địa chỉ nơi ở', userBusiness.diaChiLienHe),
                        _item('Đơn vị hành chính',
                            userBusiness.diaChiHanhChinhId),
                      ], 2),
                      _buildSection('II. THÔNG TIN KHÁM'),
                      _buildGrid([
                        _item('Ngày vào viện', detail.ngayVaoVien),
                        _item('Ngày ra viện', detail.ngayRaVien),
                        _item('Mạch (lần/phút)', detail.sinhHieu?.mach),
                        _item('Nhiệt độ (°C)', detail.sinhHieu?.nhietDo),
                        _item('Huyết áp',
                            "${detail.sinhHieu?.huyetApMin} - ${detail.sinhHieu?.huyetApMax}"),
                        _item('Nhịp thở (lần/phút)', detail.sinhHieu?.nhipTho),
                        _item('SpO2 (%)', detail.sinhHieu?.spo2),
                        _item('Chiều cao (cm)', detail.sinhHieu?.chieuCao),
                        _item('Cân nặng (kg)', detail.sinhHieu?.canNang),
                        _item('BMI (kg/m2)', detail.sinhHieu?.bmi),
                        _item('Lý do đến khám', detail.sinhHieu?.lyDoDenKham),
                        _item('Chẩn đoán sơ bộ',
                            detail.sinhHieu?.chanDoanPhanBiet),
                        _item('Bệnh chính', detail.sinhHieu?.benhChinh),
                        _item('Bệnh kèm theo', detail.sinhHieu?.benhKemTheo),
                      ], 2),
                      _buildSection('III. KẾT QUẢ KCB'),
                      _subTitle('III.1. KẾT QUẢ XÉT NGHIỆM'),
                      _buildTable(
                        headers: const ['STT', 'Tên loại xét nghiệm', 'Tác vụ'],
                        rows: groupedXetNghiem.entries
                            .toList()
                            .asMap()
                            .entries
                            .map((entry) {
                          final index = entry.key;
                          final danhSachChiSo = entry.value.value;
                          final tenLoai =
                              danhSachChiSo.first.tenLoaiXetNghiem ??
                                  'Không rõ';

                          return [
                            Text('${index + 1}'),
                            Text(tenLoai),
                            GestureDetector(
                              onTap: () {
                                _showKetQuaXetNghiemDialog(
                                    context, tenLoai, danhSachChiSo);
                              },
                              child: const Text(
                                'Xem KQ',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ];
                        }).toList(),
                      ),

                      _subTitle(
                          'III.2. KẾT QUẢ CHẨN ĐOÁN HÌNH ẢNH - TDCN - CLS CHUNG'),
                      _buildTable(
                        headers: const [
                          'STT',
                          'Tên dịch vụ kỹ thuật',
                          'Kết luận',
                          'Tác vụ',
                        ],
                        rows: detail.urlDataInfos == null ||
                                detail.urlDataInfos!.isEmpty
                            ? [
                                [
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                ]
                              ]
                            : detail.urlDataInfos!.asMap().entries.map((entry) {
                                final index = entry.key;
                                final data = entry.value;
                                return [
                                  Text('${index + 1}'), // STT
                                  Text(data.tenDichVu ?? ""),
                                  Text(data.ketLuan ?? ""),
                                  GestureDetector(
                                    onTap: () {
                                      final originalUrl = data.fileUrl ?? '';
                                      final uri = Uri.tryParse(originalUrl);
                                      final serviceID =
                                          uri?.queryParameters['serviceID'];

                                      if (serviceID != null &&
                                          serviceID.isNotEmpty) {
                                        final redirectUrl =
                                            AppRoutes.businessRadPreview +
                                                serviceID;
                                        Modular.to.pushNamed(
                                            AppRoutes.businessWebViewPdf,
                                            arguments: {'url': redirectUrl});
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text('Lỗi xem kết quả')),
                                        );
                                      }
                                    },
                                    child: const Text(
                                      'Xem KQ',
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  ),
                                ];
                              }).toList(),
                      ),

                      _subTitle('III.3. ĐƠN THUỐC'),
                      _buildTable(
                        headers: const ['STT', 'Loại đơn thuốc', 'Tác vụ'],
                        rows: groupedToaThuoc.entries
                            .toList()
                            .asMap()
                            .entries
                            .map((entry) {
                          final index = entry.key;
                          final loai = entry.value.key;
                          final danhSachThuoc = entry.value.value;

                          return [
                            Text('${index + 1}'),
                            Text(loai),
                            GestureDetector(
                              onTap: () {
                                _showDanhSachThuocDialog(
                                    context, loai, danhSachThuoc);
                              },
                              child: const Text(
                                'Xem KQ',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ];
                        }).toList(),
                      ),

                      _subTitle('III.4. CHI PHÍ KHÁM CHỮA BỆNH'),
                      _buildTable(
                        headers: const [
                          'STT',
                          'Mã tra cứu',
                          'Ngày phát hành',
                          'Tác vụ'
                        ],
                        rows: (detail.vienPhiInfos == null ||
                                detail.vienPhiInfos!.isEmpty)
                            ? [
                                [
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                ]
                              ]
                            : detail.vienPhiInfos!
                                .asMap()
                                .entries
                                .map((e) => [
                                      Text('${e.key + 1}'),
                                      Text(e.value.maGiaoDich ?? ''),
                                      Text(e.value.thoiGian != null &&
                                              e.value.thoiGian!.isNotEmpty
                                          ? DateFormat('dd/MM/yyyy').format(
                                              DateTime.parse(e.value.thoiGian!))
                                          : ''),
                                      GestureDetector(
                                        onTap: () async {
                                          showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (_) => const Center(
                                                child:
                                                    CircularProgressIndicator()),
                                          );

                                          final pdfBase64 =
                                              await store.fetchVienPhiPdfBase64(
                                                  e.value.id ?? '');

                                          Navigator.pop(context);

                                          if (pdfBase64 != null &&
                                              pdfBase64.isNotEmpty) {
                                            try {
                                              final bytes =
                                                  base64Decode(pdfBase64);
                                              showDialog(
                                                context: context,
                                                builder: (_) => Dialog(
                                                  child: SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.9,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.85,
                                                    child: SfPdfViewer.memory(
                                                        bytes),
                                                  ),
                                                ),
                                              );
                                            } catch (e) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                    content: Text(
                                                        'Lỗi giải mã PDF')),
                                              );
                                            }
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                  content: Text(
                                                      'Không có dữ liệu PDF')),
                                            );
                                          }
                                        },
                                        child: const Text(
                                          'Xem KQ',
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                      ),
                                    ])
                                .toList(),
                      )
                    ],
                  ),
                );
              })();
      }),
    );
  }

  void _showDanhSachThuocDialog(
    BuildContext context,
    String loai,
    List<ToaThuocInfo> danhSach,
  ) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text('Danh sách thuốc - Loại: $loai'),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.95,
          height: MediaQuery.of(context).size.height * 0.6,
          child: SingleChildScrollView(
            // Cuộn dọc
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              // Cuộn ngang
              scrollDirection: Axis.horizontal,
              child: Table(
                border: TableBorder.all(color: Colors.grey.shade400),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                columnWidths: const {
                  0: FixedColumnWidth(40), // STT
                  1: FixedColumnWidth(200), // Tên thuốc
                  2: FixedColumnWidth(100), // Số lượng
                  3: FixedColumnWidth(100), // Đơn vị// Liều dùng (ví dụ thêm)
                  4: FixedColumnWidth(200), // Cách dùng (ví dụ thêm)
                },
                children: [
                  // Header
                  TableRow(
                    decoration: const BoxDecoration(color: AppColors.primary),
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('STT',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Tên thuốc',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Số lượng',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Đơn vị',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Cách dùng',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  // Dữ liệu
                  ...danhSach.asMap().entries.map((entry) {
                    final index = entry.key;
                    final thuoc = entry.value;

                    return TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('${index + 1}'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(thuoc.tenHang ?? 'Không rõ'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(thuoc.soLuong ?? '-'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(thuoc.donViTinh ?? '-'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(thuoc.cachDung ?? '-'), // ví dụ thêm
                        ),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Đóng'),
          )
        ],
      ),
    );
  }

  void _showKetQuaXetNghiemDialog(
    BuildContext context,
    String tenLoai,
    List<XetNghiemInfo> danhSach,
  ) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text('Kết quả xét nghiệm - $tenLoai'),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.95,
          height: MediaQuery.of(context).size.height * 0.7,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding: const EdgeInsets.all(8),
                  color: AppColors.primary,
                  width: double.infinity,
                  child: Text(danhSach.first.tenDichVu ?? "-",
                      style:
                          const TextStyle(color: Colors.white, fontSize: 15)),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Table(
                    border: TableBorder.all(color: Colors.grey.shade400),
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    columnWidths: const {
                      0: FixedColumnWidth(200),
                      1: FixedColumnWidth(100),
                      2: FixedColumnWidth(100),
                      3: FixedColumnWidth(80),
                    },
                    children: [
                      TableRow(
                        decoration:
                            const BoxDecoration(color: AppColors.primary),
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Chỉ số',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Kết quả',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Tham chiếu',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Đơn vị',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      ...danhSach.map((xn) => TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(xn.tenChiSo ?? ''),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(xn.giaTri ?? ''),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(xn.normalRange ?? ''),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(xn.donViTinh ?? ''),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Đóng'),
          ),
        ],
      ),
    );
  }

  // void _showInvoiceJsonDialog(BuildContext context, String jsonText) {
  //   final Map<String, dynamic> data = jsonDecode(jsonText);
  //
  //   showDialog(
  //     context: context,
  //     builder: (_) => AlertDialog(
  //       title: const Text('Thông tin hóa đơn'),
  //       content: SizedBox(
  //         width: double.maxFinite,
  //         child: ListView(
  //           shrinkWrap: true,
  //           children: data.entries.map((entry) {
  //             return Padding(
  //               padding: const EdgeInsets.symmetric(vertical: 4.0),
  //               child: Row(
  //                 children: [
  //                   Expanded(flex: 3, child: Text('${entry.key}:')),
  //                   Expanded(flex: 5, child: Text('${entry.value ?? '-'}')),
  //                 ],
  //               ),
  //             );
  //           }).toList(),
  //         ),
  //       ),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.pop(context),
  //           child: const Text('Đóng'),
  //         )
  //       ],
  //     ),
  //   );
  // }
  //
  // Widget _buildHeader(String title) => Padding(
  //       padding: const EdgeInsets.symmetric(vertical: 8),
  //       child: Center(
  //           child: Text(title,
  //               style: const TextStyle(
  //                   fontSize: 16, fontWeight: FontWeight.bold))),
  //     );

  Widget _buildSection(String title) => Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(8),
        color: AppColors.primary,
        width: double.infinity,
        child: Text(title,
            style: const TextStyle(color: Colors.white, fontSize: 15)),
      );

  Widget _subTitle(String title) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Text(title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black)),
      );

  Widget _item(String label, String? value) => Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                )),
            // const SizedBox(height: 4),
            Container(
              //padding: const EdgeInsets.all(8),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                value ?? '-',
                style: const TextStyle(fontSize: 14),
                overflow: TextOverflow.ellipsis,
                maxLines: 5,
              ),
            ),
            // const SizedBox(height: 12),
          ],
        ),
      );

  // Widget _buildGrid(List<Widget> children, int columnCount) {
  //   return GridView.count(
  //     crossAxisCount: columnCount,
  //     shrinkWrap: true,
  //     physics: const NeverScrollableScrollPhysics(),
  //     childAspectRatio: 3.5,
  //     padding: const EdgeInsets.symmetric(horizontal: 4),
  //     children: children,
  //   );
  // }
  Widget _buildGrid(List<Widget> children, int columnCount) {
    List<Row> rows = [];
    for (int i = 0; i < children.length; i += columnCount) {
      rows.add(Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(columnCount, (index) {
          int childIndex = i + index;
          if (childIndex >= children.length) {
            return Expanded(child: SizedBox()); // placeholder nếu thiếu cột
          }
          return Expanded(child: children[childIndex]);
        }),
      ));
    }

    return Column(
      children: rows
          .map((r) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: r,
              ))
          .toList(),
    );
  }

  Widget _buildTable({
    required List<String> headers,
    required List<List<Widget>> rows,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Table(
        columnWidths: const {},
        border: TableBorder.all(color: Colors.grey.shade400),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          TableRow(
            decoration: const BoxDecoration(color: AppColors.primary),
            children: headers
                .map((h) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(h,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ))
                .toList(),
          ),
          ...rows.map((row) => TableRow(
                children: row
                    .map((cell) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: cell,
                        ))
                    .toList(),
              )),
        ],
      ),
    );
  }
}
