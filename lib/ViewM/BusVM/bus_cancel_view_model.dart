import 'package:flutter/foundation.dart';

import '../../AppManager/Api/api_service/BusService/bus_cancel_service.dart';
import '../../Model/BusM/bus_cancel_model.dart';

class BusCancelViewModel extends ChangeNotifier {
  bool isLoading = false;
  BusCancelModel? cancelModel;
  String? error;

  Future<void> cancelBus(int busId, String remarks) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final result = await BusCancelService().cancelBus(
        busId: busId,
        remarks: remarks,
      );
      cancelModel = result;
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }
}
