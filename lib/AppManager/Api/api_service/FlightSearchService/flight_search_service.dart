import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../Model/FlightM/flight_search_model.dart';

class FlightSearchService {
  static const String _baseUrl = "https://admin.travelsdata.com/api/search";

  Future<FlightSearchResponse> searchFlights(FlightSearchRequest request) async {
    final rawBody = jsonEncode(request.toJson());

    // ✅ Print the raw input JSON body
    print('Request Body: $rawBody');

    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: rawBody,
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return FlightSearchResponse.fromJson(responseData);
    } else {
      // Optional: Print error response for debugging
      print('Error Response: ${response.body}');
      throw Exception('Failed to load flight search data');
    }
  }
}
