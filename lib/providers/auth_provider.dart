import 'dart:io';

import 'package:flutter/material.dart';
import 'package:smart_tv_shop/services/auth_service.dart';
import 'package:smart_tv_shop/services/image_service.dart';

class AuthStateProvider extends ChangeNotifier {

  bool _state = false;

  File? _imagePath = File("");

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

  Future<String> signUp(
    String email,
    String password,
    String role,
    String name,
    String contact,
    String address,
  ) async {
    try {
      await AuthService.signUp(email, password, role, name, contact,address);
      return "success";
    } catch (e) {
      print(e);
      return "error";
    }
  }

  Future<void> login(String email, String password,String role,BuildContext context) async {
    try{
      await AuthService.signIn(email, password, role,context);
    }catch(e){
      print(e);
    }
  }
}
