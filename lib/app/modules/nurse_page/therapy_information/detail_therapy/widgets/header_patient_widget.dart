import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pstb/app/modules/nurse_page/therapy_information/detail_therapy/detail_therapy_store.dart';
import 'package:pstb/app/modules/nurse_page/therapy_information/therapy_information_page.dart';
import 'package:pstb/app/modules/nurse_page/therapy_information/therapy_information_store.dart';
import 'package:pstb/utils/gender_utils.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/item_text_row.dart';
import 'package:qr_flutter/qr_flutter.dart' as qr_flutter;
import 'package:qr_flutter/qr_flutter.dart';

class HeaderPatientWidget extends StatelessWidget {
  HeaderPatientWidget({Key? key}) : super(key: key);
  final _detailTherapy = Modular.get<DetailTherapyStore>();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Styles.cardShadow.copyWith(
          color: AppColors.background, borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Thông tin bệnh nhân',
                style: Styles.titleItem,
              ),
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (_) => Dialog(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: qr_flutter.QrImageView(
                                data: '${_detailTherapy.patientModel.code}#',
                                version: QrVersions.auto,
                              ),
                            ),
                          ));
                },
                child: SvgPicture.asset(
                  IconEnums.qrCode1,
                  color: AppColors.black,
                  width: 28,
                ),
              ),
            ],
          ),
          const Divider(
            color: AppColors.primary,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ItemTextRow(
                  title: 'Khoa/Phòng: ',
                  content: _detailTherapy.patientModel.departmentName ?? ""),
              ItemTextRow(
                  title: 'Mã BN: ',
                  content: _detailTherapy.patientModel.code ?? ""),
              ItemTextRow(
                  title: 'Tên BN: ',
                  content: _detailTherapy.patientModel.name ?? ""),
              ItemTextRow(
                  title: 'Tuổi: ',
                  content: _detailTherapy.patientModel.age ?? ""),
              ItemTextRow(
                  title: 'Giới tính: ',
                  content: GenderUtils.parseGender(
                      _detailTherapy.patientModel.gender ?? 0)),
            ],
          ),
        ],
      ),
    );
  }
}
