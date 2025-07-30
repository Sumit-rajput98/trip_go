import 'package:flutter/foundation.dart';

import '../../AppManager/Api/api_service/CabService/cab_book_service.dart';
import '../../Model/CabM/cab_book_model.dart';

class CabBookViewModel extends ChangeNotifier {
  final CabBookService _service = CabBookService();

  CabBookingResponse? cabBookingResponse;
  bool isLoading = false;
  String? error;

  Future<void> bookCab(Map<String, dynamic> data) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final result = await _service.bookCab(data);
      if (result != null) {
        cabBookingResponse = result;
      } else {
        error = "Booking failed. Please try again.";
      }
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
