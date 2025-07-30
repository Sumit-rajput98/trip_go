import 'package:trip_go/AppManager/Api/api_service/api_call.dart';
import 'package:trip_go/AppManager/Api/api_service/api_constant.dart';

import '../../../../Model/BusM/bus_city_model.dart';

class BusCityService {
  static List<BusCity>? _cachedCities; // ✅ Add cache at class level

  Future<List<BusCity>> fetchBusCities() async {
    if (_cachedCities != null) return _cachedCities!;

    final response = await ApiCall().call(
      url: 'api/Bus/City',
      apiCallType: ApiCallType.get(),
    );

    if (response['success'] == true) {
      final List cities = response['data'];
      _cachedCities = cities.map((e) => BusCity.fromJson(e)).toList();
      return _cachedCities!;
    } else {
      throw Exception('Failed to load bus cities');
    }
  }

  void clearCache() {
    _cachedCities = null;
  }
}

