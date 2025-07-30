import 'package:flutter/material.dart';
import 'package:trip_go/Model/FlightM/search_city_model.dart';

import '../../AppManager/Api/api_service/FlightSearchService/search_city_service.dart';

// class SelectCityViewModel extends ChangeNotifier {
//   final SelectCityService _service = SelectCityService();
//
//   List<Datum> _cities = [];
//   List<Datum> get cities => _cities;
//
//   String _cityName='';
//   String get cityName => _cityName;
//
//   bool _isLoading = false;
//   bool get isLoading => _isLoading;
//
//   String? _error;
//   String? get error => _error;
//
//   Future<void> loadCities() async {
//     _isLoading = true;
//     _error = null;
//     notifyListeners();
//
//     final result = await _service.fetchCities();
//     if (result != null && result.success) {
//       _cities = result.data;
//       _cityName = result.data.map((e)=>e.cityname).toString();
//
//     } else {
//       _error = result?.message ?? 'Failed to load cities';
//     }
//
//     _isLoading = false;
//     notifyListeners();
//   }
// }


class SelectCityViewModel extends ChangeNotifier {
  final SelectCityService _service = SelectCityService();

  List<Datum> _cities = [];
  List<Datum> get cities => _cities;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  bool _hasLoaded = false; // 👈 Flag to track if data is already loaded

  Future<void> loadCities() async {
    if (_hasLoaded) return; // 👈 Skip API call if already loaded

    _isLoading = true;
    _error = null;
    notifyListeners();

    final result = await _service.fetchCities();
    if (result != null && result.success) {
      _cities = result.data;
      _hasLoaded = true; // 👈 Mark as loaded
    } else {
      _error = result?.message ?? 'Failed to load cities';
    }

    _isLoading = false;
    notifyListeners();
  }
}
