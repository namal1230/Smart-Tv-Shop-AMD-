import 'dart:io';

import 'package:flutter/material.dart';
import 'package:smart_tv_shop/services/image_service.dart';

class AuthStateProvider extends ChangeNotifier {
  // AuthProvider implementation will go here
  bool _state = false;

  File? _imagePath=File("");

  get state => _state;

  File? get imagePath => _imagePath;

  final ImageService _imageService = ImageService();

  void setState(bool newState) {
    _state = newState;
    notifyListeners();
  }

  void setImagePath(File path) {
    _imagePath = path;
    notifyListeners();
  }

  Future<void> pickImage(String option) async {
    File? selectedImage = await _imageService.selectImage(option);
    if (selectedImage != null) {
      setImagePath(selectedImage);
    }
  }

}