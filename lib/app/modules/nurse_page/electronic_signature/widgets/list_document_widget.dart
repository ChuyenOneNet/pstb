import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pstb/app/modules/nurse_page/electronic_signature/electronic_signature_store.dart';

import 'item_electronic_signature_widget.dart';

class ListDocumentsWidget extends StatelessWidget {
  const ListDocumentsWidget({
    Key? key,
    required ElectronicSignatureStore electronicSignatureController,
    required ScrollController scrollController,
  })  : _electronicSignatureController = electronicSignatureController,
        _scrollController = scrollController,
        super(key: key);

  final ElectronicSignatureStore _electronicSignatureController;
  final ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _electronicSignatureController.onRefreshPage();
      },
      child: Scrollbar(
        controller: _scrollController,
        child: SlidableAutoCloseBehavior(
          closeWhenOpened: true,
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemBuilder: (_, index) {
              final listSort =
                  _electronicSignatureController.documentPagination.items!
                    ..sort((preModel, currentModel) {
                      return currentModel.createdDate!
                          .compareTo(preModel.createdDate ?? '');
                    });
              final signingModel = listSort[index];
              return ItemElectronicSignatureWidget(
                model: signingModel,
                index: index,
              );
            },
            itemCount:
                _electronicSignatureController.documentPagination.items!.length,
            // separatorBuilder: (_, index) {
            //   return const Divider();
            // },
          ),
        ),
      ),
    );
  }
}
