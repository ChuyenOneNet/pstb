// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'first_aid_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FirstAidStore on FirstAidStoreBase, Store {
  Computed<List<FirstAidsViewModel>>? _$listTutorialComputed;

  @override
  List<FirstAidsViewModel> get listTutorial => (_$listTutorialComputed ??=
          Computed<List<FirstAidsViewModel>>(() => super.listTutorial,
              name: 'FirstAidStoreBase.listTutorial'))
      .value;

  late final _$loadingAtom =
      Atom(name: 'FirstAidStoreBase.loading', context: context);

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

  late final _$firstAidsAtom =
      Atom(name: 'FirstAidStoreBase.firstAids', context: context);

  @override
  ObservableList<EmergencyModel> get firstAids {
    _$firstAidsAtom.reportRead();
    return super.firstAids;
  }

  @override
  set firstAids(ObservableList<EmergencyModel> value) {
    _$firstAidsAtom.reportWrite(value, super.firstAids, () {
      super.firstAids = value;
    });
  }

  late final _$getEmergencyAsyncAction =
      AsyncAction('FirstAidStoreBase.getEmergency', context: context);

  @override
  Future<void> getEmergency({required BuildContext newContext}) {
    return _$getEmergencyAsyncAction
        .run(() => super.getEmergency(newContext: newContext));
  }

  late final _$FirstAidStoreBaseActionController =
      ActionController(name: 'FirstAidStoreBase', context: context);

  @override
  void navigateTo(String route) {
    final _$actionInfo = _$FirstAidStoreBaseActionController.startAction(
        name: 'FirstAidStoreBase.navigateTo');
    try {
      return super.navigateTo(route);
    } finally {
      _$FirstAidStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loading: ${loading},
firstAids: ${firstAids},
listTutorial: ${listTutorial}
    ''';
  }
}
