import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../Model/TourM/holiday_themes_model.dart';

class HolidayThemesService {
  final String url = "https://admin.travelsdata.com/api/HolidayPackages/HolidayThemes";

  Future<List<HolidayTheme>> fetchHolidayThemes() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      final List data = decoded['data'];
      return data.map((item) => HolidayTheme.fromJson(item)).toList();
    } else {
      throw Exception("Failed to load holiday themes");
    }
  }
}
