// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$QuestionStore on QuestionStoreBase, Store {
  late final _$categoryAtom =
      Atom(name: 'QuestionStoreBase.category', context: context);

  @override
  ObservableList<CategoryDiseaseModel> get category {
    _$categoryAtom.reportRead();
    return super.category;
  }

  @override
  set category(ObservableList<CategoryDiseaseModel> value) {
    _$categoryAtom.reportWrite(value, super.category, () {
      super.category = value;
    });
  }

  late final _$stateAtom =
      Atom(name: 'QuestionStoreBase.state', context: context);

  @override
  QuestionState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(QuestionState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$categoryDiseaseModelAtom =
      Atom(name: 'QuestionStoreBase.categoryDiseaseModel', context: context);

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

  late final _$isActiveButtonAtom =
      Atom(name: 'QuestionStoreBase.isActiveButton', context: context);

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

  late final _$initStateAsyncAction =
      AsyncAction('QuestionStoreBase.initState', context: context);

  @override
  Future<void> initState() {
    return _$initStateAsyncAction.run(() => super.initState());
  }

  late final _$createQuestionAsyncAction =
      AsyncAction('QuestionStoreBase.createQuestion', context: context);

  @override
  Future<void> createQuestion() {
    return _$createQuestionAsyncAction.run(() => super.createQuestion());
  }

  late final _$pushDetailAnswerAsyncAction =
      AsyncAction('QuestionStoreBase.pushDetailAnswer', context: context);

  @override
  Future<void> pushDetailAnswer(CategoryDiseaseModel categoryDiseasesModel) {
    return _$pushDetailAnswerAsyncAction
        .run(() => super.pushDetailAnswer(categoryDiseasesModel));
  }

  late final _$QuestionStoreBaseActionController =
      ActionController(name: 'QuestionStoreBase', context: context);

  @override
  void onChangedGroup(String? value) {
    final _$actionInfo = _$QuestionStoreBaseActionController.startAction(
        name: 'QuestionStoreBase.onChangedGroup');
    try {
      return super.onChangedGroup(value);
    } finally {
      _$QuestionStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onChangedQuestion(String value) {
    final _$actionInfo = _$QuestionStoreBaseActionController.startAction(
        name: 'QuestionStoreBase.onChangedQuestion');
    try {
      return super.onChangedQuestion(value);
    } finally {
      _$QuestionStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
category: ${category},
state: ${state},
categoryDiseaseModel: ${categoryDiseaseModel},
isActiveButton: ${isActiveButton}
    ''';
  }
}
