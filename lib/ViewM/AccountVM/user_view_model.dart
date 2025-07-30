import 'package:flutter/material.dart';
import 'package:trip_go/AppManager/Api/api_service/AccountService/user_service.dart';
import 'package:trip_go/Model/AccountM/user_model.dart';

class UserViewModel extends ChangeNotifier {
  final UserService _userService = UserService();

  UserModel? _userModel;
  bool _isLoading = false;
  String? _error;

  UserModel? get userModel => _userModel;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchUserDetail(dynamic body) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _userService.getUserDetail(body);
      _userModel = response;
    } catch (e) {
      _error = 'Failed to load user data';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearUser() {
    _userModel = null;
    notifyListeners();
  }
}
