import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/specific_patient/list_specific/list_specific_store.dart';
import 'package:pstb/app/modules/specific_patient/list_specific/widget/header_specific_patient_widget.dart';
import 'package:pstb/app/modules/specific_patient/list_specific/widget/list_registration_by_status_widget.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/custom_tabbar.dart';
import 'package:pstb/widgets/stateless/divider_custom_widget.dart';

class DetailSpecificPatientWidget extends StatefulWidget {
  const DetailSpecificPatientWidget({Key? key}) : super(key: key);

  @override
  State<DetailSpecificPatientWidget> createState() =>
      _DetailSpecificPatientWidgetState();
}

class _DetailSpecificPatientWidgetState
    extends State<DetailSpecificPatientWidget>
    with SingleTickerProviderStateMixin {
  late ScrollController scrollController;
  final _controller = Modular.get<ListSpecificStore>();
  late TabController _tabController;

  @override
  void initState() {
    scrollController = ScrollController()..addListener(loadMore);
    _tabController =
        TabController(vsync: this, length: Constants.listStatusSpecific.length)
          ..addListener(() async {
            _controller.currentIndex = _tabController.index;
            if (_tabController.indexIsChanging) return;
            // await _controller.onChangeTab(_controller.currentIndex);
          });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    scrollController.removeListener(loadMore);
    Modular.dispose<ListSpecificStore>();
    super.dispose();
  }

  Future<void> loadMore() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      await _controller.loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: Constants.listStatusSpecific.length,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            HeaderSpecificPatientWidget(controller: _controller),
            const SizedBox(
              height: 16.0,
            ),
            Observer(builder: (context) {
              if (_controller.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return TabbarWithNoContainer(
                tabs:
                    List.generate(Constants.listStatusSpecific.length, (index) {
                  int? length = _controller
                      .listGroupByStatus[
                          Constants.listStatusSpecific.keys.toList()[index]]
                      ?.items!
                      .length;
                  return Tab(
                    text: Constants.listStatusSpecific.keys.toList()[index],
                  );
                }),
                tabController: _tabController,
                onTap: (index) async {
                  await _controller.onChangeTab(index);
                },
                isScrollable: true,
              );
            }),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: List.generate(
                  Constants.listStatusSpecific.length,
                  (index) => Observer(
                    builder: (context) {
                      if (_controller.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (_controller
                              .listGroupByStatus[Constants
                                  .listStatusSpecific.keys
                                  .toList()[index]]
                              ?.items ==
                          null) {
                        return Center(
                          child: Text(_controller.errorMessage ?? ''),
                        );
                      }
                      if (_controller
                          .listGroupByStatus[Constants.listStatusSpecific.keys
                              .toList()[index]]!
                          .items!
                          .isEmpty) {
                        return const Center(
                          child: Text('Không có dữ liệu'),
                        );
                      }
                      return ListRegistrationByStatusWidget(
                          controller: scrollController,
                          listRegistration: _controller
                              .listGroupByStatus[Constants
                                  .listStatusSpecific.keys
                                  .toList()[_controller.currentIndex]]
                              ?.items!);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
