import 'package:trip_go/AppManager/Api/api_service/api_call.dart';

class UserBookingDetailsService {
  Future<dynamic> getUserBookingDetails({
    required String countryCode,
    required String phoneNumber,
  }) async {
    final response = await ApiCall().call(
      url: "api/details",
      apiCallType: ApiCallType.post(
        body: {
          "CountryCode": countryCode,
          "PhoneNumber": phoneNumber,
        },
        header: {"Content-Type": "application/json"},
      ),
    );

    return response;
  }
}
