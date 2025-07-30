import 'package:flutter/foundation.dart';
import 'package:trip_go/AppManager/Api/api_service/AccountService/login_otp_service.dart';
import 'package:trip_go/Model/AccountM/login_otp_model.dart';

class LoginOtpViewModel extends ChangeNotifier {
  final LoginOtpService _loginOtpService = LoginOtpService();

  bool _isLoading = false;
  String? _errorMessage;
  LoginOtpModel? _otpResponse;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  LoginOtpModel? get otpResponse => _otpResponse;

  /// Call this to trigger OTP login
  Future<void> loginWithOtp(dynamic body) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _loginOtpService.login(body);
      _otpResponse = result;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Reset the state (call this before making a new request or logout)
  void reset() {
    _otpResponse = null;
    _errorMessage = null;
    notifyListeners();
  }
}
