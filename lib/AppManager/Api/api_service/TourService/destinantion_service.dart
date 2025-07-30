import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../Api/api_service/api_constant.dart'; // update path as needed
import '../../../../Model/TourM/destination_model.dart';

class DestinationService {
  static const String _endpoint = 'api/HolidayPackages/destinations';

  static Future<List<DestinationModel>> fetchDestinations() async {
    final fullUrl = ApiConstant.baseUrl + _endpoint;

    final response = await http.get(Uri.parse(fullUrl));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['data'] as List)
          .map((json) => DestinationModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load destinations');
    }
  }
}
