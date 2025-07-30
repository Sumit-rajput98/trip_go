import 'package:flutter/foundation.dart';

import '../../AppManager/Api/api_service/HotelService/hotel_verify_payment_service.dart';
import '../../Model/HotelM/hotel_verify_payment_model.dart';

class HotelVerifyPaymentViewModel extends ChangeNotifier {
  final HotelVerifyPaymentService _service = HotelVerifyPaymentService();

  bool isLoading = false;
  HotelVerifyPaymentResponse? verifyResponse;
  String? error;

  Future<void> verifyHotelPayment(String paymentId, String orderId) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await _service.verifyPayment(
        paymentId: paymentId,
        orderId: orderId,
      );

      verifyResponse = HotelVerifyPaymentResponse.fromJson(response);
      error = null;
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }
}
