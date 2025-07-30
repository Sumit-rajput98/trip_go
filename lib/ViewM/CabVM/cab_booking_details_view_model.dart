import 'package:flutter/material.dart';

import '../../AppManager/Api/api_service/CabService/cab_booking_details_service.dart';
import '../../Model/CabM/cab_booking_details_model.dart';

class CabBookingDetailsViewModel extends ChangeNotifier {
  bool isLoading = false;
  CabOrder? bookingDetails;
  String? errorMessage;

  Future<void> loadBookingDetails(String orderNo) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    final result = await CabBookingDetailsService.fetchCabBookingDetails(orderNo);
    if (result != null && result.success) {
      bookingDetails = result.data.order;
    } else {
      errorMessage = "Failed to load booking details.";
    }

    isLoading = false;
    notifyListeners();
  }
}
