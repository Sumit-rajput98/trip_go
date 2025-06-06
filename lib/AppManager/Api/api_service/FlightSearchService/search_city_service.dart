import 'package:trip_go/AppManager/Api/api_service/api_call.dart';
import 'package:trip_go/Model/FlightM/search_city_model.dart';

class SelectCityService {
  final ApiCall _apiCall = ApiCall();

  Future<SearchCityModel?> fetchCities() async {
    try {
      final response = await _apiCall.call(
        url: 'api/airport', // Replace with actual endpoint
        apiCallType: ApiCallType.get(),
      );

      return SearchCityModel.fromJson(response);
    } catch (e) {
      print("Error fetching cities: $e");
      return null;
    }
  }
}
