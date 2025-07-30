import 'package:flutter/material.dart';
import '../../AppManager/Api/api_service/BusService/bus_verify_payment_service.dart';
import '../../Model/BusM/bus_verify_payment_model.dart';

class BusVerifyPaymentViewModel extends ChangeNotifier {
  BusVerifyPaymentResponse? _verifyResponse;
  String? _error;
  bool _isLoading = false;

  BusVerifyPaymentResponse? get verifyResponse => _verifyResponse;
  String? get error => _error;
  bool get isLoading => _isLoading;

  Future<void> verifyBusPayment(String paymentId, String orderId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final body = {
        "paymentId": paymentId,
        "orderId": orderId,
        "type": "app",
      };

      _verifyResponse = await BusVerifyPaymentService.verifyPayment(body);
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  void clear() {
    _verifyResponse = null;
    _error = null;
    notifyListeners();
  }
}
