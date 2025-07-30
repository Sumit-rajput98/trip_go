import 'package:flutter/material.dart';
import 'package:trip_go/AppManager/Api/api_service/HotelService/hotel_book_response_service.dart';
import 'package:trip_go/Model/HotelM/book_response_model.dart';

/// Simple finite‑state machine for the booking workflow.
enum BookingState { idle, loading, success, failure }

class HotelBookViewModel extends ChangeNotifier {
  final HotelBookResponseService _service;

  HotelBookViewModel({HotelBookResponseService? service})
      : _service = service ?? HotelBookResponseService();

  BookingState _state = BookingState.idle;
  BookingState get state => _state;

  BookResponseModel? _response;
  BookResponseModel? get response => _response;

  String? _error;
  String? get error => _error;

  /// Call this from your “Book Now” button.
  Future<void> bookHotel(dynamic request) async {
    _state = BookingState.loading;
    notifyListeners();

    try {
      _response = await _service.bookHotels(request);

      final isSuccess = _response?.success == true &&
          (_response?.data?.bookResult?.hotelBookingStatus == 'Confirmed' ||
              _response?.data?.bookResult?.voucherStatus == true);

      if (isSuccess) {
        _state = BookingState.success;
        _error = null;
      } else {
        _state = BookingState.failure;
        _error = _response?.message ?? 'Unknown booking failure';
      }
    } catch (e) {
      _state = BookingState.failure;
      _error = 'Something went wrong, please try again.';
    }

    notifyListeners();
  }

}
