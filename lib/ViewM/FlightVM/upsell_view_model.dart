import 'package:flutter/material.dart';
import 'package:trip_go/AppManager/Api/api_service/FlightSearchService/upsell_service.dart';
import 'package:trip_go/Model/FlightM/upsell_model.dart';


class UpsellViewModel extends ChangeNotifier {
  final UpsellService _upsellService = UpsellService();

  bool _isLoading = false;
  String? _errorMessage;
  UpsellModel? _upsellModel;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  UpsellModel? get upsellModel => _upsellModel;

  Future<void> fetchUpsellDetails(dynamic body) async {
    print("Calling upsell with body: $body");
    _isLoading = true;
    _errorMessage = null;
    _upsellModel = null;
    notifyListeners();

    try {
      final result = await _upsellService.getUpsellDetail(body);
      _upsellModel = result;
      print("✅ Upsell fetched. Results: ${_upsellModel?.data?.results?.length}");
    } catch (e) {
      _errorMessage = "Failed to load upsell details: ${e.toString()}";
      print("❌ Error: $_errorMessage");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
