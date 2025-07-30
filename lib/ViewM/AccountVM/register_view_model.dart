import 'package:flutter/material.dart';
import 'package:trip_go/AppManager/Api/api_service/AccountService/register_service.dart';
import 'package:trip_go/Model/AccountM/register_model.dart';


class RegisterViewModel extends ChangeNotifier {
  final RegisterService _registerService = RegisterService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  RegisterModel? _registerResponse;
  RegisterModel? get registerResponse => _registerResponse;

  Future<void> registerUser(dynamic body) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _registerService.login(body);
      _registerResponse = response;
    } catch (e) {
       print("Eror: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

 
  void clearResponse() {
    _registerResponse = null;
    notifyListeners();
  }
}
