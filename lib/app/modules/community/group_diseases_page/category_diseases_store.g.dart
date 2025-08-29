// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_diseases_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CategoryDiseasesStore on CategoryDiseasesStoreBase, Store {
  late final _$categoryAtom =
      Atom(name: 'CategoryDiseasesStoreBase.category', context: context);

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
      Atom(name: 'CategoryDiseasesStoreBase.state', context: context);

  @override
  CategoryDiseasesState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(CategoryDiseasesState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$initStateAsyncAction =
      AsyncAction('CategoryDiseasesStoreBase.initState', context: context);

  @override
  Future<void> initState() {
    return _$initStateAsyncAction.run(() => super.initState());
  }

  late final _$pushDetailAnswerAsyncAction = AsyncAction(
      'CategoryDiseasesStoreBase.pushDetailAnswer',
      context: context);

  @override
  Future<void> pushDetailAnswer(CategoryDiseaseModel categoryDiseasesModel) {
    return _$pushDetailAnswerAsyncAction
        .run(() => super.pushDetailAnswer(categoryDiseasesModel));
  }

  @override
  String toString() {
    return '''
category: ${category},
state: ${state}
    ''';
  }
}
