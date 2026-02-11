import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shimmer/shimmer.dart';

import 'package:pstb/app/modules/business_for_his/widgets/tab_admin_info.dart';
import 'package:pstb/app/modules/business_for_his/widgets/tab_exam_info.dart';
import 'package:pstb/app/modules/business_for_his/widgets/tab_result.dart';

import '../../../../utils/colors.dart';
import '../../../../widgets/stateless/app_bar.dart';
import '../../models/user_business_model.dart';
import '../business/business_store.dart';

class BusinessDetailScreenForHis extends StatefulWidget {
  final String idBusiness;
  BusinessDetailScreenForHis({Key? key, required this.idBusiness});

  @override
  State<BusinessDetailScreenForHis> createState() =>
      _BusinessDetailScreenForHisState();
}

class _BusinessDetailScreenForHisState extends State<BusinessDetailScreenForHis>
    with TickerProviderStateMixin {
  final store = Modular.get<BusinessStore>();
  UserBusinessModel userBusiness = UserBusinessModel();
  late TabController _mainTabController;
  late TabController _resultsTabController;

  @override
  void initState() {
    super.initState();
    store.loadBusinessDetail(widget.idBusiness);
    userBusiness = store.userBusiness;
    _mainTabController = TabController(length: 3, vsync: this);
    _resultsTabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _mainTabController.dispose();
    _resultsTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Thông tin bệnh nhân", isBack: true),
      backgroundColor: const Color(0xFFF6F7FB),
      body: Observer(builder: (_) {
        final isLoading = store.isLoadingDetail || store.businessDetail == null;

        if (isLoading) {
          return const _BusinessDetailShimmer();
        }

        final detail = store.businessDetail!;
        return Column(
          children: [
            Container(
              color: Colors.white,
              child: TabBar(
                controller: _mainTabController,
                labelColor: AppColors.primary,
                unselectedLabelColor: Colors.grey[600],
                indicatorColor: AppColors.primary,
                labelStyle: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
                tabs: const [
                  Tab(text: 'I. THÔNG TIN'),
                  Tab(text: 'II. DHST'),
                  Tab(text: 'III. KẾT QUẢ'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _mainTabController,
                children: [
                  TabAdminInfo(userBusiness: userBusiness),
                  TabExamInfo(detail: detail),
                  TabResults(
                    detail: detail,
                    resultsTabController: _resultsTabController,
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}

/// =======================
/// SHIMMER SKELETON
/// =======================

class _BusinessDetailShimmer extends StatelessWidget {
  const _BusinessDetailShimmer();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // fake tab bar
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: const [
              Expanded(child: _SkelBox(height: 24, radius: 8)),
              SizedBox(width: 10),
              Expanded(child: _SkelBox(height: 24, radius: 8)),
              SizedBox(width: 10),
              Expanded(child: _SkelBox(height: 24, radius: 8)),
            ],
          ),
        ),

        Expanded(
          child: Shimmer.fromColors(
            baseColor: const Color(0xFFE9ECF2),
            highlightColor: const Color(0xFFF6F7FB),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: const [
                  _SkelCard(lines: 2),
                  SizedBox(height: 12),
                  _SkelCard(lines: 2),
                  SizedBox(height: 12),
                  _SkelCard(lines: 2),
                  SizedBox(height: 12),
                  _SkelCard(lines: 2),
                  SizedBox(height: 12),
                  _SkelCard(lines: 2),
                  SizedBox(height: 12),
                  _SkelCard(lines: 2),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SkelCard extends StatelessWidget {
  final int lines;
  const _SkelCard({required this.lines});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [BoxShadow(blurRadius: 10, color: Color(0x11000000))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SkelBox(height: 14, width: 160, radius: 8),
          const SizedBox(height: 12),
          ...List.generate(lines, (i) {
            final isLast = i == lines - 1;
            return Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 10),
              child: Row(
                children: const [
                  _SkelBox(height: 12, width: 120, radius: 8),
                  SizedBox(width: 10),
                  Expanded(child: _SkelBox(height: 12, radius: 8)),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _SkelBox extends StatelessWidget {
  final double height;
  final double? width;
  final double radius;

  const _SkelBox({
    required this.height,
    this.width,
    this.radius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: const Color(0xFFE9ECF2),
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
