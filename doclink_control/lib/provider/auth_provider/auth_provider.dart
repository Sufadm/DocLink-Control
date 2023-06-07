import 'package:flutter/material.dart';

class LoginModel extends ChangeNotifier {
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;

  void updateEmail(String value) {
    email = value;
    notifyListeners();
  }

  void updatePassword(String value) {
    password = value;
    notifyListeners();
  }

  void setError(String message) {
    error = message;
    notifyListeners();
  }

  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }
}
