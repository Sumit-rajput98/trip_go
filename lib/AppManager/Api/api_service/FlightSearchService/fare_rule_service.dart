import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../Api/api_service/api_constant.dart'; // Adjust path as needed
import 'package:trip_go/Model/FlightM/fare_rules_model.dart';

class FareRuleService {
  static const String _endpoint = "api/flight-fare-rule";

  Future<FareRulesModel> fetchFareRule(FareRulesRequest request) async {
    final String fullUrl = ApiConstant.baseUrl + _endpoint;
    final rawBody = jsonEncode(request.toJson());

    print('Request Body: $rawBody');

    final response = await http.post(
      Uri.parse(fullUrl),
      headers: {'Content-Type': 'application/json'},
      body: rawBody,
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return FareRulesModel.fromJson(responseData);
    } else {
      print('Error Response: ${response.body}');
      throw Exception('Failed to load flight fare rules');
    }
  }
}
