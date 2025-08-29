import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pstb/app/modules/nurse_page/electronic_signature/detail_signature/detail_signature_store.dart';
import 'package:pstb/app/modules/nurse_page/electronic_signature/filter_signature/filter_signature_store.dart';
import 'package:pstb/app/modules/nurse_page/electronic_signature/widgets/list_document_widget.dart';
import 'package:pstb/app/modules/nurse_page/electronic_signature/widgets/loading_signature_widget.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'electronic_signature_store.dart';
import 'filter_signature/filter_signature_widget.dart';
import 'widgets/button_bar_widget.dart';

class ElectronicSignaturePage extends StatefulWidget {
  const ElectronicSignaturePage({
    Key? key,
    this.userName,
    this.roleCode,
  }) : super(key: key);
  final String? userName;
  final String? roleCode;

  @override
  State<ElectronicSignaturePage> createState() =>
      _ElectronicSignaturePageState();
}

class _ElectronicSignaturePageState extends State<ElectronicSignaturePage> {
  final _electronicSignatureController =
      Modular.get<ElectronicSignatureStore>();
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController()..addListener(_loadMoreItems);
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      await _electronicSignatureController.initState(
        userName: widget.userName,
        roleCode: widget.roleCode,
      );
      Modular.get<FilterSignatureStore>().initState();
    });
    _electronicSignatureController.getHeaderForPdf();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (_electronicSignatureController.nameRoll == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showBarModalBottomSheet(
            context: context,
            builder: (context) => const FilterSignatureWidget(),
            barrierColor: AppColors.black.withOpacity(0.5));
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_loadMoreItems);
    Modular.dispose<ElectronicSignatureStore>();
    Modular.dispose<FilterSignatureStore>();
    Modular.dispose<DetailSignatureStore>();
    super.dispose();
  }

  Future<void> _loadMoreItems() async {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      await _electronicSignatureController.loadDocuments();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Scaffold(
        bottomNavigationBar: (_electronicSignatureController.status != null)
            ? ButtonBarWidget(
                electronicSignatureController: _electronicSignatureController)
            : const SizedBox(),
        appBar: CustomAppBar(
          isBack: false,
          leading: _electronicSignatureController.isShowCheckedItem
              ? InkWell(
                  onTap: () {
                    if (_electronicSignatureController.isCancelCheckedBox) {
                      _electronicSignatureController
                          .onClickCancelAllCheckedBox();
                      return;
                    }
                    if (_electronicSignatureController.status == null) {
                      Fluttertoast.showToast(
                          msg: 'Hãy chọn loại mẫu chữ ký trước');
                      return;
                    }
                    _electronicSignatureController.onClickAllCheckedBox();
                  },
                  child: _electronicSignatureController.isCancelCheckedBox
                      ? const Icon(
                          Icons.close,
                          size: 30,
                          color: AppColors.error500,
                        )
                      : const Icon(
                          Icons.check,
                          size: 30,
                          color: AppColors.primary,
                        ),
                )
              : InkWell(
                  onTap: () {
                    Modular.to.pop();
                  },
                  child: const Icon(
                    Icons.chevron_left,
                    size: 36,
                    color: AppColors.primary,
                  ),
                ),
          title: _electronicSignatureController.nameRoll ?? 'Vai trò ký',
          actionIcon: _electronicSignatureController.isShowCheckedItem
              ? Text(
                  'Huỷ',
                  style: Styles.content.copyWith(color: AppColors.primary),
                  maxLines: 1,
                )
              : SvgPicture.asset(
                  IconEnums.iconFilter,
                  color: AppColors.primary,
                ),
          actionFunc: () async {
            if (_electronicSignatureController.isShowCheckedItem) {
              _electronicSignatureController.onCancelPickItems();
              return;
            }
            showBarModalBottomSheet(
                context: context,
                builder: (context) => const FilterSignatureWidget(),
                barrierColor: AppColors.black.withOpacity(0.5));
          },
        ),
        body: Observer(builder: (context) {
          if (_electronicSignatureController.isLoading) {
            return const LoadingSignatureWidget();
          }
          if (_electronicSignatureController.isLoadingMoreItem) {
            return const SizedBox();
          }
          // if (_electronicSignatureController.nameRoll == null) {
          //   return Center(
          //     child: Text('Hãy mở bộ lọc để chọn vai trò', style: Styles.content,),
          //   );
          // }
          if (_electronicSignatureController.documentPagination.items == null) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Không có dữ liệu',
                    style: Styles.content,
                  ),
                ),
              ],
            );
          }
          if (_electronicSignatureController
              .documentPagination.items!.isEmpty) {
            return Center(
                child: Text(
              'Không có dữ liệu',
              style: Styles.content,
            ));
          }
          return ListDocumentsWidget(
              electronicSignatureController: _electronicSignatureController,
              scrollController: _scrollController);
        }),
      );
    });
  }
}
