import 'package:flutter/material.dart';
import 'package:trip_go/AppManager/Api/api_service/AccountService/change_password_service.dart';
import 'package:trip_go/Model/AccountM/change_password_model.dart';
 // Adjust if your path differs

class ChangePasswordViewModel extends ChangeNotifier {
  final ChangePasswordService _changePasswordService = ChangePasswordService();

  bool _isLoading = false;
  String? _errorMessage;
  ChangePasswordModel? _changePasswordResponse;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  ChangePasswordModel? get changePasswordResponse => _changePasswordResponse;

  /// Call this function from the UI with the request body.
  Future<void> changePassword(dynamic body) async {
    _setLoading(true);
    _errorMessage = null;

    try {
      final response = await _changePasswordService.changePassword(body);
      _changePasswordResponse = response;
    } catch (e) {
      _errorMessage = "Something went wrong. Please try again.";
      debugPrint("ChangePassword Error: $e");
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void clear() {
    _changePasswordResponse = null;
    _errorMessage = null;
    _isLoading = false;
    notifyListeners();
  }
}
