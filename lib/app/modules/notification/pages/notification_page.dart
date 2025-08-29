import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pstb/app/modules/bottom_nav/bottom_nav_page.dart';
import 'package:pstb/app/modules/bottom_nav/bottom_nav_store.dart';
import 'package:pstb/app/modules/notification/pages/my_notification_page.dart';
import 'package:pstb/app/modules/notification/pages/other_notification_page.dart';
import 'package:pstb/utils/icon_tabbar.dart';
import 'package:pstb/widgets/stateless/custom_tabbar.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';
import 'package:mobx/mobx.dart';
import 'package:pstb/app/app_store.dart';
import 'package:pstb/app/modules/auth_guard/auth_guard_page.dart';
import 'package:pstb/app/route_guard.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateful/stateful_widget.dart';
import '../notification_store.dart';
import 'notifi_details_page/notification_details_page.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage>
    with SingleTickerProviderStateMixin {
  final NotificationStore _notificationStore = Modular.get<NotificationStore>();
  final UserGuard _userGuard = UserGuard();
  final AppStore _appStore = Modular.get<AppStore>();
  final BottomNavStore _bottomNav = Modular.get<BottomNavStore>();
  late TabController _tabController;
  late final List<Tab> _tab = const [
    Tab(
      text: 'Cá nhân',
    ),
    Tab(
      text: 'CSYT',
    ),
    Tab(
      text: 'BVHNVD',
    ),
  ];
  void checkLogin() async {
    UserStatus isLogin = await _userGuard.canActivate();
    if (isLogin == UserStatus.Signed) {
      _notificationStore.getOtherNotification();
    }
    _notificationStore.setIsLogin(isLogin);
    if (_appStore.nextNotificationDetails) {
      _appStore.setNextNotificationDetails(false);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NotificationDetailsPage()),
      );
    }
  }

  @override
  void initState() {
    reaction((_) => _appStore.reload, (__) {
      _notificationStore.setIsLogin(UserStatus.Checking);
      checkLogin();
    });
    checkLogin();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.animateTo(0);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  void onSubmitFilter(FilterObject? valueSortBy, FilterObject? valueCategory,
      FilterObject? valueTime, FilterObject? valuePrice) {}

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        if (_notificationStore.isLogin == UserStatus.Checking) {
          return const SizedBox();
        }
        if (_notificationStore.isLogin == UserStatus.NoData) {
          return AuthGuardPage();
        }
        return WillPopScope(
          onWillPop: () {
            if (Platform.isAndroid) {
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            }
            return Future.value(false);
          },
          child: Scaffold(
            body: buildNotification(),
          ),
        );
      },
    );
  }

  Widget buildNotification() {
    return SafeArea(
      child: Column(
        children: [
          TabbarWithContainer(
            tabController: _tabController,
            tabs: _tab,
            onTap: (index) async {},
          ),
          Expanded(
            child: TabBarView(controller: _tabController, children: [
              const MyNotificationPage(),
              Center(
                child: Text(
                  'Chưa có thông báo mới nào!',
                  style: Styles.content,
                ),
              ),
              const OtherNotificationPage(),
            ]),
          ),
        ],
      ),
    );
  }
}
