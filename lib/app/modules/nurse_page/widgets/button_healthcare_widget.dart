import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/nurse_page/nurse_searching_store.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';

class ButtonHealthcareWidget extends StatelessWidget {
  const ButtonHealthcareWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 8),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 1.6),
          itemBuilder: (_, index) {
            return CircleWithIcon(
              onTap: () {
                final nurseController = Modular.get<NurseSearchingStore>();
                nurseController.setActionButton(index);
                if (index == 2) {
                  Modular.to.pushNamed(AppRoutes.electronicSignature,
                      arguments: {'userName': null, 'rollCode': null});
                  return;
                }
                if (index == 3) {
                  Modular.to.pushNamed(AppRoutes.therapyInformation);
                  return;
                }
              },
              color: AppColors.transparent,
              colorIcon: AppColors.primary,
              boxSize: widthConvert(context, 55),
              iconSize: widthConvert(context, 55),
              icon: IconEnums.nurseMedical[index],
              title: [
                l10n(context).input_hint_take_care_of,
                l10n(context).paper_healthcare,
                'Tài liệu ký',
                'Tra cứu thông tin điều trị'
              ][index],
            );
          },
          itemCount: IconEnums.nurseMedical.length,
        ));
  }
}
