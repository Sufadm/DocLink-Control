import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileProvider extends ChangeNotifier {
  File? _photo;
  File? get photo => _photo;
  String photoUrl = '';
  String error = '';
  bool loading = false;
  void setError(String message) {
    error = message;
    notifyListeners();
  }

  void setPhoto(File? photo) {
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
