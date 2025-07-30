import 'package:flutter/foundation.dart';
import '../../../../Model/FlightM/verify_payment_model.dart';
import '../../AppManager/Api/api_service/FlightSearchService/verify_payment_service.dart';

class VerifyPaymentViewModel extends ChangeNotifier {
  VerifyPaymentResponse? _response;
  VerifyPaymentResponse? get response => _response;

  Future<bool> verifyPayment(String paymentId, String orderId) async {
    final service = VerifyPaymentService();
    _response = await service.verifyPayment(paymentId: paymentId, orderId: orderId);
    notifyListeners();
    return _response?.success ?? false;
  }
}