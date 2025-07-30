import 'package:trip_go/AppManager/Api/api_service/api_call.dart';
import 'package:trip_go/Model/HotelM/hotel_city_search_model.dart';

class HotelCitySearchService {
  final ApiCall _apiCall = ApiCall();

  /// Fetches hotel city search results for the given city name.
  /// Always uses POST to 'api/Hotel/CityList' with body: { 'city': city }.
  Future<HotelCitySearchModel> fetchHotelCitySearch({
    required String city,
    Map<String, String>? headers,
  }) async {
    final apiCallType = ApiCallType.post(
      body: {"city": city},
      header:  {
          "Content-Type": "application/json",
        },
    );
    final response = await _apiCall.call(
      url: 'api/Hotel/CityList',
      apiCallType: apiCallType,
    );
    return HotelCitySearchModel.fromJson(response);
  }
}
