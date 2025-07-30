import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../Api/api_service/api_constant.dart'; // Update path if needed
import '../../../../Model/TourM/holiday_themes_model.dart';

class HolidayThemesService {
  final String endpoint = "api/HolidayPackages/HolidayThemes";

  Future<List<HolidayTheme>> fetchHolidayThemes() async {
    final response = await http.get(Uri.parse(ApiConstant.baseUrl + endpoint));

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      final List data = decoded['data'];
      return data.map((item) => HolidayTheme.fromJson(item)).toList();
    } else {
      throw Exception("Failed to load holiday themes");
    }
  }
}
