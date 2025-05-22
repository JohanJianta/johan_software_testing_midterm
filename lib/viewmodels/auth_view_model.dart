import 'package:johan_software_testing_midterm/models/models.dart';
import 'package:flutter/material.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService;
  RequestStatus status = RequestStatus.idle;
  User? user;

  AuthViewModel({AuthService? authService}) : _authService = authService ?? AuthService();

  void notifyStatus(RequestStatus newStatus) {
    status = newStatus;
    notifyListeners();
  }

  String? validateUsername(String username) {
    if (username.isEmpty) return "Username cannot be empty.";
    if (username.contains(RegExp(r'[^\w]'))) return "Invalid characters in username.";
    if (username.length < 3 || username.length > 20) return "Invalid username length.";
    return null;
  }

  String? validatePassword(String password) {
    if (password.isEmpty) return "Password cannot be empty.";
    if (password.length < 6) return "Password must be at least 6 characters long.";
    if (password.length > 20) return "Password too long.";
    return null;
  }

  Future<void> initiateLogin(String username, String password) async {
    try {
      notifyStatus(RequestStatus.loading);
      user = await _authService.login(username, password);
      notifyStatus(RequestStatus.idle);
    } catch (e) {
      notifyStatus(RequestStatus.error);
      rethrow;
    }
  }

  Future<void> initiateLogout() async {
    try {
      notifyStatus(RequestStatus.loading);
      await _authService.logout();
      notifyStatus(RequestStatus.idle);
    } catch (e) {
      notifyStatus(RequestStatus.error);
      rethrow;
    }
  }
}

enum RequestStatus { idle, loading, error }
