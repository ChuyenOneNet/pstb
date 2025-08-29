import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../../../utils/constants.dart';
import '../../ehr_store.dart';
import '../signature_patient/item_ehr_signature.dart';

class ShowSignatureWidget extends StatelessWidget {
  const ShowSignatureWidget({
    Key? key,
    required ScrollController scrollController,
    required this.ehrStore,
  }) : _scrollController = scrollController, super(key: key);

  final ScrollController _scrollController;
  final EHRStore ehrStore;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await ehrStore.onRefreshPage();
      },
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 2,
        child: SlidableAutoCloseBehavior(
          closeWhenOpened: true,
          child: Observer(builder: (context) {
            return ListView.separated(
              shrinkWrap: true,
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemBuilder: (_, index) {
                final signingModel = ehrStore.listESM[index];
                return ItemEhrSignature(
                  model: signingModel,
                );
              },
              itemCount: ehrStore.listESM.length,
              separatorBuilder: (_, index) {
                return const Divider();
              },
            );
          }),
        ),
      ),
    );
  }
}
