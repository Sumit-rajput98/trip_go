import 'package:flutter/material.dart';
import 'package:trip_go/AppManager/Api/api_service/AccountService/forgot_password_service.dart';
import 'package:trip_go/Model/AccountM/forgot_password_model.dart';

class ForgotPasswordViewModel extends ChangeNotifier {
  final ForgotPasswordService _service = ForgotPasswordService();

  ForgotPasswordModel? _forgotPasswordResponse;
  bool _isLoading = false;
  String? _errorMessage;

  ForgotPasswordModel? get response => _forgotPasswordResponse;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> sendResetLink(String emailOrMobile) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _service.forgotPass(emailOrMobile);
      _forgotPasswordResponse = result;

      if (result == null || result.success != true) {
        _errorMessage = result?.message ?? "Failed to send reset link";
      }
    } catch (e) {
      _errorMessage = "Something went wrong";
    }

    _isLoading = false;
    notifyListeners();
  }

  void clear() {
    _forgotPasswordResponse = null;
    _errorMessage = null;
    notifyListeners();
  }
}
