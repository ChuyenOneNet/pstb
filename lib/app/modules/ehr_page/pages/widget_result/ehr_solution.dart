import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/ehr_page/pages/list_indications_widget.dart';
import 'package:pstb/app/modules/ehr_page/pages/widget_result/list_prescription_widget.dart';
import 'package:pstb/app/modules/ehr_page/pages/widget_result/show_more_icon.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/custom_tabbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../models/medical_record_model.dart';
import '../../../nurse_page/electronic_signature/widgets/loading_signature_widget.dart';
import '../../ehr_store.dart';
import '../signature_patient/show_signature_widget.dart';

class EhrSolution extends StatefulWidget {
  final Function onTap;
  final Examination examination;

  const EhrSolution({
    Key? key,
    required this.onTap,
    required this.examination,
  }) : super(key: key);

  @override
  State<EhrSolution> createState() => _EhrSolutionState();
}

class _EhrSolutionState extends State<EhrSolution>
    with TickerProviderStateMixin {
  final EHRStore store = Modular.get<EHRStore>();
  late ScrollController _scrollController;
  late String codeNurse = '';
  late TabController _tabController;
  late final List<Tab> _tab = const [
    Tab(
      text: 'Cận lâm sàng',
    ),
    Tab(
      text: 'Đơn thuốc',
    ),
    Tab(
      text: 'Tài liệu ký',
    ),
  ];

  @override
  void initState() {
    _scrollController = ScrollController()..addListener(_loadMoreItems);
    // getSigner();
    if (store.prescriptionDate.length <= 7) {
      store.showMore = false;
    }
    _tabController = TabController(length: 3, vsync: this);
    _tabController.animateTo(0);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_loadMoreItems);
    super.dispose();
  }

  Future<void> _loadMoreItems() async {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      await store.loadMoreSignature();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 8),
      decoration: BoxDecoration(
        color: AppColors.background,
        border: Border.all(color: AppColors.lightSilver),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('III. Cách giải quyết', style: Styles.titleItem),
          const Divider(
            color: AppColors.primary,
          ),
          Observer(
            builder: (_) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Kết luận: ",
                    style: Styles.content,
                  ),
                  Text(
                    store.resultsData.examination?.solution ?? "",
                    style: Styles.titleItem,
                    textAlign: TextAlign.end,
                  ),
                ],
              );
            },
          ),
          const SizedBox(
            height: 8.0,
          ),
          TabbarWithNoContainer(
            tabController: _tabController,
            isScrollable: true,
            tabs: _tab,
            onTap: (index) async {
              // if (index == 0) {
              //   print('0');
              // } else if (index == 1) {
              //   print('1');
              // } else {
              //   print('2');
              //   EasyLoading.show();
              //   final pref = await Modular.getAsync<SharedPreferences>();
              //   codeNurse = pref.getString(Constants.codeNursing) ?? '';
              //   final password = pref.getString(codeNurse);
              //   await store.getSigner();
              //   EasyLoading.dismiss();
              // }
            },
          ),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                store.indicationGroupByDate.isEmpty
                    ? Container(
                        alignment: Alignment.topCenter,
                        child: Text('Không có kết quả'),
                      )
                    : const ListIndicationsWidget(),
                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (store.prescriptionDate.isEmpty)
                        const Center(
                            child: Text(
                          'Không có đơn thuốc',
                        )),
                      if (store.showMore == true)
                        Column(
                          children: [
                            ListPrescriptionWidget(length: 7),
                            ShowMoreIcon(
                              iconData: Icons.expand_more_outlined,
                              checkShowMore: false,
                              store: store,
                            ),
                          ],
                        ),
                      if (store.showMore == false)
                        Column(
                          children: [
                            ListPrescriptionWidget(
                                length: store.prescriptionDate.length),
                            if (store.prescriptionDate.length > 7)
                              ShowMoreIcon(
                                  iconData: Icons.expand_less_outlined,
                                  checkShowMore: true,
                                  store: store)
                            else
                              const SizedBox(),
                          ],
                        ),
                    ],
                  ),
                ),
                Observer(builder: (_) {
                  if (store.isLoading) {
                    return const LoadingSignatureWidget();
                  }
                  return store.listESM.isNotEmpty
                      ? ShowSignatureWidget(
                          scrollController: _scrollController,
                          ehrStore: store,
                        )
                      : Center(
                          child: Text(
                            'Không có dữ liệu.',
                            style:
                                Styles.content.copyWith(color: AppColors.black),
                          ),
                        );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
