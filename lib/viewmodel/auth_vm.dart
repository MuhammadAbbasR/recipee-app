import 'package:flutter/material.dart';

class AuthVm with ChangeNotifier {
  bool _isLoggedIn = true;

  bool get isLoggedIn => _isLoggedIn;

  void login() {
    _isLoggedIn = true;
    notifyListeners();

  }


  void logout() {
    _isLoggedIn = false;
    notifyListeners();

  }

}
