import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:trip_go/AppManager/Api/api_service/api_call.dart';
import '../../AppManager/Api/api_service/api_constant.dart';

class FlightTicketDownloadViewModel {
  final ApiCall _apiCall = ApiCall();

  Future<Uint8List?> downloadFlightTicket({
    String? bookingId,
  }) async {
    try {
      final url = "api/FlightDownloadTicket";

      final headers = {
        'Content-Type': 'application/json',
      };

      final body = {
        "BookingId": bookingId,
      };

      if (kDebugMode) {
        print("Downloading ticket for Booking ID: $bookingId");
      }

      final response = await http.post(
        Uri.parse(ApiConstant.baseUrl + url),
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        if (kDebugMode) print("PDF download successful");
        return response.bodyBytes; // PDF bytes
      } else {
        if (kDebugMode) print("Failed to download ticket: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      if (kDebugMode) print("Error downloading flight ticket: $e");
      return null;
    }
  }
}
