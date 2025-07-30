import 'package:flutter/material.dart';
import 'package:trip_go/Model/AccountM/validate_otp_model.dart';
import 'package:trip_go/AppManager/Api/api_service/AccountService/validate_otp_service.dart';

class ValidateOtpViewModel extends ChangeNotifier {
  final ValidateOtpService _otpService = ValidateOtpService();

  bool _isLoading = false;
  String? _errorMessage;
  ValidateOtpModel? _otpResponse;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  ValidateOtpModel? get otpResponse => _otpResponse;

  Future<void> validateOtp({
    required String countryCode,
    required String phoneNumber,
    required String otp,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    _otpResponse = null;
    notifyListeners();

    try {
      final response = await _otpService.login(countryCode, phoneNumber, otp);
      _otpResponse = response;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void reset() {
    _isLoading = false;
    _errorMessage = null;
    _otpResponse = null;
    notifyListeners();
  }
}
