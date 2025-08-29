// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_specific_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ListSpecificStore on ListSpecificStoreBase, Store {
  late final _$isLoadingAtom =
      Atom(name: 'ListSpecificStoreBase.isLoading', context: context);

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

  late final _$currentIndexAtom =
      Atom(name: 'ListSpecificStoreBase.currentIndex', context: context);

  @override
  int get currentIndex {
    _$currentIndexAtom.reportRead();
    return super.currentIndex;
  }

  @override
  set currentIndex(int value) {
    _$currentIndexAtom.reportWrite(value, super.currentIndex, () {
      super.currentIndex = value;
    });
  }

  late final _$listGroupByStatusAtom =
      Atom(name: 'ListSpecificStoreBase.listGroupByStatus', context: context);

  @override
  Map<String, Paging<RegistrationModel>?> get listGroupByStatus {
    _$listGroupByStatusAtom.reportRead();
    return super.listGroupByStatus;
  }

  @override
  set listGroupByStatus(Map<String, Paging<RegistrationModel>?> value) {
    _$listGroupByStatusAtom.reportWrite(value, super.listGroupByStatus, () {
      super.listGroupByStatus = value;
    });
  }

  late final _$onChangeTabAsyncAction =
      AsyncAction('ListSpecificStoreBase.onChangeTab', context: context);

  @override
  Future<void> onChangeTab(int indexSelected) {
    return _$onChangeTabAsyncAction.run(() => super.onChangeTab(indexSelected));
  }

  late final _$loadMoreAsyncAction =
      AsyncAction('ListSpecificStoreBase.loadMore', context: context);

  @override
  Future<void> loadMore() {
    return _$loadMoreAsyncAction.run(() => super.loadMore());
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
currentIndex: ${currentIndex},
listGroupByStatus: ${listGroupByStatus}
    ''';
  }
}
