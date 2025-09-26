import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../service/network/AuthService.dart';


enum AuthStatus { idle, loading, success, error }

class AuthVm extends ChangeNotifier {
  final AuthService _authService = AuthService();

  AuthStatus _status = AuthStatus.idle;
  String _errorMessage = '';
  User? _user;

  AuthStatus get status => _status;
  String get errorMessage => _errorMessage;
  User? get user => _user;

  AuthVm() {

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }


  Future<void> signUp(String email, String password) async {
    _status = AuthStatus.loading;
    notifyListeners();

    try {
      _user = await _authService.signUp(email, password);
      _status = AuthStatus.success;
    } catch (e) {
      _status = AuthStatus.error;
      _errorMessage = e.toString();
    }

    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    _status = AuthStatus.loading;
    notifyListeners();

    try {
      _user = await _authService.login(email, password);
      _status = AuthStatus.success;
    } catch (e) {
      _status = AuthStatus.error;
      _errorMessage = e.toString();
    }

    notifyListeners();
  }


  Future<void> logout() async {
    await _authService.logout();
    _user = null;
    _status = AuthStatus.idle;
    notifyListeners();
  }

  // Check if user is logged in
  bool get isLoggedIn => _user != null;
}
