import '../../../../Model/HotelM/hotel_cancel_model.dart';
import '../api_call.dart';

class HotelCancelService {
  Future<HotelCancelModel?> cancelHotel({required Map<String, dynamic> body}) async {
    final response = await ApiCall().call(
      url: "api/Hotel/CancelHotel",
      apiCallType: ApiCallType.post(
        body: body,
        header: {
          "Content-Type": "application/json",
        },
      ),
    );

    if (response != null) {
      return HotelCancelModel.fromJson(response);
    } else {
      return null;
    }
  }
}
