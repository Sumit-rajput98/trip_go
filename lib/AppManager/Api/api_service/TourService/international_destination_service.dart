import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../Api/api_service/api_constant.dart'; // Adjust path as needed
import '../../../../Model/TourM/international_destination_model.dart';

class InternationalDestinationService {
  static const String _endpoint = 'api/HolidayPackages/InternationalDestinations';

  static Future<List<InternationalDestinationModel>> fetchDestinations() async {
    final String fullUrl = ApiConstant.baseUrl + _endpoint;

    final response = await http.get(Uri.parse(fullUrl));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List data = jsonData['data'];
      return data
          .map((item) => InternationalDestinationModel.fromJson(item))
          .toList();
    } else {
      throw Exception('Failed to load international destinations');
    }
  }
}
