// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medicine_order_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MedicineOrderStore on _MedicineOrderStore, Store {
  Computed<bool>? _$isAllSelectedComputed;

  @override
  bool get isAllSelected =>
      (_$isAllSelectedComputed ??= Computed<bool>(() => super.isAllSelected,
              name: '_MedicineOrderStore.isAllSelected'))
          .value;
  Computed<List<MedicineOrder>>? _$selectedOrdersComputed;

  @override
  List<MedicineOrder> get selectedOrders => (_$selectedOrdersComputed ??=
          Computed<List<MedicineOrder>>(() => super.selectedOrders,
              name: '_MedicineOrderStore.selectedOrders'))
      .value;

  late final _$ordersAtom =
      Atom(name: '_MedicineOrderStore.orders', context: context);

  @override
  ObservableList<MedicineOrder> get orders {
    _$ordersAtom.reportRead();
    return super.orders;
  }

  @override
  set orders(ObservableList<MedicineOrder> value) {
    _$ordersAtom.reportWrite(value, super.orders, () {
      super.orders = value;
    });
  }

  late final _$submitOrdersAsyncAction =
      AsyncAction('_MedicineOrderStore.submitOrders', context: context);

  @override
  Future<void> submitOrders() {
    return _$submitOrdersAsyncAction.run(() => super.submitOrders());
  }

  late final _$_MedicineOrderStoreActionController =
      ActionController(name: '_MedicineOrderStore', context: context);

  @override
  void fetchOrders() {
    final _$actionInfo = _$_MedicineOrderStoreActionController.startAction(
        name: '_MedicineOrderStore.fetchOrders');
    try {
      return super.fetchOrders();
    } finally {
      _$_MedicineOrderStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleItem(int index) {
    final _$actionInfo = _$_MedicineOrderStoreActionController.startAction(
        name: '_MedicineOrderStore.toggleItem');
    try {
      return super.toggleItem(index);
    } finally {
      _$_MedicineOrderStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleAll() {
    final _$actionInfo = _$_MedicineOrderStoreActionController.startAction(
        name: '_MedicineOrderStore.toggleAll');
    try {
      return super.toggleAll();
    } finally {
      _$_MedicineOrderStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
orders: ${orders},
isAllSelected: ${isAllSelected},
selectedOrders: ${selectedOrders}
    ''';
  }
}
