import 'package:trip_go/AppManager/Api/api_service/api_call.dart';
import 'package:trip_go/AppManager/Api/api_service/api_constant.dart';
import '../../../../Model/CabM/cab_booking_details_model.dart';

class CabBookingDetailsService {
  static Future<CabBookingDetailsModel?> fetchCabBookingDetails(String orderNo) async {
    try {
      final response = await ApiCall().call(
        url: 'api/Cab/BookingDetail',
        apiCallType: ApiCallType.post(
          body: {"order_no": orderNo},
          header: {"Content-Type": "application/json"},
        ),
      );

      if (response != null && response['success'] == true) {
        return CabBookingDetailsModel.fromJson(response);
      }
    } catch (e) {
      print("Error in CabBookingDetailsService: $e");
    }
    return null;
  }
}
