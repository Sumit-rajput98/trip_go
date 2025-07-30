import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../Model/TourM/quick_enquiry_model.dart';

class QuickEnquiryService {
  static const String _url = 'https://tripoholidays.in/api/quick_enquiry';

  static Future<Map<String, dynamic>> submitEnquiry(QuickEnquiryModel enquiry) async {
    final response = await http.post(
      Uri.parse(_url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(enquiry.toJson()),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to send enquiry");
    }
  }
}
