import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:trip_go/Model/FlightM/round_trip_flight_search_model.dart';

class RoundTripFlightSearchService{
  static const String _baseUrl = "https://admin.travelsdata.com/api/roundTripSearch";

  Future<RoundTripFlightSearchModel> fetchFlight(RoundTripFlightSearchRequest request) async {
    final rawBody = jsonEncode(request.toJson());

    // ✅ Print the raw input JSON body
    print('Request Body: $rawBody');

    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: rawBody,
    );

    if (response.statusCode == 200) {
      print('hii');
      final responseData = jsonDecode(response.body);
      return RoundTripFlightSearchModel.fromJson(responseData);
    } else {
      // Optional: Print error response for debugging
      print('Error Response: ${response.body}');
      throw Exception('Failed to load flight search data');
    }

  }
}