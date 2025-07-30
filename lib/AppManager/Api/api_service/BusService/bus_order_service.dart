import 'package:trip_go/AppManager/Api/api_service/api_call.dart';
import '../../../../Model/BusM/bus_order_model.dart';

class BusOrderService {
  static Future<BusOrderResponse> createOrder(Map<String, dynamic> body) async {
    try {
      final response = await ApiCall().call(
        url: "api/Bus/CreateOrder",
        apiCallType: ApiCallType.post(
          body: body,
          header: {'Content-Type': 'application/json'},
        ),
      );

      return BusOrderResponse.fromJson(response);
    } catch (e) {
      throw Exception("Failed to create order: $e");
    }
  }
}
