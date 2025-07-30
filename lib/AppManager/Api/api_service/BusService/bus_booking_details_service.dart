import 'package:trip_go/AppManager/Api/api_service/api_call.dart';

import '../../../../Model/BusM/bus_booking_details_model.dart';

class BusBookingDetailsService {
  Future<BusBookingDetailsModel> fetchBookingDetails({
    required String traceId,
    required int busId,
  }) async {
    final Map<String, dynamic> payload = {
      "TraceId": traceId,
      "BusId": busId,
    };

    final response = await ApiCall().call(
      url: "api/Bus/GetBooking",
      apiCallType: ApiCallType.post(body: payload, header: {
        'Content-Type': 'application/json',
      }),
    );

    return BusBookingDetailsModel.fromJson(response);
  }
}
