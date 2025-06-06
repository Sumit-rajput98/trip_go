import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:trip_go/Model/FlightM/flight_quote_model.dart';

class FlightQuoteService{
  static const String _baseUrl = "https://admin.travelsdata.com/api/flight-fare-quote";
  Future<FlightQuoteModel> fetchQuote(FlightQuoteRequest request)async{
    final rawBody = jsonEncode(request.toJson());
    print('Request Body: $rawBody');

    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: rawBody,
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return FlightQuoteModel.fromJson(responseData);
    } else {

      print('Error Response: ${response.body}');
      throw Exception('Failed to load flight search data');
    }
  }
}