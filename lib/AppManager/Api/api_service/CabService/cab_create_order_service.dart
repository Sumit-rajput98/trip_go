import 'package:trip_go/AppManager/Api/api_service/api_call.dart';
import '../../../../Model/CabM/cab_create_order_model.dart';

class CabCreateOrderService {
  Future<CabCreateOrderModel?> createOrder({
    required String cabId,
    required int amount,
  }) async {
    final response = await ApiCall().call(
      url: "api/Cab/CreateOrder",
      apiCallType: ApiCallType.post(
        body: {
          "cab_id": cabId,
          "amount": amount, // in rupees
        },
        header: {"Content-Type": "application/json"},
      ),
    );

    if (response != null && response['success'] == true) {
      return CabCreateOrderModel.fromJson(response['data']);
    }
    return null;
  }
}
