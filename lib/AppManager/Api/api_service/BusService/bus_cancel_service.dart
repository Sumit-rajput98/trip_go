

import '../../../../Model/BusM/bus_cancel_model.dart';
import '../api_call.dart';

class BusCancelService {
  Future<BusCancelModel?> cancelBus({
    required int busId,
    required String remarks,
  }) async {
    final response = await ApiCall().call(
      url: "api/Bus/Cancel",
      apiCallType: ApiCallType.post(
        body: {
          "BusId": busId,
          "Remarks": remarks,
        },
        header: {
          "Content-Type": "application/json",
        },
      ),
    );

    if (response != null) {
      return BusCancelModel.fromJson(response);
    } else {
      return null;
    }
  }
}
