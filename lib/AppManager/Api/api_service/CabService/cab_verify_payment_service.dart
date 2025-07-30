import 'package:trip_go/AppManager/Api/api_service/api_call.dart';
import '../../../../Model/CabM/cab_verify_payment_model.dart';

class CabVerifyPaymentService {
  Future<CabVerifyPaymentModel?> verifyPayment({
    required String paymentId,
    required String orderId,
  }) async {
    final response = await ApiCall().call(
      url: "api/Cab/VerifyPayment",
      apiCallType: ApiCallType.post(
        body: {
          "paymentId": paymentId,
          "orderId": orderId,
          "type": "app",
        },
        header: {"Content-Type": "application/json"},
      ),
    );

    if (response != null) {
      return CabVerifyPaymentModel.fromJson(response);
    }
    return null;
  }
}
