import 'package:doclink_control/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  //?create user obj based on FirebaseUser--------------------------------------
  UserModel? _userFromCredential(User? user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }

  Stream<UserModel?> get userlog {
    return auth
        .authStateChanges()
        .map((User? user) => _userFromCredential(user));
  }

  //?sign in with email & password----------------------------------------------
  Future signEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromCredential(user);
    } catch (e) {
      return null;
    }
  }

  //?register with email & password---------------------------------------------
  Future resgisterwithEmailAndPaswword(String email, String password) async {
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      return _userFromCredential(user);
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'Email-already-in-use') {
          throw 'Email-already-in-use';
        }
      }
      return null;
    }
  }

  //?Logout out-----------------------------------------------------------------
  Future logout() async {
    try {
      return await auth.signOut();
    } catch (e) {
      return null;
    }
  }
}
