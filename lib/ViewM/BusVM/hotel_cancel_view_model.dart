import 'package:flutter/foundation.dart';
import '../../AppManager/Api/api_service/HotelService/hotel_cancel_service.dart';
import '../../Model/HotelM/hotel_cancel_model.dart';

class HotelCancelViewModel extends ChangeNotifier {
  bool isLoading = false;
  HotelCancelModel? cancelModel;
  String? error;

  Future<void> cancelHotel(Map<String, dynamic> body) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final result = await HotelCancelService().cancelHotel(body: body);
      cancelModel = result;
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }
}
