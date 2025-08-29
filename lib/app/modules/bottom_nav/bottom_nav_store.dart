import 'package:mobx/mobx.dart';

import '../../../utils/sessions/session_prefs.dart';

part 'bottom_nav_store.g.dart';

class BottomNavStore = _BottomNavStoreBase with _$BottomNavStore;

abstract class _BottomNavStoreBase with Store {
  @observable
  int currentIndex = 4;
  @observable
  bool isMainPage = true;
  @observable
  bool isLogin = false;

  @action
  Future<void> checkLogin() async {
    final isSignedIn = await SessionPrefs.isSignedIn();
    if (isSignedIn) {
      isLogin = true;
    } else {
      isLogin = false;
    }
  }

  @action
  void updateCurrentIndex(int index) => currentIndex = index;

  @action
  void updateCheckMainPage(bool value) => isMainPage = value;
}
