import 'package:flutter/material.dart';
import '../../AppManager/Api/api_service/BusService/bus_order_service.dart';
import '../../Model/BusM/bus_order_model.dart';

class BusOrderViewModel extends ChangeNotifier {
  BusOrderResponse? _orderResponse;
  String? _error;
  bool _isLoading = false;

  BusOrderResponse? get orderResponse => _orderResponse;
  String? get error => _error;
  bool get isLoading => _isLoading;

  Future<void> createBusOrder(Map<String, dynamic> payload) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _orderResponse = await BusOrderService.createOrder(payload);
      debugPrint("✅ Order Response: ${_orderResponse?.data.orderId}");
    } catch (e) {
      _error = e.toString();
      debugPrint("❌ Order Creation Error: $_error");
    }

    _isLoading = false;
    notifyListeners();
  }
}
