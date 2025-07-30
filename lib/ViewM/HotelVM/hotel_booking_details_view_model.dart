import 'package:flutter/foundation.dart';
import 'package:trip_go/AppManager/Api/api_service/HotelService/hotel_booking_detail_service.dart';
import 'package:trip_go/Model/HotelM/hotel_bokking_detail_model.dart';


class HotelBookingDetailViewModel extends ChangeNotifier {
  HotelBookingDetailModel? bookingDetail;
  bool isLoading = false;
  String? error;

  Future<void> fetchBookingDetail(dynamic request) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      bookingDetail = await HotelBookingDetailService().getBookingDetail(request);
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }
}
