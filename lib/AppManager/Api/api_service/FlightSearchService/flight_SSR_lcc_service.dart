import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:trip_go/Model/FlightM/flight_SSR_model_lcc.dart';
import '../api_constant.dart'; // Import ApiConstant

class FlightSsrLccService {
  final String _endpoint = "api/flightSsr-lcc";

  Future<FlightSsrModelLcc> fetchSsrLcc(FlightSsrLccRequest request) async {
    final String url = "${ApiConstant.baseUrl}$_endpoint";
    final rawBody = jsonEncode(request.toJson());

    print('Request URL: $url');
    print('Request Body: $rawBody');

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: rawBody,
    );

    print('Response Status Code: ${response.statusCode}');
    print('Full Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return FlightSsrModelLcc.fromJson(responseData);
    } else {
      print('Error Response: ${response.body}');
      throw Exception('❌ Failed to load flight SSR data');
    }
  }
}
