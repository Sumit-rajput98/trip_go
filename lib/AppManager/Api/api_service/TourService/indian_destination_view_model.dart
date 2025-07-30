import 'package:flutter/material.dart';
import '../../../../Model/TourM/indian_destination_model.dart';
import '../../../../ViewM/TourVM/indian_destination_service.dart';

class IndianDestinationViewModel extends ChangeNotifier {
  final IndianDestinationService _service = IndianDestinationService();
  List<IndianDestination> _destinations = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<IndianDestination> get destinations => _destinations;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadDestinations() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _destinations = await _service.fetchDestinations();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}