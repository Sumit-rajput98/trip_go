import 'package:flutter/material.dart';
import '../../AppManager/Api/api_service/TourService/category_service.dart';
import '../../Model/TourM/category_model.dart';

class CategoryViewModel extends ChangeNotifier {
  final CategoryService _service = CategoryService();

  bool _isLoading = false;
  String _error = '';

  List<TourPackage> _allData = [];
  List<TourPackage> _filteredData = [];

  bool get isLoading => _isLoading;
  List<TourPackage> get data => _filteredData;
  String get error => _error;

  Future<void> loadPackages(String slug) async {
    _isLoading = true;
    notifyListeners();
    try {
      _allData = await _service.fetchTourPackages(slug);
      _filteredData = List.from(_allData); // Initially show all
      _error = '';
    } catch (e) {
      _error = e.toString();
      _allData = [];
      _filteredData = [];
    }
    _isLoading = false;
    notifyListeners();
  }


  void sortPackagesByPrice({required bool ascending}) {
    _filteredData.sort((a, b) {
      int priceA = int.tryParse(a.offerPrice) ?? 0;
      int priceB = int.tryParse(b.offerPrice) ?? 0;
      return ascending ? priceA.compareTo(priceB) : priceB.compareTo(priceA);
    });
    notifyListeners();
  }


  void applyFilters({
    double? minPrice,
    double? maxPrice,
    int? maxDays,
    List<String>? selectedThemes,
  }) {
    _filteredData = _allData.where((package) {
      int price = int.tryParse(package.offerPrice) ?? 0;
      int days = package.noOfDays;

      final priceValid = (minPrice == null || price >= minPrice) &&
          (maxPrice == null || price <= maxPrice);

      final durationValid = maxDays == null || days <= maxDays;

      final themeValid = selectedThemes == null || selectedThemes.isEmpty ||
          package.packageThemes.any((theme) => selectedThemes.contains(theme));

      return priceValid && durationValid && themeValid;
    }).toList();

    notifyListeners();
  }

  void resetFilters() {
    _filteredData = List.from(_allData);
    notifyListeners();
  }
}

