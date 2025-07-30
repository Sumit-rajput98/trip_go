import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import '../../../../Model/TourM/package_inquiry_model.dart';

class PackageInquiryService {
  static const String _url = 'https://admin.travelsdata.com/api/HolidayPackages/package_enquiry';

  static Future<String?> sendInquiry(PackageInquiryModel model) async {
    try {
      final response = await http.post(
        Uri.parse(_url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(model.toJson()),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success']) {
          return data['message'];
        } else {
          return "Submission failed: ${data['message']}";
        }
      } else {
        return "Server error: ${response.statusCode}";
      }
    } catch (e) {
      if (kDebugMode) print("Error sending inquiry: $e");
      return "Something went wrong. Please try again.";
    }
  }
}