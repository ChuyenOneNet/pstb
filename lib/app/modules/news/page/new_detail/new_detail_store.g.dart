// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_detail_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$NewsDetailStore on NewsDetailStoreBase, Store {
  late final _$scrollIsReachedAtom =
      Atom(name: 'NewsDetailStoreBase.scrollIsReached', context: context);

  @override
  bool get scrollIsReached {
    _$scrollIsReachedAtom.reportRead();
    return super.scrollIsReached;
  }

  @override
  set scrollIsReached(bool value) {
    _$scrollIsReachedAtom.reportWrite(value, super.scrollIsReached, () {
      super.scrollIsReached = value;
    });
  }

  late final _$isBookmarkedAtom =
      Atom(name: 'NewsDetailStoreBase.isBookmarked', context: context);

  @override
  bool get isBookmarked {
    _$isBookmarkedAtom.reportRead();
    return super.isBookmarked;
  }

  @override
  set isBookmarked(bool value) {
    _$isBookmarkedAtom.reportWrite(value, super.isBookmarked, () {
      super.isBookmarked = value;
    });
  }

  late final _$loadingAtom =
      Atom(name: 'NewsDetailStoreBase.loading', context: context);

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

  late final _$successNewAtom =
      Atom(name: 'NewsDetailStoreBase.successNew', context: context);

  @override
  bool get successNew {
    _$successNewAtom.reportRead();
    return super.successNew;
  }

  @override
  set successNew(bool value) {
    _$successNewAtom.reportWrite(value, super.successNew, () {
      super.successNew = value;
    });
  }

  late final _$newsAtom =
      Atom(name: 'NewsDetailStoreBase.news', context: context);

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

  late final _$getNewsDetailAsyncAction =
      AsyncAction('NewsDetailStoreBase.getNewsDetail', context: context);

  @override
  Future<void> getNewsDetail({required dynamic id}) {
    return _$getNewsDetailAsyncAction.run(() => super.getNewsDetail(id: id));
  }

  late final _$updateBookmarksAsyncAction =
      AsyncAction('NewsDetailStoreBase.updateBookmarks', context: context);

  @override
  Future<void> updateBookmarks(int id) {
    return _$updateBookmarksAsyncAction.run(() => super.updateBookmarks(id));
  }

  late final _$NewsDetailStoreBaseActionController =
      ActionController(name: 'NewsDetailStoreBase', context: context);

  @override
  void scrollListener() {
    final _$actionInfo = _$NewsDetailStoreBaseActionController.startAction(
        name: 'NewsDetailStoreBase.scrollListener');
    try {
      return super.scrollListener();
    } finally {
      _$NewsDetailStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addListener(BuildContext newContext) {
    final _$actionInfo = _$NewsDetailStoreBaseActionController.startAction(
        name: 'NewsDetailStoreBase.addListener');
    try {
      return super.addListener(newContext);
    } finally {
      _$NewsDetailStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void createBuildContext(BuildContext newContext) {
    final _$actionInfo = _$NewsDetailStoreBaseActionController.startAction(
        name: 'NewsDetailStoreBase.createBuildContext');
    try {
      return super.createBuildContext(newContext);
    } finally {
      _$NewsDetailStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void scrollToTop() {
    final _$actionInfo = _$NewsDetailStoreBaseActionController.startAction(
        name: 'NewsDetailStoreBase.scrollToTop');
    try {
      return super.scrollToTop();
    } finally {
      _$NewsDetailStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void initialScreen(
      {required dynamic newId, required BuildContext screenContext}) {
    final _$actionInfo = _$NewsDetailStoreBaseActionController.startAction(
        name: 'NewsDetailStoreBase.initialScreen');
    try {
      return super.initialScreen(newId: newId, screenContext: screenContext);
    } finally {
      _$NewsDetailStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
scrollIsReached: ${scrollIsReached},
isBookmarked: ${isBookmarked},
loading: ${loading},
successNew: ${successNew},
news: ${news}
    ''';
  }
}
