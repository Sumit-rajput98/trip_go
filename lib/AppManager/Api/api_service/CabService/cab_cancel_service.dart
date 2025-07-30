import 'package:trip_go/AppManager/Api/api_service/api_call.dart';
import '../../../../Model/CabM/cab_cancel_model.dart';

class CabCancelService {
  static Future<CabCancelModel?> cancelCab({
    required String orderNo,
    required String cancelledBy,
    required String reason,
  }) async {
    final response = await ApiCall().call(
      url: "api/Cab/Cancel",
      apiCallType: ApiCallType.post(
        body: {
          "order_no": orderNo,
          "cancelled_by": cancelledBy,
          "cancellation_reason": reason,
        },
        header: {"Content-Type": "application/json"},
      ),
    );

    if (response != null) {
      return CabCancelModel.fromJson(response);
    }
    return null;
  }
}