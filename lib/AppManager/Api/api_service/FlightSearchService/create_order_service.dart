import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../Api/api_service/api_constant.dart'; // Adjust path accordingly
import '../../../../Model/FlightM/create_order_model.dart';

class CreateOrderService {
  static const String _endpoint = 'api/create-order';

  Future<CreateOrderResponse?> createOrder({
    required int amount,
    required String traceId,
  }) async {
    final url = ApiConstant.baseUrl + _endpoint;

    final body = {
      'amount': amount,
      'TraceId': traceId,
    };

    print("📤 Sending request to $url");
    print("📦 Raw Body: ${jsonEncode(body)}");

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      print("📥 Response Status: ${response.statusCode}");
      print("📥 Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return CreateOrderResponse.fromJson(json);
      } else {
        print("❌ Failed to create order: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("❌ Error in createOrder: $e");
      return null;
    }
  }
}
