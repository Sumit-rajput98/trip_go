import 'package:flutter/material.dart';
import '../../../Model/CabM/cab_cancel_model.dart';
import '../../../AppManager/Api/api_service/CabService/cab_cancel_service.dart';

class CabCancelViewModel extends ChangeNotifier {
  CabCancelModel? cancelModel;
  String? error;

  Future<void> cancelCab(String orderNo, String reason) async {
    cancelModel = null;
    error = null;
    notifyListeners();

    try {
      final result = await CabCancelService.cancelCab(
        orderNo: orderNo,
        cancelledBy: "Customer",
        reason: reason,
      );

      if (result != null && result.success) {
        cancelModel = result;
      } else {
        error = result?.message ?? "Cancellation failed.";
      }
    } catch (e) {
      error = e.toString();
    }

    notifyListeners();
  }
}