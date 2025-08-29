// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'on_board_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$OnBoardStore on _OnBoardStoreBase, Store {
  Computed<int>? _$slideComputed;

  @override
  int get slide => (_$slideComputed ??=
          Computed<int>(() => super.slide, name: '_OnBoardStoreBase.slide'))
      .value;
  Computed<List<String>>? _$tutorialsComputed;

  @override
  List<String> get tutorials =>
      (_$tutorialsComputed ??= Computed<List<String>>(() => super.tutorials,
              name: '_OnBoardStoreBase.tutorials'))
          .value;

  late final _$_prefsAtom =
      Atom(name: '_OnBoardStoreBase._prefs', context: context);

  @override
  Future<SharedPreferences> get _prefs {
    _$_prefsAtom.reportRead();
    return super._prefs;
  }

  @override
  set _prefs(Future<SharedPreferences> value) {
    _$_prefsAtom.reportWrite(value, super._prefs, () {
      super._prefs = value;
    });
  }

  late final _$slideNoAtom =
      Atom(name: '_OnBoardStoreBase.slideNo', context: context);

  @override
  int get slideNo {
    _$slideNoAtom.reportRead();
    return super.slideNo;
  }

  @override
  set slideNo(int value) {
    _$slideNoAtom.reportWrite(value, super.slideNo, () {
      super.slideNo = value;
    });
  }

  late final _$tutorialListAtom =
      Atom(name: '_OnBoardStoreBase.tutorialList', context: context);

  @override
  ObservableList<TutorialModel> get tutorialList {
    _$tutorialListAtom.reportRead();
    return super.tutorialList;
  }

  @override
  set tutorialList(ObservableList<TutorialModel> value) {
    _$tutorialListAtom.reportWrite(value, super.tutorialList, () {
      super.tutorialList = value;
    });
  }

  late final _$getTutorialAsyncAction =
      AsyncAction('_OnBoardStoreBase.getTutorial', context: context);

  @override
  Future<void> getTutorial() {
    return _$getTutorialAsyncAction.run(() => super.getTutorial());
  }

  late final _$_OnBoardStoreBaseActionController =
      ActionController(name: '_OnBoardStoreBase', context: context);

  @override
  void changeSlide(dynamic indexOfPage) {
    final _$actionInfo = _$_OnBoardStoreBaseActionController.startAction(
        name: '_OnBoardStoreBase.changeSlide');
    try {
      return super.changeSlide(indexOfPage);
    } finally {
      _$_OnBoardStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
slideNo: ${slideNo},
tutorialList: ${tutorialList},
slide: ${slide},
tutorials: ${tutorials}
    ''';
  }
}
