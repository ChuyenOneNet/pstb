import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pstb/app/modules/manage_document_patient/document_patient_store.dart';

import 'item_document.dart';

class ListDocumentPatient extends StatelessWidget {
  final ScrollController _scrollController;
  final DocumentPatientStore documentPatientStore;

  const ListDocumentPatient({
    Key? key,
    required ScrollController scrollController,
    required this.documentPatientStore,
  })  : _scrollController = scrollController, super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await documentPatientStore.onRefreshPage();
      },
        child: SlidableAutoCloseBehavior(
          closeWhenOpened: true,
          child: Observer(builder: (context) {
            return ListView.separated(
              shrinkWrap: true,
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: (_, index) {
                final signingModel = documentPatientStore.listESM[index];
                return ItemDocument(
                  model: signingModel,
                  index: index,
                );
              },
              itemCount: documentPatientStore.listESM.length,
              separatorBuilder: (_, index) {
                return const Divider();
              },
            );
          }),
        ),
      // ),
    );
  }
}
