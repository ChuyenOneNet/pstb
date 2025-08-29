import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pstb/app/models/electronic_signature_model.dart';
import 'package:pstb/app/modules/nurse_page/electronic_signature/detail_signature/detail_signature_store.dart';
import 'package:pstb/app/modules/nurse_page/electronic_signature/electronic_signature_store.dart';
import 'package:pstb/services/api_base_helper.dart';
import 'package:pstb/utils/colors.dart';
import 'package:pstb/utils/icons.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';

class DetailSignaturePage extends StatefulWidget {
  const DetailSignaturePage({Key? key, required this.documentModel})
      : super(key: key);
  final DocumentModel documentModel;

  @override
  State<DetailSignaturePage> createState() => _DetailSignaturePageState();
}

class _DetailSignaturePageState extends State<DetailSignaturePage> {
  final _detailController = Modular.get<DetailSignatureStore>();
  final _electronicSignatureController =
      Modular.get<ElectronicSignatureStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.documentModel.name,
        actionIcon: const Icon(
          Icons.refresh,
          color: AppColors.primary,
        ),
        actionFunc: () async {
          EasyLoading.show();
          await _electronicSignatureController.getHeaderForPdf();
          await _detailController.onRefresh();
          EasyLoading.dismiss();
          if (_detailController.statusError != null) {
            AppSnackBar.show(
                context, AppSnackBarType.Error, _detailController.statusError);
          }
        },
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Observer(builder: (context) {
              print('_detailController.linkPdf ${_detailController.linkPdf}');
              return const PDF().fromUrl(
                _detailController.linkPdf ?? '',
                headers: _electronicSignatureController.headerForPdf,
                errorWidget: (_) {
                  _detailController.nameStatus = null;
                  return const Center(child: Text('Lỗi dữ liệu'));
                },
                placeholder: (progress) => Center(child: Text('$progress %')),
              );
            }),
          ),
          // Expanded(
          //   child: Row(
          //     children: [
          //       const Spacer(),
          //       Expanded(
          //         child: Observer(builder: (context) {
          //           if (_detailController.nameStatus == null) {
          //             return const SizedBox.shrink();
          //           }
          //           return AppButton(
          //               title: _detailController.nameStatus ?? '',
          //               onPressed: () async {
          //                 EasyLoading.show();
          //                 await _detailController.actionDocument();
          //                 EasyLoading.dismiss();
          //                 Fluttertoast.showToast(
          //                     msg: _detailController.statusSuccess ?? '');
          //               });
          //         }),
          //       ),
          //       const Spacer(),
          //     ],
          //   ),
          // ),
        ],
      ),
      floatingActionButton: Observer(builder: (context) {
        return FloatingActionButton(
            elevation: 0.0,
            child: _detailController.nameStatus == "Thực hiện ký"
                ? const Icon(
                    Icons.edit,
                  )
                : SvgPicture.asset(
                    IconEnums.close,
                    width: 24,
                    height: 24,
                    fit: BoxFit.contain,
                    color: AppColors.background,
                  ),
            backgroundColor: _detailController.nameStatus == "Thực hiện ký"
                ? AppColors.primary
                : Colors.red,
            onPressed: () async {
              EasyLoading.show();
              await _detailController.actionDocument();
              await _electronicSignatureController.getHeaderForPdf();
              await _detailController.onRefresh();
              EasyLoading.dismiss();
              Fluttertoast.showToast(
                  msg: _detailController.statusSuccess ?? '');
            });
      }),
    );
  }
}
