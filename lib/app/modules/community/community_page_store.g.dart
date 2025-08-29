// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_page_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CommunityPageStore on CommunityPageStoreBase, Store {
  late final _$isLoginAtom =
      Atom(name: 'CommunityPageStoreBase.isLogin', context: context);

  @override
  bool get isLogin {
    _$isLoginAtom.reportRead();
    return super.isLogin;
  }

  @override
  set isLogin(bool value) {
    _$isLoginAtom.reportWrite(value, super.isLogin, () {
      super.isLogin = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'CommunityPageStoreBase.isLoading', context: context);

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

  late final _$listMyQuestionAtom =
      Atom(name: 'CommunityPageStoreBase.listMyQuestion', context: context);

  @override
  ObservableList<Items> get listMyQuestion {
    _$listMyQuestionAtom.reportRead();
    return super.listMyQuestion;
  }

  @override
  set listMyQuestion(ObservableList<Items> value) {
    _$listMyQuestionAtom.reportWrite(value, super.listMyQuestion, () {
      super.listMyQuestion = value;
    });
  }

  late final _$listSearchQuestionAtom =
      Atom(name: 'CommunityPageStoreBase.listSearchQuestion', context: context);

  @override
  ObservableList<Items> get listSearchQuestion {
    _$listSearchQuestionAtom.reportRead();
    return super.listSearchQuestion;
  }

  @override
  set listSearchQuestion(ObservableList<Items> value) {
    _$listSearchQuestionAtom.reportWrite(value, super.listSearchQuestion, () {
      super.listSearchQuestion = value;
    });
  }

  late final _$topicDiseaseModelAtom =
      Atom(name: 'CommunityPageStoreBase.topicDiseaseModel', context: context);

  @override
  TopicDiseaseModel get topicDiseaseModel {
    _$topicDiseaseModelAtom.reportRead();
    return super.topicDiseaseModel;
  }

  @override
  set topicDiseaseModel(TopicDiseaseModel value) {
    _$topicDiseaseModelAtom.reportWrite(value, super.topicDiseaseModel, () {
      super.topicDiseaseModel = value;
    });
  }

  late final _$pageAtom =
      Atom(name: 'CommunityPageStoreBase.page', context: context);

  @override
  int get page {
    _$pageAtom.reportRead();
    return super.page;
  }

  @override
  set page(int value) {
    _$pageAtom.reportWrite(value, super.page, () {
      super.page = value;
    });
  }

  late final _$pageSearchAtom =
      Atom(name: 'CommunityPageStoreBase.pageSearch', context: context);

  @override
  int get pageSearch {
    _$pageSearchAtom.reportRead();
    return super.pageSearch;
  }

  @override
  set pageSearch(int value) {
    _$pageSearchAtom.reportWrite(value, super.pageSearch, () {
      super.pageSearch = value;
    });
  }

  late final _$keywordSearchAtom =
      Atom(name: 'CommunityPageStoreBase.keywordSearch', context: context);

  @override
  List<String> get keywordSearch {
    _$keywordSearchAtom.reportRead();
    return super.keywordSearch;
  }

  @override
  set keywordSearch(List<String> value) {
    _$keywordSearchAtom.reportWrite(value, super.keywordSearch, () {
      super.keywordSearch = value;
    });
  }

  late final _$keywordAtom =
      Atom(name: 'CommunityPageStoreBase.keyword', context: context);

  @override
  String get keyword {
    _$keywordAtom.reportRead();
    return super.keyword;
  }

  @override
  set keyword(String value) {
    _$keywordAtom.reportWrite(value, super.keyword, () {
      super.keyword = value;
    });
  }

  late final _$checkLoginAsyncAction =
      AsyncAction('CommunityPageStoreBase.checkLogin', context: context);

  @override
  Future<void> checkLogin() {
    return _$checkLoginAsyncAction.run(() => super.checkLogin());
  }

  late final _$getListQuestionAsyncAction =
      AsyncAction('CommunityPageStoreBase.getListQuestion', context: context);

  @override
  Future<void> getListQuestion() {
    return _$getListQuestionAsyncAction.run(() => super.getListQuestion());
  }

  late final _$loadMoreQuestionAsyncAction =
      AsyncAction('CommunityPageStoreBase.loadMoreQuestion', context: context);

  @override
  Future<void> loadMoreQuestion() {
    return _$loadMoreQuestionAsyncAction.run(() => super.loadMoreQuestion());
  }

  late final _$getSearchQuestionAsyncAction =
      AsyncAction('CommunityPageStoreBase.getSearchQuestion', context: context);

  @override
  Future<void> getSearchQuestion(String value) {
    return _$getSearchQuestionAsyncAction
        .run(() => super.getSearchQuestion(value));
  }

  late final _$loadMoreSearchQuestionAsyncAction = AsyncAction(
      'CommunityPageStoreBase.loadMoreSearchQuestion',
      context: context);

  @override
  Future<void> loadMoreSearchQuestion(String value) {
    return _$loadMoreSearchQuestionAsyncAction
        .run(() => super.loadMoreSearchQuestion(value));
  }

  @override
  String toString() {
    return '''
isLogin: ${isLogin},
isLoading: ${isLoading},
listMyQuestion: ${listMyQuestion},
listSearchQuestion: ${listSearchQuestion},
topicDiseaseModel: ${topicDiseaseModel},
page: ${page},
pageSearch: ${pageSearch},
keywordSearch: ${keywordSearch},
keyword: ${keyword}
    ''';
  }
}
