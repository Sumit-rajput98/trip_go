import 'package:flutter/material.dart';

import '../../AppManager/Api/api_service/TourService/holiday_themes_service.dart';
import '../../Model/TourM/holiday_themes_model.dart';

class HolidayThemesViewModel extends ChangeNotifier {
  final HolidayThemesService _service = HolidayThemesService();
  List<HolidayTheme> _themes = [];
  bool _isLoading = false;

  List<HolidayTheme> get themes => _themes;
  bool get isLoading => _isLoading;

  Future<void> fetchThemes() async {
    _isLoading = true;
    notifyListeners();

    try {
      _themes = await _service.fetchHolidayThemes();
    } catch (e) {
      _themes = [];
    }

    _isLoading = false;
    notifyListeners();
  }
}
