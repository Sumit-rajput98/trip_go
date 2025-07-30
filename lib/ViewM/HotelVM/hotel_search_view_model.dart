import 'package:flutter/material.dart';
import 'package:trip_go/AppManager/Api/api_service/HotelService/hotel_search_service.dart';
import 'package:trip_go/Model/HotelM/hotel_search_model.dart';
class HotelSearchViewModel extends ChangeNotifier {
  final HotelSearchService _service = HotelSearchService();

  HotelSearchModel? _searchResult;
  HotelSearchModel? get searchResult => _searchResult;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<Hotel0> _filteredHotels = [];
  List<Hotel0> get filteredHotels => _filteredHotels;

  List<Data> _getHotelsData = [];
  List<Data> get getHotelsData => _getHotelsData;

  Future<void> searchHotels(Map<String, dynamic> body) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _service.searchHotels(body); // Already parsed model

      print("Hotels: ${result.data?.hotels?.length}");

      _filteredHotels = result.data?.hotels ?? [];

      // ✅ Add this line to fix the batchKey access
      _searchResult = result;
    } catch (e) {
      print("Error in searchHotels: $e");
      _filteredHotels = [];
      _errorMessage = "Something went wrong";
    }

    _isLoading = false;
    notifyListeners();
  }

  void clearResult() {
    _searchResult = null;
    _filteredHotels = [];
    _errorMessage = null;
    notifyListeners();
  }

  // Sort by price (fare + tax)
  void sortByPrice({bool ascending = true}) {
    _filteredHotels.sort((a, b) {
      final aTotal = (a.rooms?.first.totalFare ?? 0) + (a.rooms?.first.totalTax ?? 0);
      final bTotal = (b.rooms?.first.totalFare ?? 0) + (b.rooms?.first.totalTax ?? 0);
      return ascending ? aTotal.compareTo(bTotal) : bTotal.compareTo(aTotal);
    });
    notifyListeners();
  }

  void filterByAmenities(Set<String> selectedAmenities) {
    final originalHotels = _searchResult?.data?.hotels;
    if (originalHotels == null) return;

    _filteredHotels = originalHotels.where((hotel) {
      final amenitiesStr = hotel.ameneties ?? '';
      final hotelAmenities = amenitiesStr.split(',').map((e) => e.trim().toLowerCase()).toList();

      return selectedAmenities.every((selected) =>
          hotelAmenities.contains(selected.toLowerCase()));
    }).toList();

    notifyListeners();
  }

  void sortHotels(String sortType) {
  final originalHotels = _searchResult?.data?.hotels;
  if (originalHotels == null) return;

  List<Hotel0> sorted = List.from(originalHotels);

  if (sortType == "Price - Low To High") {
    sorted.sort((a, b) {
     final aTotal = (a.rooms?.first.totalFare ?? 0) + (a.rooms?.first.totalTax ?? 0);
      final bTotal = (b.rooms?.first.totalFare ?? 0) + (b.rooms?.first.totalTax ?? 0);
      return aTotal.compareTo(bTotal);
    });
  } else if (sortType == "Price - High To Low") {
    sorted.sort((a, b) {
      final aTotal = (a.rooms?.first.totalFare ?? 0) + (a.rooms?.first.totalTax ?? 0);
      final bTotal = (b.rooms?.first.totalFare ?? 0) + (b.rooms?.first.totalTax ?? 0);
      return bTotal.compareTo(aTotal);
    });
  }

  _filteredHotels = sorted;
  notifyListeners();
}

  // Filter by minimum rating
 void filterByRating(int specificRating) {
  final originalHotels = _searchResult?.data?.hotels;
  if (originalHotels == null) return;

  _filteredHotels = originalHotels.where((hotel) {
    final star = int.tryParse(hotel.starRating?.split(".").first ?? "0") ?? 0;
    return star == specificRating; // Changed to exact match
  }).toList();

  notifyListeners();
}

void filterByPriceRange(String? priceRange) {
  final originalHotels = _searchResult?.data?.hotels;
  if (originalHotels == null) return;

  if (priceRange == null) {
    // Reset to show all hotels
    _filteredHotels = originalHotels;
    notifyListeners();
    return;
  }

  // Parse price range string to min/max values
  int minPrice = 0;
  int maxPrice = 0;

  if (priceRange.startsWith("Above")) {
    // Handle "Above ₹ 30,000" case
    final valueString = priceRange.replaceAll("Above ₹ ", "").replaceAll(",", "");
    minPrice = int.tryParse(valueString) ?? 0;
    maxPrice = 999999; // Set high upper limit
  } else {
    // Handle ranges like "₹ 1 – ₹ 2,000"
    final ranges = priceRange.split('–');
    if (ranges.length == 2) {
      minPrice = int.tryParse(ranges[0].replaceAll("₹", "").replaceAll(",", "").trim()) ?? 0;
      maxPrice = int.tryParse(ranges[1].replaceAll("₹", "").replaceAll(",", "").trim()) ?? 0;
    }
  }

  _filteredHotels = originalHotels.where((hotel) {
    final hotelPrice = hotel.rooms!.first.totalFare!.toInt() + hotel.rooms!.first.totalTax!.toInt(); // Assuming hotel has 'price' property
    return hotelPrice >= minPrice && hotelPrice <= maxPrice;
  }).toList();

  notifyListeners();
}

}
