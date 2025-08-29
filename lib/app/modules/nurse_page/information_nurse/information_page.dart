import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pstb/app/modules/bottom_nav/bottom_nav_page.dart';
import 'package:pstb/app/modules/nurse_page/nurse_searching_store.dart';
import 'package:pstb/utils/hex_color.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/utils/styles.dart';
import 'package:pstb/utils/time_util.dart';
import 'package:pstb/widgets/stateless/app_bar.dart';
import 'package:pstb/widgets/stateless/button_back.dart';
import 'package:pstb/widgets/stateless/item_text_row.dart';

class InformationNursePage extends StatefulWidget {
  InformationNursePage({Key? key}) : super(key: key);

  @override
  State<InformationNursePage> createState() => _InformationNursePageState();
}

class _InformationNursePageState extends State<InformationNursePage> {
  final nurseController = Modular.get<NurseSearchingStore>();

  @override
  void initState() {
    // TODO: implement initState
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      await nurseController.initState();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 16.0,
                  right: 16.0,
                  top: 50,
                  bottom: MediaQuery.of(context).viewPadding.bottom + 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: Styles.cardShadow.copyWith(
                      color: AppColors.background, borderRadius: BorderRadius.circular(8),),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Thông tin nhân viên y tế',
                              style: Styles.titleItem,
                            ),
                          ],
                        ),
                        const Divider(
                          color: AppColors.primary,
                        ),
                        Observer(
                            builder: (context) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ItemTextRow(title: 'Thời gian: ',content: TimeUtil.format(DateTime.now(), TimeUtil.HHMMDDMMYYYY)),
                                  ItemTextRow(title: 'Mã NVYT: ', content: nurseController.codeNurse ?? ''),
                                  ItemTextRow(title: 'Tên NVYT: ', content: nurseController.nameNurse ?? ''),
                                ],
                              );
                            }
                        ),
                      ],
                    ),
                  ),
                  SvgPicture.asset(IconEnums.healthTeam),
                  const SizedBox(
                    height: 48.0,
                  )
                ],
              ),
            ),
            const ButtonBackWidget(),
          ],
        ),
      ),
    );
  }
}
