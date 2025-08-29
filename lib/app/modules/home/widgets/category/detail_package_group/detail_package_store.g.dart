// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_package_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DetailPackageStore on DetailPackageStoreBase, Store {
  late final _$detailPackageGroupModelAtom = Atom(
      name: 'DetailPackageStoreBase.detailPackageGroupModel', context: context);

  @override
  Paging<PackageModel> get detailPackageGroupModel {
    _$detailPackageGroupModelAtom.reportRead();
    return super.detailPackageGroupModel;
  }

  @override
  set detailPackageGroupModel(Paging<PackageModel> value) {
    _$detailPackageGroupModelAtom
        .reportWrite(value, super.detailPackageGroupModel, () {
      super.detailPackageGroupModel = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'DetailPackageStoreBase.isLoading', context: context);

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

  late final _$titleAppbarAtom =
      Atom(name: 'DetailPackageStoreBase.titleAppbar', context: context);

  @override
  String get titleAppbar {
    _$titleAppbarAtom.reportRead();
    return super.titleAppbar;
  }

  @override
  set titleAppbar(String value) {
    _$titleAppbarAtom.reportWrite(value, super.titleAppbar, () {
      super.titleAppbar = value;
    });
  }

  late final _$listPackageAtom =
      Atom(name: 'DetailPackageStoreBase.listPackage', context: context);

  @override
  List<PackageModel> get listPackage {
    _$listPackageAtom.reportRead();
    return super.listPackage;
  }

  @override
  set listPackage(List<PackageModel> value) {
    _$listPackageAtom.reportWrite(value, super.listPackage, () {
      super.listPackage = value;
    });
  }

  late final _$otherListPackageAtom =
      Atom(name: 'DetailPackageStoreBase.otherListPackage', context: context);

  @override
  List<PackageModel> get otherListPackage {
    _$otherListPackageAtom.reportRead();
    return super.otherListPackage;
  }

  @override
  set otherListPackage(List<PackageModel> value) {
    _$otherListPackageAtom.reportWrite(value, super.otherListPackage, () {
      super.otherListPackage = value;
    });
  }

  late final _$initDetailAsyncAction =
      AsyncAction('DetailPackageStoreBase.initDetail', context: context);

  @override
  Future<void> initDetail(int id, {String name = ''}) {
    return _$initDetailAsyncAction.run(() => super.initDetail(id, name: name));
  }

  late final _$loadMorePackageAsyncAction =
      AsyncAction('DetailPackageStoreBase.loadMorePackage', context: context);

  @override
  Future<void> loadMorePackage() {
    return _$loadMorePackageAsyncAction.run(() => super.loadMorePackage());
  }

  late final _$onRefreshPackageAsyncAction =
      AsyncAction('DetailPackageStoreBase.onRefreshPackage', context: context);

  @override
  Future<void> onRefreshPackage() {
    return _$onRefreshPackageAsyncAction.run(() => super.onRefreshPackage());
  }

  @override
  String toString() {
    return '''
detailPackageGroupModel: ${detailPackageGroupModel},
isLoading: ${isLoading},
titleAppbar: ${titleAppbar},
listPackage: ${listPackage},
otherListPackage: ${otherListPackage}
    ''';
  }
}
