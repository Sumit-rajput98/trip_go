import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../Api/api_service/api_constant.dart'; // Adjust path
import '../../../../Model/TourM/category_model.dart';

class CategoryService {
  Future<List<TourPackage>> fetchTourPackages(String slug) async {
    final url = '${ApiConstant.baseUrl}api/HolidayPackages/destinations/$slug';
    print('Fetching tour packages from: $url');

    final response = await http.get(Uri.parse(url));

    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List data = jsonData['data'];
      return data.map((e) => TourPackage.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load tour packages');
    }
  }
}
