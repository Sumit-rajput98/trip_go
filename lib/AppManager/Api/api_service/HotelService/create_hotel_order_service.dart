import 'package:trip_go/AppManager/Api/api_service/api_call.dart';
import 'package:trip_go/AppManager/Api/api_service/api_constant.dart';
import 'dart:convert';

class CreateHotelOrderService {
  final ApiCall _apiCall = ApiCall();

  Future<Map<String, dynamic>> createHotelOrder({
    required String bookingCode,
    required int amount,
  }) async {
    final body = {
      "BookingCode": bookingCode,
      "amount": amount,
    };

    final response = await _apiCall.call(
      url: "api/HotelCreateOrder",
      apiCallType: ApiCallType.post(
        body: body,
        header: {
          "Content-Type": "application/json",
        },
      ),
    );

    return response;
  }
}
