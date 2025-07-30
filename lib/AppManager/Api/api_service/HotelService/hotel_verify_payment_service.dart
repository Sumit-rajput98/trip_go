import 'package:trip_go/AppManager/Api/api_service/api_call.dart';

class HotelVerifyPaymentService {
  final ApiCall _apiCall = ApiCall();

  Future<Map<String, dynamic>> verifyPayment({
    required String paymentId,
    required String orderId,
  }) async {
    final body = {
      "paymentId": paymentId,
      "orderId": orderId,
      "type": "app",
    };

    final response = await _apiCall.call(
      url: "api/HotelVerifyPayment",
      apiCallType: ApiCallType.post(
        body: body,
        header: {
          "Content-Type": "application/json",
        },
      ),
    );

    return response;
  }
}
