import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:pstb/app/modules/bottom_nav/bottom_nav_store.dart';
import 'package:pstb/app/modules/bottom_nav/widgets/icon_nav_bar.dart';
import 'package:pstb/app/modules/community/community_page_module.dart';
import 'package:pstb/app/modules/home/home_page.dart';
import 'package:pstb/app/modules/medical_unit/selection_hospital_module.dart';
import 'package:pstb/app/modules/notification/pages/notification_page.dart';
import 'package:pstb/app/modules/profile/profile_module.dart';
import 'package:pstb/app/modules/schedule/schedule_module.dart';
import 'package:pstb/utils/icon_tabbar.dart';
import 'package:pstb/utils/main.dart';

import '../../../constant/config.dart';
import '../../../utils/shared_preferences_manager.dart';
import '../../../widgets/stateless/app_dialog_confirm.dart';
import '../booking_v2/screens/history_screen.dart';
import '../medical_unit/detail_hospital/detail_test.dart';
import '../profile/pages/qr_code_personal/qr_code_personal_dialog.dart';
import '../profile/profile_store.dart';

class BottomNavPage extends StatefulWidget {
  const BottomNavPage({Key? key}) : super(key: key);

  @override
  _BottomNavPageState createState() => _BottomNavPageState();
}

class _BottomNavPageState extends ModularState<BottomNavPage, BottomNavStore> {
  final _profileStore = Modular.get<ProfileStore>();

  @override
  void initState() {
    controller.checkLogin();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userPhone = GetIt.instance<SharedPreferencesManager>()
        .getString(AppConfig.SL_USERNAME);
    return Observer(builder: (context) {
      return WillPopScope(
        onWillPop: () async {
          await _showExitDialog();
          return false;
        },
        child: Scaffold(
          body: Observer(
            builder: (_) {
              return [
                // SelectionHospitalModule()
                DetailHospitalTest(),
                CommunityPageModule(),
                //ScheduleModule(),
                RequestHistoryScreen(userPhone: userPhone ?? ""),
                ProfileModule(),
                const HomePage(),
                const NotificationPage(),
              ].elementAt(controller.currentIndex);
            },
          ),
          floatingActionButton: FloatingActionButton(
            // backgroundColor: Colors.transparent,
            child: controller.currentIndex == 4
                ? const Icon(
                    Icons.qr_code_scanner,
                    size: 40,
                  )
                : SvgPicture.asset(
                    IconEnums.home,
                    width: 30,
                    height: 30,
                    color: AppColors.background,
                  ),
            onPressed: () async {
              await controller.checkLogin();
              if (controller.currentIndex == 4) {
                if (controller.isLogin) {
                  _profileStore.onPushQRCode();
                  if (_profileStore.isGenerateQRCode) {
                    showDialog(
                        context: context, builder: (_) => QRCodePersonalPage());
                  } else {
                    Fluttertoast.showToast(
                        msg: 'Bạn cần hoàn tất thông tin cá nhân');
                    return;
                  }
                } else {
                  showDialog(
                    context: context,
                    builder: (c) => DialogConfirm(
                      title: 'Đăng nhập ứng dụng',
                      subTitle:
                          'Bạn cần đăng nhập hoặc đăng ký để sử dụng chức năng này.',
                      buttonRight: 'Đăng ký',
                      buttonLeft: 'Đăng nhập',
                      onButtonLeft: () {
                        Modular.to.pop(context);
                        Modular.to.pushNamed(AppRoutes.login);
                      },
                      onButtonRight: () {
                        Modular.to.pop(context);
                        Modular.to.pushNamed(AppRoutes.signup);
                      },
                    ),
                  );
                }
              } else {
                if (!controller.isMainPage) {
                  Modular.to.pop();
                }
                controller.updateCheckMainPage(true);
                controller.updateCurrentIndex(4);
              }
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          // bottomNavigationBar: BottomNavBar(controller: controller),
          bottomNavigationBar: FABBottomAppBar(
            onTabSelected: (id) {
              if (!controller.isMainPage) {
                Modular.to.pop();
              }
              controller.updateCheckMainPage(true);
              controller.updateCurrentIndex(id + 1);
            },
            items: [
              FABBottomAppBarItem(
                  iconData: Icons.cabin,
                  text: 'Thông tín',
                  assets: TabIcon.medicalUnit),
              FABBottomAppBarItem(
                  iconData: Icons.layers,
                  text: l10n(context).bottom_bar_community,
                  assets: TabIcon.communityActive),
              FABBottomAppBarItem(
                  iconData: Icons.dashboard,
                  text: l10n(context)!.bottom_bar_calendar,
                  assets: TabIcon.calendarInactive),
              FABBottomAppBarItem(
                  iconData: Icons.info,
                  text: l10n(context).bottom_bar_user,
                  assets: TabIcon.userInactive),
            ],
            notchedShape: const CircularNotchedRectangle(),
            color: AppColors.gray500,
            selectedColor: AppColors.primary,
          ),
          // bottomNavigationBar: ,
        ),
      );
    });
  }

  Future<bool?> _showExitDialog() async {
    return await showDialog<bool>(
      context: context,
      builder: (c) => DialogConfirm(
        title: 'Thoát ứng dụng',
        subTitle: 'Bạn chắc chắn muốn thoát ứng dụng?',
        buttonRight: 'Hủy bỏ',
        buttonLeft: 'Đồng ý',
        onButtonLeft: () {
          // SystemNavigator.pop();
          // exit(1);
          // SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
          SystemNavigator.pop();
          exit(0);
        },
        onButtonRight: () {
          Navigator.of(context, rootNavigator: true).pop();
        },
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final BottomNavStore controller;

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return BottomNavigationBar(
        unselectedFontSize: 0,
        selectedFontSize: 0,
        elevation: 0,
        iconSize: 24,
        onTap: (id) {
          if (!controller.isMainPage) {
            Modular.to.pop();
          }
          controller.updateCheckMainPage(true);
          controller.updateCurrentIndex(id);
        },
        currentIndex: controller.currentIndex,
        items: [
          BottomNavigationBarItem(
            activeIcon: IconNavBar(
              assets: TabIcon.homeActive,
              color: AppColors.primary,
            ),
            icon: IconNavBar(
              assets: TabIcon.homeActive,
              color: AppColors.lightSilver,
            ),
            label: l10n(context).bottom_bar_home,
          ),
          BottomNavigationBarItem(
            activeIcon: IconNavBar(
              assets: TabIcon.communityActive,
              color: AppColors.primary,
            ),
            icon: IconNavBar(
              assets: TabIcon.communityActive,
              color: AppColors.lightSilver,
            ),
            label: l10n(context).bottom_bar_community,
          ),
          BottomNavigationBarItem(
            activeIcon: IconNavBar(
              assets: TabIcon.calendarInactive,
              color: AppColors.primary,
            ),
            icon: IconNavBar(
              assets: TabIcon.calendarInactive,
              color: AppColors.lightSilver,
            ),
            label: l10n(context)!.bottom_bar_calendar,
          ),
          BottomNavigationBarItem(
            activeIcon: IconNavBar(
                assets: TabIcon.userInactive, color: AppColors.primary),
            icon: IconNavBar(
              assets: TabIcon.userInactive,
              color: AppColors.lightSilver,
            ),
            label: l10n(context).bottom_bar_user,
          ),
        ],
      );
    });
  }
}

class FABBottomAppBarItem {
  FABBottomAppBarItem(
      {required this.iconData, required this.text, required this.assets});

  IconData iconData;
  String text;
  String assets;
}

class FABBottomAppBar extends StatefulWidget {
  final List<FABBottomAppBarItem> items;
  final String? centerItemText;
  final double? height;
  final double? iconSize;
  final Color? backgroundColor;
  final Color? color;
  final Color? selectedColor;
  final NotchedShape? notchedShape;
  final ValueChanged<int> onTabSelected;

  const FABBottomAppBar(
      {Key? key,
      required this.items,
      this.centerItemText,
      this.height,
      this.iconSize,
      this.backgroundColor,
      this.color,
      this.selectedColor,
      this.notchedShape,
      required this.onTabSelected})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => FABBottomAppBarState();
}

class FABBottomAppBarState
    extends ModularState<FABBottomAppBar, BottomNavStore> {
  // int _selectedIndex = 0;

  _updateIndex(int index) {
    widget.onTabSelected(index);
    setState(() {
      controller.currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(widget.items.length, (int index) {
      return _buildTabItem(
        item: widget.items[index],
        index: index,
        onPressed: _updateIndex,
      );
    });
    items.insert(items.length >> 1, _buildMiddleTabItem());

    return BottomAppBar(
      shape: widget.notchedShape,
      notchMargin: 10.0,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items,
      ),
      color: widget.backgroundColor ?? Colors.white,
    );
  }

  Widget _buildMiddleTabItem() {
    return Expanded(
      child: SizedBox(
        height: widget.height ?? 50,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: widget.iconSize),
            Text(
              widget.centerItemText ?? '',
              style: TextStyle(color: widget.color),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem({
    required FABBottomAppBarItem item,
    required int index,
    required ValueChanged<int> onPressed,
  }) {
    Color? color;
    // Color? color =
    // controller.currentIndex == index ? widget.selectedColor : widget.color;
    return Observer(builder: (context) {
      if (controller.currentIndex == 4) {
        color = widget.color;
      }
      if (controller.currentIndex == index) {
        color = widget.selectedColor;
      } else {
        color = widget.color;
      }
      return Expanded(
        child: SizedBox(
          height: widget.height,
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              onTap: () => onPressed(index),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Icon(item.iconData, color: color, size: widget.iconSize),
                  SvgPicture.asset(
                    item.assets,
                    color: color,
                    width: 20,
                    height: 20,
                    fit: BoxFit.fill,
                  ),
                  Text(
                    item.text,
                    style: Styles.content.copyWith(color: color, fontSize: 12),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
