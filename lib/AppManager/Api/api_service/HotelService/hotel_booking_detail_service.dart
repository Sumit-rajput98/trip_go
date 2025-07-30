import 'package:trip_go/AppManager/Api/api_service/api_call.dart';
import 'package:trip_go/Model/HotelM/hotel_bokking_detail_model.dart';

class HotelBookingDetailService {
  Future<HotelBookingDetailModel> getBookingDetail(dynamic request) async {
    final String url = "api/Hotel/GetBookingDetail";
    final response = await ApiCall().call(
      url: url,
      apiCallType: ApiCallType.post(
        body: request,
        header: {"Content-Type": "application/json"}
      )
    );

    if (response == null) {
      throw Exception('No response from server');
    }

    // Check if API response indicates failure
    if (response is Map<String, dynamic> && 
        response['success'] == false) {
      throw Exception(response['message'] ?? 'Unknown booking error');
    }

    try {
      return HotelBookingDetailModel.fromJson(response);
    } catch (e) {
      throw Exception('Failed to parse response: ${e.toString()}');
    }
  }
}