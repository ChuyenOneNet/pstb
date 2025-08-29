import 'package:flutter/material.dart';
import 'package:pstb/utils/colors.dart';
import 'package:pstb/utils/main.dart';

class TabbarWithContainer extends StatelessWidget {
  const TabbarWithContainer(
      {Key? key,
      required this.tabs,
      required this.tabController,
      required this.onTap,
      this.isScrollable})
      : super(key: key);
  final List<Tab> tabs;
  final TabController tabController;
  final Function(int) onTap;
  final bool? isScrollable;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight + 8.0,
      padding: const EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
      ),
      child: TabBar(
        controller: tabController,
        indicator: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
            color: Colors.white),
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.background,
        labelStyle: Styles.titleItem.copyWith(fontSize: 15.0),
        tabs: tabs,
        onTap: onTap,
        isScrollable: isScrollable ?? false,
      ),
    );
  }
}

class TabbarWithNoContainer extends StatelessWidget {
  const TabbarWithNoContainer(
      {Key? key,
      required this.tabs,
      required this.tabController,
      required this.onTap,
      this.isScrollable})
      : super(key: key);
  final List<Tab> tabs;
  final TabController tabController;
  final Function(int) onTap;
  final bool? isScrollable;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: tabController,
      unselectedLabelColor: AppColors.primary,
      labelColor: AppColors.background,
      labelStyle: Styles.titleItem.copyWith(fontSize: 15.0),
      indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(80.0),
        color: AppColors.primary,
      ),
      onTap: onTap,
      tabs: tabs,
      isScrollable: isScrollable ?? false,
    );
  }
}
