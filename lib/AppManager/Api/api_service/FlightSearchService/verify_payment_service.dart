import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../Model/FlightM/verify_payment_model.dart';
import '../api_constant.dart';

class VerifyPaymentService {
  final String _endpoint = "api/verify-payment";

  Future<VerifyPaymentResponse?> verifyPayment({
    required String paymentId,
    required String orderId,
  }) async {
    final body = {
      "paymentId": paymentId,
      "orderId": orderId,
      "type": "app",
    };

    final String url = "${ApiConstant.baseUrl}$_endpoint";

    print("📤 Verifying Payment: ${jsonEncode(body)}");

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      print("📥 Verify Payment Response: ${response.body}");

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return VerifyPaymentResponse.fromJson(json);
      } else {
        print("❌ Failed to verify payment: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("❌ Error verifying payment: $e");
      return null;
    }
  }
}
