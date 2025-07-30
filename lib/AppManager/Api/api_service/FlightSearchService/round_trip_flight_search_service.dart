import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../Api/api_service/api_constant.dart'; // Adjust the path as needed
import 'package:trip_go/Model/FlightM/round_trip_flight_search_model.dart';

class RoundTripFlightSearchService {
  static const String _endpoint = "api/roundTripSearch";

  Future<RoundTripFlightSearchModel> fetchFlight(RoundTripFlightSearchRequest request) async {
    final String fullUrl = ApiConstant.baseUrl + _endpoint;
    final String rawBody = jsonEncode(request.toJson());

    print('Request Body: $rawBody');

    final response = await http.post(
      Uri.parse(fullUrl),
      headers: {'Content-Type': 'application/json'},
      body: rawBody,
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return RoundTripFlightSearchModel.fromJson(responseData);
    } else {
      print('Error Response: ${response.body}');
      throw Exception('Failed to load round trip flight search data');
    }
  }
}
