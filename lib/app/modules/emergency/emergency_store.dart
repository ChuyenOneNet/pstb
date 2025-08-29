import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/utils/helpers/config_helper.dart';
import 'package:mobx/mobx.dart';

part 'emergency_store.g.dart';

class EmergencyStore = EmergencyStoreBase with _$EmergencyStore;

abstract class EmergencyStoreBase with Store {
  String? get sosPhoneNumber =>
      ConfigHelper.instance.getConfigByCodeSync(ConfigHelper.sosLine)?.value;


  String? get supportPhoneNumber =>
      ConfigHelper.instance.getConfigByCodeSync(ConfigHelper.supportLine)?.value;

  String? get supportMessenger =>
      ConfigHelper.instance.getConfigByCodeSync(ConfigHelper.supportMess)?.value;

  void navigateTo(String route) {
    Modular.to.pushNamed(route);
  }
}
