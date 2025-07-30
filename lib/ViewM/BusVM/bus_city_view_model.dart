import 'package:flutter/foundation.dart';

import '../../AppManager/Api/api_service/BusService/bus_city_service.dart';
import '../../Model/BusM/bus_city_model.dart';

class BusCityViewModel extends ChangeNotifier {
  final BusCityService _service = BusCityService();

  List<BusCity> _busCities = [];
  bool _isLoading = false;
  bool _hasLoaded = false;
  String? _error;

  List<BusCity> get busCities => _busCities;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> getBusCities() async {
    if (_hasLoaded) return; // ✅ already loaded

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _busCities = await _service.fetchBusCities();
      _hasLoaded = true;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

