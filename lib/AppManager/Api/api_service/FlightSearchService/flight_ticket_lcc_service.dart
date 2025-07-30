import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../Model/FlightM/flight_ticket_lcc_model.dart';
import '../api_constant.dart'; // ✅ Import ApiConstant

class FlightTicketLccService {
  final String _endpoint = "api/flight-ticket";

  Future<FlightTicketResponse> bookFlight(FlightTicketRequest request) async {
    final String url = "${ApiConstant.baseUrl}$_endpoint";
    final String rawBody = jsonEncode(request.toJson());

    // 🔍 Pretty-print raw JSON line-by-line
    print("🔍 Raw Request Body:");
    _printFormattedJson(rawBody);

    final response = await http.post(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
      },
      body: rawBody,
    );

    // 🟡 Pretty-print response body
    print("📩 Response Status Code: ${response.statusCode}");
    print("📦 Response Body for ticket:");
    _printFormattedJson(response.body);

    if (response.statusCode == 200) {
      return FlightTicketResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(
        "❌ Failed to book flight ticket\n"
            "Status Code: ${response.statusCode}\n"
            "Body: ${response.body}",
      );
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
