import 'package:doclink_control/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user obj based on FirebaseUser
  UserModel? _userFromCredential(User? user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }

  Stream<UserModel?> get userlog {
    return _auth
        .authStateChanges()
        .map((User? user) => _userFromCredential(user));
  }

  //sign in with email & password

  Future signEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromCredential(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email & password
  Future resgisterwithEmailAndPaswword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromCredential(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Logout out
  Future logout() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
