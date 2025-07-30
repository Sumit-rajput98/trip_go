import 'package:flutter/foundation.dart';

import '../../../../../AppManager/Api/api_service/CabService/cab_create_order_service.dart';
import '../../../../../Model/CabM/cab_create_order_model.dart';


class CabCreateOrderViewModel extends ChangeNotifier {
  CabCreateOrderModel? orderData;
  String? error;

  Future<void> createCabOrder({required String cabId, required int amount}) async {
    try {
      final service = CabCreateOrderService();
      orderData = await service.createOrder(cabId: cabId, amount: amount);
      error = null;
    } catch (e) {
      orderData = null;
      error = e.toString();
    }
    notifyListeners();
  }
}
