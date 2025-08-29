import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/home/prominet_doctor/prominent_doctor_widget.dart';
import 'package:pstb/app/modules/home/widgets/category/package_category.dart';
import 'package:pstb/app/modules/home/widgets/header/app_bar_home_page_widget.dart';
import 'package:pstb/app/modules/home/widgets/section_health_new/section_health_new.dart';
import 'package:pstb/app/modules/home/widgets/section_promote_new/section_promote_new.dart';
import 'package:pstb/app/modules/home/widgets/shortcut_menu/shortcut.dart';
import 'package:pstb/app/modules/shared/widgets/btns.dart';
import 'package:pstb/app/modules/shortcut_menu/widget/shortcut_menu.dart';
import 'package:pstb/app/modules/shortcut_menu/widget/shortcut_menu_customer.dart';
import 'package:pstb/app/modules/shortcut_menu/widget/shortcut_menu_staff.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/app_button.dart';
import 'home_store.dart';
import 'widgets/category/detail_package_group/detail_package_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = Modular.get<HomeStore>();
  final detailController = Modular.get<DetailPackageStore>();

  @override
  void initState() {
    controller.changeBuildContext(context);
    controller.getInfoUnit();
    controller.initHomeStore();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.initHomeStore();
        },
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          padding: EdgeInsets.zero,
          child: Stack(
            children: [
              Container(
                height: controller.isLogin
                    ? MediaQuery.of(context).size.height / 3
                    : MediaQuery.of(context).size.height / 4 + 30,
                decoration: const BoxDecoration(
                    // color: HexColor('02457A'),
                    // color: Colors.blue,
                    color: AppColors.primary,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(48.0),
                      bottomRight: Radius.circular(48.0),
                    )),
              ),
              Column(
                children: [
                  AppBarHomePageWidget(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 12.0,
                      ),
                      Observer(builder: (context) {
                        return controller.isLogin
                            ? const SizedBox()
                            : Container(
                                padding: const EdgeInsets.all(16.0),
                                margin: const EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        ViewConstants.defaultBorderRadius),
                                child: Row(
                                  children: [
                                    Expanded(child: LogInBtn()),
                                    const SizedBox(width: 16.0),
                                    const Expanded(child: SignInBtn())
                                  ],
                                ),
                              );
                      }),
                      ShortcutMenuWidget(),
                      const PackageCategoryWidget(),
                      const ProminentDoctorWidget(),
                      //SliderHome(),
                      PromotionNewsSection(),
                      const SectionHealthNew(),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
