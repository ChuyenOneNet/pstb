import 'package:flutter/material.dart';
import 'package:pstb/app/models/business_detail_model.dart';
import 'package:pstb/app/modules/business_for_his/widgets/result/image_diagnosis_results.dart';
import 'package:pstb/app/modules/business_for_his/widgets/result/xet_nghiem_results.dart';

import '../../../../../utils/colors.dart';
import '../utils/grouping_utils.dart';

/// TAB 3: KẾT QUẢ (WITH NESTED TABS)
/// Contains 2 sub-tabs: Xét Nghiệm | Chẩn đoán Hình ảnh
class TabResults extends StatefulWidget {
  final BusinessDetailModel detail;
  final TabController resultsTabController;

  const TabResults({
    Key? key,
    required this.detail,
    required this.resultsTabController,
  }) : super(key: key);

  @override
  State<TabResults> createState() => _TabResultsState();
}

class _TabResultsState extends State<TabResults>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final allExamData =
        GroupingUtils.groupXetNghiemByDate(widget.detail.xetNghiemInfos);
    final hasExams = allExamData.isNotEmpty;

    final allImageData =
        GroupingUtils.groupImageByDate(widget.detail.urlDataInfos);
    final hasImages = allImageData.isNotEmpty;

    if (!hasExams && !hasImages) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.info_outline, size: 48, color: Colors.grey),
              SizedBox(height: 12),
              Text('Không có kết quả',
                  style: TextStyle(color: Colors.grey, fontSize: 14)),
            ],
          ),
        ),
      );
    }

    return Column(
      children: [
        Container(
          color: Colors.white,
          child: TabBar(
            controller: widget.resultsTabController,
            labelColor: AppColors.primary,
            unselectedLabelColor: Colors.grey[600],
            indicatorColor: AppColors.primary,
            labelStyle:
                const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
            tabs: const [
              Tab(text: 'Xét Nghiệm'),
              Tab(text: 'Chẩn đoán Hình ảnh'),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: widget.resultsTabController,
            children: [
              hasExams
                  ? XetNghiemResults(groupedData: allExamData)
                  : const Center(child: Text('Không có kết quả xét nghiệm')),
              hasImages
                  ? ImageDiagnosisResults(groupedData: allImageData)
                  : const Center(
                      child: Text('Không có kết quả chẩn đoán hình ảnh')),
            ],
          ),
        ),
      ],
    );
  }
}
