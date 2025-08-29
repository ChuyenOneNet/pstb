import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/nurse_page/electronic_signature/filter_signature/filter_signature_store.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class DepartmentFilterWidget extends StatefulWidget {
  const DepartmentFilterWidget({Key? key}) : super(key: key);

  @override
  State<DepartmentFilterWidget> createState() => _DepartmentFilterWidgetState();
}

class _DepartmentFilterWidgetState extends State<DepartmentFilterWidget> {
  final _controller = Modular.get<FilterSignatureStore>();
  late final ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController()..addListener(_onLoadMoreItems);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onLoadMoreItems);
    super.dispose();
  }

  Future<void> _onLoadMoreItems() async {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      await _controller.onLoadMoreDepartment();
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: AppColors.transparent,
      highlightColor: AppColors.transparent,
      onTap: () async {
        EasyLoading.show();
        await _controller.onSearchDepartment();
        EasyLoading.dismiss();
        showCupertinoModalBottomSheet(
          context: context,
          barrierColor: AppColors.black.withOpacity(0.5),
          builder: (_) {
            return Container(
              height: MediaQuery.of(context).size.height / 3 * 2,
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  CupertinoSearchTextField(
                    placeholder: 'Tìm kiếm khoa phòng',
                    autofocus: true,
                    onSubmitted: (value) async {
                      EasyLoading.show();
                      await _controller.onSearchDepartment(keyword: value);
                      EasyLoading.dismiss();
                    },
                  ),
                  if (_controller.pagingDepartment.items == null)
                    const Text('Lỗi dữ liệu'),
                  if (_controller.pagingDepartment.items!.isEmpty)
                    const Text('Không có kết quả'),
                  if (_controller.pagingDepartment.items!.isNotEmpty)
                    Observer(builder: (context) {
                      if (_controller.isLoading) {
                        return const AppCircleLoading();
                      }
                      return Expanded(
                        child: NotificationListener(
                          onNotification: (scrollNotification) {
                            if (scrollNotification is ScrollStartNotification) {
                              Future.microtask(
                                  () => _controller.onLoadMoreDepartment());
                            }
                            return true;
                          },
                          child: Scrollbar(
                            controller: _scrollController,
                            child: ListView.separated(
                              controller: _scrollController,
                              padding: const EdgeInsets.all(8),
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemBuilder: (_, index) {
                                final departmentModel =
                                    _controller.pagingDepartment.items![index];
                                return InkWell(
                                    onTap: () {
                                      _controller.onSelectedDepartment(
                                          departmentModel: departmentModel);
                                      Modular.to.pop();
                                    },
                                    child: Text(departmentModel.name ?? ''));
                              },
                              separatorBuilder: (_, index) {
                                return const Divider();
                              },
                              itemCount:
                                  _controller.pagingDepartment.items!.length,
                              shrinkWrap: true,
                            ),
                          ),
                        ),
                      );
                    })
                ],
              ),
            );
          },
        );
      },
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: AppColors.lightSilver,
              borderRadius: BorderRadius.circular(8)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Observer(builder: (context) {
                return Text(
                  _controller.departmentModelSelected?.name ?? 'Khoa phòng',
                  style: Styles.subtitleSmallest,
                );
              }),
              const Icon(
                CupertinoIcons.chevron_right,
                size: 16,
              ),
            ],
          )),
    );
  }
}
