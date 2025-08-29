import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pstb/app/modules/nurse_page/electronic_signature/filter_signature/filter_signature_store.dart';
import 'package:pstb/utils/main.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class PatientFilterWidget extends StatelessWidget {
  PatientFilterWidget({Key? key}) : super(key: key);
  final _controller = Modular.get<FilterSignatureStore>();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: AppColors.transparent,
      highlightColor: AppColors.transparent,
      onTap: () {
        _controller.pagingPatient.items = null;
        showCupertinoModalBottomSheet(
          context: context,
          barrierColor: AppColors.black.withOpacity(0.5),
          builder: (_) {
            return const _InformationSearchingPatientWidget();
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
                return Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _controller.patientModelSelected?.name ?? 'Bệnh nhân',
                        style: Styles.subtitleSmallest,
                      ),
                      if (_controller.patientModelSelected?.code != null &&
                          _controller.patientModelSelected!.code!.isNotEmpty)
                        Text(
                          _controller.patientModelSelected?.code ??
                              'Bệnh nhân(Quét mã)',
                          style: Styles.subtitleSmallest,
                        ),
                    ],
                  ),
                );
              }),
              const Icon(
                CupertinoIcons.chevron_right,
                size: 16,
              ),
              // SvgPicture.asset(
              //   IconEnums.qr,
              //   color: AppColors.black,
              // )
            ],
          )),
    );
  }
}

class _InformationSearchingPatientWidget extends StatefulWidget {
  const _InformationSearchingPatientWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<_InformationSearchingPatientWidget> createState() =>
      _InformationSearchingPatientWidgetState();
}

class _InformationSearchingPatientWidgetState
    extends State<_InformationSearchingPatientWidget> {
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
      await _controller.onLoadMorePatients();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Observer(builder: (context) {
        if (_controller.isLoading) {
          return const SizedBox();
        }
        return Column(
          children: [
            InkWell(
              onTap: () async {
                final value =
                    (await Modular.to.pushNamed(AppRoutes.qrCode) as String)
                        .replaceAll(RegExp(r'[^\w\s]+'), '');
                EasyLoading.show();
                await _controller.onLoadedPatient(patientCode: value);
                EasyLoading.dismiss();
                Modular.to.pop();
              },
              child: Row(
                children: [
                  Expanded(
                    child: CupertinoSearchTextField(
                      placeholder: 'Tìm kiếm bệnh nhân',
                      onSubmitted: (value) {
                        _controller.onSearchPatient(search: value);
                      },
                      autofocus: true,
                    ),
                  ),
                  SvgPicture.asset(
                    IconEnums.qr,
                    width: 70,
                  )
                ],
              ),
            ),
            if (_controller.pagingPatient.items == null)
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text('Hãy tìm kiếm bệnh nhân'),
                ),
              ),
            if (_controller.pagingPatient.items != null &&
                _controller.pagingPatient.items!.isEmpty)
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text('Không có kết quả'),
                ),
              ),
            if (_controller.pagingPatient.items != null)
              NotificationListener(
                onNotification: (scrollNotification) {
                  if (scrollNotification is ScrollStartNotification) {
                    Future.microtask(() => _controller.onLoadMorePatients());
                  }
                  return true;
                },
                child: Expanded(
                  child: Scrollbar(
                    controller: _scrollController,
                    child: ListView.separated(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(16),
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (_, index) {
                        final patientModel =
                            _controller.pagingPatient.items![index];
                        return InkWell(
                            onTap: () {
                              _controller.onSelectedPatient(
                                  patient: patientModel);
                              Modular.to.pop();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(child: Text(patientModel.name ?? '')),
                                Text(patientModel.code ?? ''),
                              ],
                            ));
                      },
                      itemCount: _controller.pagingPatient.items!.length,
                      shrinkWrap: true,
                      separatorBuilder: (_, index) {
                        return const Divider();
                      },
                    ),
                  ),
                ),
              )
          ],
        );
      }),
    );
  }
}
