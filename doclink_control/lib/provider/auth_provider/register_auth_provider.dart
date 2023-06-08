import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class RegisterModel extends ChangeNotifier {
  File? _photo;

  File? get photo => _photo;
  String phoneNumber = '';
  String error = '';
  String email = '';
  String password = '';
  String confirmpassword = '';
  bool loading = false;

  void phonenumber(String value) {
    phoneNumber = value;
    notifyListeners();
  }

  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  void updateEmail(String value) {
    email = value;
    notifyListeners();
  }

  void updatePassword(String value) {
    password = value;
    notifyListeners();
  }

  void updatePasswordagain(String value) {
    confirmpassword = value;
    notifyListeners();
  }

  void setError(String message) {
    error = message;
    notifyListeners();
  }

  Future<void> setPhoto(File? photo) async {
    _photo = photo;
    notifyListeners();
  }

  Future<void> getPhoto(BuildContext context) async {
    final photo = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (photo == null) {
      return;
    } else {
      final photoTemp = File(photo.path);
      _photo = photoTemp;
      notifyListeners();
    }
  }
}
