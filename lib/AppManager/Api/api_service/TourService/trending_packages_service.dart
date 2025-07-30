import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../Api/api_service/api_constant.dart'; // Adjust path
import '../../../../Model/TourM/trending_package_model.dart';

class TrendingPackagesService {
  static const String _endpoint = 'api/HolidayPackages/trending_packages';

  Future<List<TrendingPackage>> fetchTrendingPackages() async {
    final url = ApiConstant.baseUrl + _endpoint;
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      final List data = jsonData['data'];
      return data.map((e) => TrendingPackage.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load trending packages');
    }
  }
}
