// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotion_detail_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PromotionDetailStore on PromotionDetailStoreBase, Store {
  late final _$loadingAtom =
      Atom(name: 'PromotionDetailStoreBase.loading', context: context);

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  late final _$promoteNewsAtom =
      Atom(name: 'PromotionDetailStoreBase.promoteNews', context: context);

  @override
  PromotionNewsModel get promoteNews {
    _$promoteNewsAtom.reportRead();
    return super.promoteNews;
  }

  @override
  set promoteNews(PromotionNewsModel value) {
    _$promoteNewsAtom.reportWrite(value, super.promoteNews, () {
      super.promoteNews = value;
    });
  }

  late final _$getOfferDetailAsyncAction =
      AsyncAction('PromotionDetailStoreBase.getOfferDetail', context: context);

  @override
  Future<void> getOfferDetail({required dynamic id}) {
    return _$getOfferDetailAsyncAction.run(() => super.getOfferDetail(id: id));
  }

  late final _$PromotionDetailStoreBaseActionController =
      ActionController(name: 'PromotionDetailStoreBase', context: context);

  @override
  void initialScreen({required dynamic offerId}) {
    final _$actionInfo = _$PromotionDetailStoreBaseActionController.startAction(
        name: 'PromotionDetailStoreBase.initialScreen');
    try {
      return super.initialScreen(offerId: offerId);
    } finally {
      _$PromotionDetailStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loading: ${loading},
promoteNews: ${promoteNews}
    ''';
  }
}
