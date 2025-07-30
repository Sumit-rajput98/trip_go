import 'package:flutter/foundation.dart';
import '../../AppManager/Api/api_service/HotelService/create_hotel_order_service.dart';
import '../../Model/HotelM/create_hotel_order_model.dart';

class CreateHotelOrderViewModel extends ChangeNotifier {
  final CreateHotelOrderService _service = CreateHotelOrderService();

  bool isLoading = false;
  CreateHotelOrderResponse? hotelOrderResponse;
  String? error;

  Future<void> createOrder(String bookingCode, int amount) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await _service.createHotelOrder(
        bookingCode: bookingCode,
        amount: amount,
      );

      hotelOrderResponse = CreateHotelOrderResponse.fromJson(response);
      error = null;
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }
}
