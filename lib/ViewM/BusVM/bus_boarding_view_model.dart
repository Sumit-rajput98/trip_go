import 'package:flutter/material.dart';
import 'package:trip_go/Model/BusM/bus_boarding_model.dart';
import '../../AppManager/Api/api_service/BusService/bus_boarding_service.dart';

class BusBoardingViewModel extends ChangeNotifier {
  final BusBoardingService _service = BusBoardingService();

  BusBoardingModel? _busBoardingData;
  bool _isLoading = false;
  String? _error;

  BusBoardingModel? get busBoardingData => _busBoardingData;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadBoardingData(String traceId, String resultIndex) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _service.fetchBoardingPoints(
        traceId: traceId,
        resultIndex: resultIndex,
      );

      _busBoardingData = BusBoardingModel.fromJson(response);
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
