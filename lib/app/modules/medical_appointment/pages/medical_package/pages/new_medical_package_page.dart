import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pstb/utils/colors.dart';
import 'package:pstb/utils/constants.dart';
import 'package:pstb/utils/styles.dart';
import 'package:pstb/utils/icons.dart';
import 'package:pstb/widgets/stateful/stateful_widget.dart';
import '../../../../../../utils/routes.dart';

class NewMedicalPackagePage extends StatelessWidget {
  const NewMedicalPackagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Modular.to.pop();
          },
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: SvgPicture.asset(
              IconEnums.yellowArrow,
              color: AppColors.background,
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: Text('Danh sách gói khám',
            style: Styles.heading4.copyWith(color: AppColors.background)),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg_success.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    child: AspectRatio(
                        aspectRatio: 569 / 748,
                        child: TouchableOpacity(
                          onTap: () {
                            Modular.to.pushNamed(AppRoutes.medicalAppointment,
                                arguments: {
                                  'categoryGroupId':
                                      // "${PackageCategoryGroup.TU_VAN_TAI_CO_SO_Y_TE.toString()};${PackageCategoryGroup.TU_VAN.toString()}"
                                      "${PackageCategoryGroup.DAT_KHAM_THUONG_QUY}"
                                });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            child: SvgPicture.asset(IconEnums.medicalFacil),
                          ),
                        )),
                  ),
                  Expanded(
                    child: AspectRatio(
                        aspectRatio: 569 / 748,
                        child: TouchableOpacity(
                          onTap: () {
                            Modular.to.pushNamed(AppRoutes.medicalAppointment,
                                arguments: {
                                  'categoryGroupId': PackageCategoryGroup
                                      .TU_VAN_TAI_CO_SO_Y_TE
                                      .toString()
                                });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            child: SvgPicture.asset(IconEnums.medicalByDoctor),
                          ),
                        )),
                  ),
                  Expanded(
                    child: AspectRatio(
                        aspectRatio: 569 / 748,
                        child: TouchableOpacity(
                          onTap: () {
                            Modular.to.pushNamed(AppRoutes.medicalAppointment,
                                arguments: {
                                  'categoryGroupId':
                                      PackageCategoryGroup.TU_VAN.toString()
                                });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            child:
                                SvgPicture.asset(IconEnums.medicalHomeDoctor),
                          ),
                        )),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
