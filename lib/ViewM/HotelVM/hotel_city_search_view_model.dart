import 'package:flutter/material.dart';
import 'package:trip_go/AppManager/Api/api_service/HotelService/hotel_city_search_service.dart';
import 'package:trip_go/Model/HotelM/hotel_city_search_model.dart';

class HotelCitySearchViewModel extends ChangeNotifier {
  final HotelCitySearchService _service = HotelCitySearchService();

  HotelCitySearchModel? _result;
  bool _isLoading = false;
  String? _error;

  HotelCitySearchModel? get result => _result;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> searchCity(String city) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final res = await _service.fetchHotelCitySearch(city: city);
      _result = res;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
