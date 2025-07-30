import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../Model/FlightM/flight_ticket_lcc_round_model.dart';
import '../api_constant.dart'; // Import the centralized constant

class FlightTicketRoundLccService {
  final String _endpoint = "api/flight-ticket";

  Future<FlightTicketResponseRound> bookFlight(FlightTicketRequestRound request) async {
    final String url = "${ApiConstant.baseUrl}$_endpoint";
    final String rawBody = jsonEncode(request.toJson());

    // 🔍 Pretty-print raw JSON
    print("🔍 Raw Request Body for Round Trip:");
    _printFormattedJson(rawBody);

    final response = await http.post(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
      },
      body: rawBody,
    );

    // 🟡 Log response
    print("📩 Response Status Code: ${response.statusCode}");
    print("📦 Response Body:");
    _printFormattedJson(response.body);

    if (response.statusCode == 200) {
      return FlightTicketResponseRound.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(
        "❌ Failed to book flight ticket\n"
            "Status Code: ${response.statusCode}\n"
            "Body: ${response.body}",
      );
    }
  }

  // 🔧 JSON pretty-print helper
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
      print(jsonStr);
    }
  }
}
