import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../Model/FlightM/flight_ticket_lcc_round_model.dart';

class FlightTicketRoundLccService {
  final String _baseUrl = "https://admin.travelsdata.com/api/flight-ticket";

  Future<FlightTicketResponseRound> bookFlight(FlightTicketRequestRound request) async {
    final String rawBody = jsonEncode(request.toJson());

    // 🔍 Pretty-print raw JSON line-by-line
    print("🔍 Raw Request Body for Round Trip:");
    _printFormattedJson(rawBody);

    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {
        "Content-Type": "application/json",
      },
      body: rawBody,
    );

    // 🟡 Pretty-print response body
    print("📩 Response Status Code: ${response.statusCode}");
    print("📦 Response Body:");
    _printFormattedJson(response.body);

    if (response.statusCode == 200) {
      return FlightTicketResponseRound.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("❌ Failed to book flight ticket\nStatus Code: ${response.statusCode}\nBody: ${response.body}");
    }
  }

  // 🔧 Helper: pretty-print JSON with indentation, line-by-line
  void _printFormattedJson(String jsonStr) {
    try {
      final dynamic jsonObj = jsonDecode(jsonStr);
      const encoder = JsonEncoder.withIndent('  ');
      final prettyString = encoder.convert(jsonObj);
      for (var line in prettyString.split('\n')) {
        print(line);
      }
    } catch (e) {
      print("⚠️ Failed to format JSON: $e");
      print(jsonStr); // Fallback to raw string
    }
  }
}
