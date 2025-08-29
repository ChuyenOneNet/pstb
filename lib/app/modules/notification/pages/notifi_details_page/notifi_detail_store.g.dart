// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifi_detail_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$NotificationDetailsStore on NotificationDetailsStoreBase, Store {
  Computed<String>? _$getDateComputed;

  @override
  String get getDate =>
      (_$getDateComputed ??= Computed<String>(() => super.getDate,
              name: 'NotificationDetailsStoreBase.getDate'))
          .value;
  Computed<String>? _$getTitleComputed;

  @override
  String get getTitle =>
      (_$getTitleComputed ??= Computed<String>(() => super.getTitle,
              name: 'NotificationDetailsStoreBase.getTitle'))
          .value;
  Computed<String>? _$getPhoneComputed;

  @override
  String get getPhone =>
      (_$getPhoneComputed ??= Computed<String>(() => super.getPhone,
              name: 'NotificationDetailsStoreBase.getPhone'))
          .value;
  Computed<String>? _$getUrlComputed;

  @override
  String get getUrl =>
      (_$getUrlComputed ??= Computed<String>(() => super.getUrl,
              name: 'NotificationDetailsStoreBase.getUrl'))
          .value;
  Computed<bool>? _$getLoadingStateComputed;

  @override
  bool get getLoadingState =>
      (_$getLoadingStateComputed ??= Computed<bool>(() => super.getLoadingState,
              name: 'NotificationDetailsStoreBase.getLoadingState'))
          .value;

  late final _$dateAtom =
      Atom(name: 'NotificationDetailsStoreBase.date', context: context);

  @override
  String get date {
    _$dateAtom.reportRead();
    return super.date;
  }

  @override
  set date(String value) {
    _$dateAtom.reportWrite(value, super.date, () {
      super.date = value;
    });
  }

  late final _$titleAtom =
      Atom(name: 'NotificationDetailsStoreBase.title', context: context);

  @override
  String get title {
    _$titleAtom.reportRead();
    return super.title;
  }

  @override
  set title(String value) {
    _$titleAtom.reportWrite(value, super.title, () {
      super.title = value;
    });
  }

  late final _$phoneAtom =
      Atom(name: 'NotificationDetailsStoreBase.phone', context: context);

  @override
  String get phone {
    _$phoneAtom.reportRead();
    return super.phone;
  }

  @override
  set phone(String value) {
    _$phoneAtom.reportWrite(value, super.phone, () {
      super.phone = value;
    });
  }

  late final _$urlAtom =
      Atom(name: 'NotificationDetailsStoreBase.url', context: context);

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

  late final _$isLoadingDataAtom = Atom(
      name: 'NotificationDetailsStoreBase.isLoadingData', context: context);

  @override
  bool get isLoadingData {
    _$isLoadingDataAtom.reportRead();
    return super.isLoadingData;
  }

  @override
  set isLoadingData(bool value) {
    _$isLoadingDataAtom.reportWrite(value, super.isLoadingData, () {
      super.isLoadingData = value;
    });
  }

  late final _$loadDetailsAsyncAction =
      AsyncAction('NotificationDetailsStoreBase.loadDetails', context: context);

  @override
  Future<void> loadDetails(
      RemoteMessage? message, NotificationItemModel? noti) {
    return _$loadDetailsAsyncAction.run(() => super.loadDetails(message, noti));
  }

  @override
  String toString() {
    return '''
date: ${date},
title: ${title},
phone: ${phone},
url: ${url},
isLoadingData: ${isLoadingData},
getDate: ${getDate},
getTitle: ${getTitle},
getPhone: ${getPhone},
getUrl: ${getUrl},
getLoadingState: ${getLoadingState}
    ''';
  }
}
