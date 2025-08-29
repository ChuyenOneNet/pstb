import 'package:mobx/mobx.dart';

part 'steps_foot_store.g.dart';

class StepsFootStore = _StepsFootStoreBase with _$StepsFootStore;

abstract class _StepsFootStoreBase with Store {

  @observable
  String steps = '0';
}