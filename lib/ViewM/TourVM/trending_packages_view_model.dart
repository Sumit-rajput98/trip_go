import 'package:flutter/material.dart';

import '../../AppManager/Api/api_service/TourService/trending_packages_service.dart';
import '../../Model/TourM/trending_package_model.dart';

class TrendingPackagesViewModel extends ChangeNotifier {
  final TrendingPackagesService _service = TrendingPackagesService();

  List<TrendingPackage> _packages = [];
  List<TrendingPackage> get packages => _packages;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> loadTrendingPackages() async {
    _isLoading = true;
    notifyListeners();

    try {
      _packages = await _service.fetchTrendingPackages();
    } catch (e) {
      _packages = [];
    }

    _isLoading = false;
    notifyListeners();
  }
}
