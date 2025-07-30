import 'package:flutter/material.dart';

import '../../AppManager/Api/api_service/BusService/bus_seat_service.dart';
import '../../Model/BusM/bus_seat_model.dart';

class BusSeatViewModel extends ChangeNotifier {
  final BusSeatService _service = BusSeatService();

  BusSeatLayoutResponse? _busSeatData;
  bool _isLoading = false;
  String? _errorMessage;

  BusSeatLayoutResponse? get busSeatData => _busSeatData;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchSeatLayout(String traceId, String resultIndex) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _service.fetchBusSeatLayout(
        traceId: traceId,
        resultIndex: resultIndex,
      );
      _busSeatData = BusSeatLayoutResponse.fromJson(response);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
