import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/widgets/stateless/custom_tabbar.dart';
import 'package:mobx/mobx.dart';
import 'package:pstb/app/app_store.dart';
import 'package:pstb/app/modules/auth_guard/auth_guard_page.dart';
import 'package:pstb/app/modules/schedule/page/schedule_completed_page.dart';
import 'package:pstb/app/modules/schedule/page/schedule_upcoming_page.dart';
import 'package:pstb/utils/main.dart';
import '../../route_guard.dart';

import 'schedule_store.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage>
    with TickerProviderStateMixin {
  final ScheduleStore _scheduleStore = Modular.get<ScheduleStore>();
  final PageController pageViewController = PageController(initialPage: 0);
  final UserGuard _userGuard = UserGuard();
  final AppStore _appStore = Modular.get<AppStore>();
  late TabController _tabController;
  late final List<Tab> _tab = const [
    Tab(
      text: 'Chưa diễn ra',
    ),
    Tab(
      text: 'Đã diễn ra',
    ),
  ];

  void checkLogin() async {
    UserStatus isLogin = await _userGuard.canActivate();
    if (isLogin == UserStatus.Signed) {
      _scheduleStore.getAllBooking();
    }
    _scheduleStore.setIsLogin(isLogin);
  }

  @override
  void initState() {
    _scheduleStore.setContext(context);
    reaction((_) => _appStore.reload, (__) {
      _scheduleStore.setIsLogin(UserStatus.Checking);
      checkLogin();
    });
    _scheduleStore.onPageChange(0);
    checkLogin();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.animateTo(0);
    super.initState();
  }

  @override
  void dispose() {
    pageViewController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        if (_scheduleStore.isLogin == UserStatus.Checking) {
          return const SizedBox();
        }
        if (_scheduleStore.isLogin == UserStatus.NoData) {
          return AuthGuardPage();
        }
        return WillPopScope(
          onWillPop: () {
            if (Platform.isAndroid) {
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            }
            return Future.value(false);
          },
          child: SafeArea(
            child: Column(
              children: [
                TabbarWithContainer(
                  tabController: _tabController,
                  tabs: _tab,
                  onTap: (index) {},
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: const [
                      ScheduleUpcomingPage(),
                      ScheduleCompletedPage(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
