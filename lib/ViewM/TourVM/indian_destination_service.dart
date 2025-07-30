import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../AppManager/Api/api_service/api_constant.dart';
import '../../Model/TourM/indian_destination_model.dart';

class IndianDestinationService {
  static const String _endpoint = 'api/HolidayPackages/IndianDestinations';

  Future<List<IndianDestination>> fetchDestinations() async {
    final response = await http.get(Uri.parse(ApiConstant.baseUrl + _endpoint));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['success'] == true) {
        return (data['data'] as List)
            .map((e) => IndianDestination.fromJson(e))
            .toList();
      } else {
        throw Exception('Failed to load Indian destinations');
      }
    } else {
      throw Exception('Failed to load data');
    }
  }
}
