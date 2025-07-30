import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../Api/api_service/api_constant.dart'; // update path as needed
import '../../../../Model/FlightM/flight_quote_round_model.dart';

class FlightQuoteRoundService {
  static const String _endpoint = "api/flight-fare-quote";

  Future<FlightQuoteRoundModel> fetchQuote(FlightQuoteRoundRequest request) async {
    final rawBody = jsonEncode(request.toJson());
    print('Request Body: $rawBody');

    final response = await http.post(
      Uri.parse(ApiConstant.baseUrl + _endpoint),
      headers: {'Content-Type': 'application/json'},
      body: rawBody,
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return FlightQuoteRoundModel.fromJson(responseData);
    } else {
      print('Error Response: ${response.body}');
      throw Exception('Failed to load flight search data');
    }
  }
}
