import 'package:flutter/foundation.dart';
import 'package:trip_go/AppManager/Api/api_service/AccountService/login_service.dart';
import 'package:trip_go/Model/AccountM/login_model.dart';


class LoginViewModel extends ChangeNotifier {
  final LoginService _loginService = LoginService();

  bool _isLoading = false;
  String? _errorMessage;
  LoginModel? _loginModel;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  LoginModel? get loginModel => _loginModel;

  Future<void> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _loginService.login(email, password);
      _loginModel = result;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void reset() {
    _loginModel = null;
    _errorMessage = null;
    notifyListeners();
  }
}
