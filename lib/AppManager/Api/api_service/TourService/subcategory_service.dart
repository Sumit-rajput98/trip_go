import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../Api/api_service/api_constant.dart'; // update path as needed
import '../../../../Model/TourM/subcategory_model.dart';

class SubCategoryService {
  Future<SubCategoryModel?> fetchSubCategory(String slug2) async {
    final endpoint = 'api/HolidayPackages/destinations/switzerland/$slug2';
    final fullUrl = ApiConstant.baseUrl + endpoint;

    try {
      final response = await http.get(Uri.parse(fullUrl));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return SubCategoryModel.fromJson(jsonData);
      } else {
        print('Failed to load subcategory data');
        return null;
      }
    } catch (e) {
      print('Error fetching subcategory: $e');
      return null;
    }
  }
}
