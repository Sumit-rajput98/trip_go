import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../Api/api_service/api_constant.dart'; // Adjust the path if needed
import '../../../../Model/BusM/bus_verify_payment_model.dart';

class BusVerifyPaymentService {
  static const String _endpoint = "api/Bus/VerifyPayment";

  static Future<BusVerifyPaymentResponse> verifyPayment(Map<String, dynamic> body) async {
    final String fullUrl = ApiConstant.baseUrl + _endpoint;

    final response = await http.post(
      Uri.parse(fullUrl),
      headers: {"Content-Type": "application/json"},
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return BusVerifyPaymentResponse.fromJson(jsonData);
    } else {
      throw Exception("Failed to verify payment: ${response.body}");
    }
  }
}
