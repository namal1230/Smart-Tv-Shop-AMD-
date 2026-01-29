import 'package:flutter/material.dart';

class AuthStateProvider extends ChangeNotifier {
  // AuthProvider implementation will go here
  bool _state = false;

  get state => _state;

  void setState(bool newState) {
    _state = newState;
    notifyListeners();
  }

}