import 'package:flutter/material.dart';
import '../../AppManager/Api/api_service/BusService/bus_block_service.dart';

import '../../Model/BusM/bus_block_model.dart';

class BusBlockViewModel extends ChangeNotifier {
  BusBlockResponse? _blockResponse;
  bool _isLoading = false;
  String? _error;

  BusBlockResponse? get blockResponse => _blockResponse;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> blockBus(Map<String, dynamic> requestBody) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _blockResponse = await BusBlockService.blockBus(requestBody);
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  void clear() {
    _blockResponse = null;
    _error = null;
    notifyListeners();
  }
}
