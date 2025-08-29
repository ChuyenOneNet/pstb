import 'package:pstb/utils/sessions/session_prefs.dart';
import 'package:pstb/utils/helper.dart';

class UserGuard {
  Future<UserStatus> canActivate() async {
    final isSignedIn = await SessionPrefs.isSignedIn();
    if (isSignedIn) {
      return UserStatus.Signed;
    }
    return UserStatus.NoData;
  }
}
