import 'package:flutter/foundation.dart';
import '../../AppManager/Api/api_service/CabService/cab_verify_payment_service.dart';
import '../../Model/CabM/cab_verify_payment_model.dart';

class CabVerifyPaymentViewModel extends ChangeNotifier {
  CabVerifyPaymentModel? verifyResponse;
  String? error;

  Future<void> verifyCabPayment(String paymentId, String orderId) async {
    try {
      final service = CabVerifyPaymentService();
      verifyResponse = await service.verifyPayment(
        paymentId: paymentId,
        orderId: orderId,
      );
      error = null;
    } catch (e) {
      verifyResponse = null;
      error = e.toString();
    }
    notifyListeners();
  }
}
