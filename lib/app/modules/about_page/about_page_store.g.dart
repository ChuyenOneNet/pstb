// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'about_page_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AboutPageStore on AboutPageStoreBase, Store {
  late final _$isLoadingAtom =
      Atom(name: 'AboutPageStoreBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$newsAtom =
      Atom(name: 'AboutPageStoreBase.news', context: context);

  @override
  NewsDetailModel get news {
    _$newsAtom.reportRead();
    return super.news;
  }

  @override
  set news(NewsDetailModel value) {
    _$newsAtom.reportWrite(value, super.news, () {
      super.news = value;
    });
  }

  late final _$urlAtom = Atom(name: 'AboutPageStoreBase.url', context: context);

  @override
  String get url {
    _$urlAtom.reportRead();
    return super.url;
  }

  @override
  set url(String value) {
    _$urlAtom.reportWrite(value, super.url, () {
      super.url = value;
    });
  }

  late final _$statusWidgetAtom =
      Atom(name: 'AboutPageStoreBase.statusWidget', context: context);

  @override
  StatusWidget get statusWidget {
    _$statusWidgetAtom.reportRead();
    return super.statusWidget;
  }

  @override
  set statusWidget(StatusWidget value) {
    _$statusWidgetAtom.reportWrite(value, super.statusWidget, () {
      super.statusWidget = value;
    });
  }

  late final _$getNewsDetailAsyncAction =
      AsyncAction('AboutPageStoreBase.getNewsDetail', context: context);

  @override
  Future<void> getNewsDetail() {
    return _$getNewsDetailAsyncAction.run(() => super.getNewsDetail());
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
news: ${news},
url: ${url},
statusWidget: ${statusWidget}
    ''';
  }
}
