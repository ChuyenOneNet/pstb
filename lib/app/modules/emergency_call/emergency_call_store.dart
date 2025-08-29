import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'emergency_call_store.g.dart';

class EmergencyCallStore = EmergencyCallStoreBase with _$EmergencyCallStore;

abstract class EmergencyCallStoreBase with Store {
  @observable
  @action
  void navigateTo(String route) {
    Modular.to.pushNamed(route);
  }
}
