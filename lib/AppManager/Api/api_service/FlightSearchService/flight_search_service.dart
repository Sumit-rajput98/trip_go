import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../Model/FlightM/flight_search_model.dart';
import '../api_constant.dart';

class FlightSearchService {
  static final String _endpoint = "${ApiConstant.baseUrl}api/search";

  Future<FlightSearchResponse> searchFlights(FlightSearchRequest request) async {
    final rawBody = jsonEncode(request.toJson());

    print('Request Body: $rawBody');

    final response = await http.post(
      Uri.parse(_endpoint),
      headers: {'Content-Type': 'application/json'},
      body: rawBody,
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return FlightSearchResponse.fromJson(responseData);
    } else {
      print('Error Response: ${response.body}');
      throw Exception('Failed to load flight search data');
    }
  }
}
