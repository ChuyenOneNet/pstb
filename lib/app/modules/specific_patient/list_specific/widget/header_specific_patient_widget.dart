import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pstb/app/modules/specific_patient/list_specific/list_specific_store.dart';
import 'package:pstb/utils/colors.dart';
import 'package:pstb/utils/gender_utils.dart';
import 'package:pstb/utils/icons.dart';
import 'package:pstb/utils/styles.dart';
import 'package:pstb/widgets/stateless/item_text_row.dart';
import 'package:qr_flutter/qr_flutter.dart';

class HeaderSpecificPatientWidget extends StatelessWidget {
  const HeaderSpecificPatientWidget({
    Key? key,
    required ListSpecificStore controller,
  })  : _controller = controller,
        super(key: key);

  final ListSpecificStore _controller;

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
                              child: QrImageView(
                                data: '${_controller.patientQrModel?.code}#',
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
                  title: 'Mã BN: ',
                  content: _controller.patientQrModel?.name ?? ""),
              ItemTextRow(
                  title: 'Tên BN: ',
                  content: _controller.patientQrModel?.code ?? ""),
              ItemTextRow(
                  title: 'Khoa/Phòng: ',
                  content: _controller.departmentModel?.name ?? ""),
              ItemTextRow(
                  title: 'Giới tính: ',
                  content: GenderUtils.parseGender(
                      _controller.patientQrModel?.gender ?? 0)),
            ],
          ),
        ],
      ),
    );
  }
}
