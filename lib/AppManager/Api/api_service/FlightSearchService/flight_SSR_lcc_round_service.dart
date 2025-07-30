import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../Model/FlightM/flight_SSR_round_model.dart';

class FlightSsrLccRoundService{
  static const String _baseUrl = "https://admin.travelsdata.com/api/flightSsr-lcc";
  Future<FlightSsrModelRoundLcc> fetchSsrRoundLcc(FlightSsrLccRoundRequest request) async{
    final rawBody = jsonEncode(request.toJson());

    print('Request Round Body: $rawBody');

    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: rawBody,
    );

    print('Response Status Code: ${response.statusCode}');
    print('Full Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return FlightSsrModelRoundLcc.fromJson(responseData);
    } else {

      print('Error Response: ${response.body}');
      throw Exception('Failed to load flight search data');
    }
  }
}