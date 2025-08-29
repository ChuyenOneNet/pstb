import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  signOut() {
    FirebaseAuth.instance.signOut();
  }

  signIn(AuthCredential credential) {
    FirebaseAuth.instance.signInWithCredential(credential);
  }
}
