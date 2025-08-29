// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_answer_disease_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DetailAnswerDiseaseStore on DetailAnswerDiseaseBase, Store {
  late final _$categoryDiseaseModelAtom = Atom(
      name: 'DetailAnswerDiseaseBase.categoryDiseaseModel', context: context);

  @override
  CategoryDiseaseModel get categoryDiseaseModel {
    _$categoryDiseaseModelAtom.reportRead();
    return super.categoryDiseaseModel;
  }

  @override
  set categoryDiseaseModel(CategoryDiseaseModel value) {
    _$categoryDiseaseModelAtom.reportWrite(value, super.categoryDiseaseModel,
        () {
      super.categoryDiseaseModel = value;
    });
  }

  late final _$topicDiseaseModelAtom =
      Atom(name: 'DetailAnswerDiseaseBase.topicDiseaseModel', context: context);

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

  late final _$itemsAtom =
      Atom(name: 'DetailAnswerDiseaseBase.items', context: context);

  @override
  ObservableList<Items> get items {
    _$itemsAtom.reportRead();
    return super.items;
  }

  @override
  set items(ObservableList<Items> value) {
    _$itemsAtom.reportWrite(value, super.items, () {
      super.items = value;
    });
  }

  late final _$stateAtom =
      Atom(name: 'DetailAnswerDiseaseBase.state', context: context);

  @override
  DetailState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(DetailState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$questionStateAtom =
      Atom(name: 'DetailAnswerDiseaseBase.questionState', context: context);

  @override
  DetailQuestionState get questionState {
    _$questionStateAtom.reportRead();
    return super.questionState;
  }

  @override
  set questionState(DetailQuestionState value) {
    _$questionStateAtom.reportWrite(value, super.questionState, () {
      super.questionState = value;
    });
  }

  late final _$loadMoreStateAtom =
      Atom(name: 'DetailAnswerDiseaseBase.loadMoreState', context: context);

  @override
  LoadMoreState get loadMoreState {
    _$loadMoreStateAtom.reportRead();
    return super.loadMoreState;
  }

  @override
  set loadMoreState(LoadMoreState value) {
    _$loadMoreStateAtom.reportWrite(value, super.loadMoreState, () {
      super.loadMoreState = value;
    });
  }

  late final _$lengthLoadMoreAtom =
      Atom(name: 'DetailAnswerDiseaseBase.lengthLoadMore', context: context);

  @override
  int get lengthLoadMore {
    _$lengthLoadMoreAtom.reportRead();
    return super.lengthLoadMore;
  }

  @override
  set lengthLoadMore(int value) {
    _$lengthLoadMoreAtom.reportWrite(value, super.lengthLoadMore, () {
      super.lengthLoadMore = value;
    });
  }

  late final _$pageAtom =
      Atom(name: 'DetailAnswerDiseaseBase.page', context: context);

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

  late final _$isActiveButtonAtom =
      Atom(name: 'DetailAnswerDiseaseBase.isActiveButton', context: context);

  @override
  bool get isActiveButton {
    _$isActiveButtonAtom.reportRead();
    return super.isActiveButton;
  }

  @override
  set isActiveButton(bool value) {
    _$isActiveButtonAtom.reportWrite(value, super.isActiveButton, () {
      super.isActiveButton = value;
    });
  }

  late final _$createQuestionAsyncAction =
      AsyncAction('DetailAnswerDiseaseBase.createQuestion', context: context);

  @override
  Future<void> createQuestion() {
    return _$createQuestionAsyncAction.run(() => super.createQuestion());
  }

  late final _$initStateAsyncAction =
      AsyncAction('DetailAnswerDiseaseBase.initState', context: context);

  @override
  Future<void> initState(CategoryDiseaseModel categoryDiseaseModel) {
    return _$initStateAsyncAction
        .run(() => super.initState(categoryDiseaseModel));
  }

  late final _$onRefreshAsyncAction =
      AsyncAction('DetailAnswerDiseaseBase.onRefresh', context: context);

  @override
  Future<void> onRefresh() {
    return _$onRefreshAsyncAction.run(() => super.onRefresh());
  }

  late final _$loadMoreAsyncAction =
      AsyncAction('DetailAnswerDiseaseBase.loadMore', context: context);

  @override
  Future<void> loadMore() {
    return _$loadMoreAsyncAction.run(() => super.loadMore());
  }

  late final _$DetailAnswerDiseaseBaseActionController =
      ActionController(name: 'DetailAnswerDiseaseBase', context: context);

  @override
  void onChangedQuestion(String value) {
    final _$actionInfo = _$DetailAnswerDiseaseBaseActionController.startAction(
        name: 'DetailAnswerDiseaseBase.onChangedQuestion');
    try {
      return super.onChangedQuestion(value);
    } finally {
      _$DetailAnswerDiseaseBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void dispose() {
    final _$actionInfo = _$DetailAnswerDiseaseBaseActionController.startAction(
        name: 'DetailAnswerDiseaseBase.dispose');
    try {
      return super.dispose();
    } finally {
      _$DetailAnswerDiseaseBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
categoryDiseaseModel: ${categoryDiseaseModel},
topicDiseaseModel: ${topicDiseaseModel},
items: ${items},
state: ${state},
questionState: ${questionState},
loadMoreState: ${loadMoreState},
lengthLoadMore: ${lengthLoadMore},
page: ${page},
isActiveButton: ${isActiveButton}
    ''';
  }
}
