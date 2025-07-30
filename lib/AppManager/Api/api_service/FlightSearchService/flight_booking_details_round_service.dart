import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:trip_go/Model/FlightM/flight_booking_details_round_model.dart';
import '../../../Api/api_service/api_constant.dart'; // Adjust path as needed

class FlightBookingDetailsRoundService {
  static const String _endpoint = 'api/flight-booking-details';

  Future<FlightBookingDetailsRoundModel?> fetchFlightBookingDetails({
    required String traceId,
    required String pnr,
    required int bookingId,
    required String pnrIb,
    required int bookingIdIb,
  }) async {
    final String fullUrl = ApiConstant.baseUrl + _endpoint;

    final requestBody = {
      "TraceId": traceId,
      "PNR": pnr,
      "BookingId": bookingId,
      "PNRIB": pnrIb,
      "BookingIdIB": bookingIdIb
    };

    try {
      print('🔵 [POST] $fullUrl');
      print('📝 [Request Body] ${jsonEncode(requestBody)}');

      final response = await http.post(
        Uri.parse(fullUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      print('📦 [Status Code] ${response.statusCode}');
      print('📨 [Response Body] ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return FlightBookingDetailsRoundModel.fromJson(data);
      } else {
        print('❌ [Error] Status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('❗ [Exception] $e');
      return null;
    }
  }
}
