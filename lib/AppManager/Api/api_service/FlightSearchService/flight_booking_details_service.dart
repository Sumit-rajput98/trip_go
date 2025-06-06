import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../Model/FlightM/flight_booking_details.dart';

class FlightBookingDetailsService {
  static const String _url = 'https://admin.travelsdata.com/api/flight-booking-details';

  Future<FlightBookingDetailsModel?> fetchFlightBookingDetails({
    required String traceId,
    required String pnr,
    required String bookingId,
  }) async {
    try {
      final requestBody = {
        "TraceId": traceId,
        "PNR": pnr,
        "BookingId": bookingId,
      };

      print('🔵 [API POST] $_url');
      print('📝 [Request Body] ${jsonEncode(requestBody)}');

      final response = await http.post(
        Uri.parse(_url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      print('📦 [Response Status] ${response.statusCode}');
      print('📨 [Response Body] ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return FlightBookingDetailsModel.fromJson(data);
      } else {
        print('❌ Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('❗ Exception: $e');
      return null;
    }
  }
}
