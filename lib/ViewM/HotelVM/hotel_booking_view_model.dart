import 'package:flutter/material.dart';
import 'package:trip_go/AppManager/Api/api_service/HotelService/hotel_booking_service.dart';
import 'package:trip_go/Model/HotelM/hotek_booking_model.dart';

class HotelPreBookingViewModel extends ChangeNotifier {
  final HotelBookingService _hotelBookingService = HotelBookingService();

  HotelBookingModel? _bookingResult;
  HotelBookingModel? get bookingResult => _bookingResult;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  
  Future<void> bookHotel(dynamic requestBody) async {
    _isLoading = true;
    _errorMessage = null;
    _bookingResult = null;
    notifyListeners();

    try {
      final response = await _hotelBookingService.bookHotels(requestBody);
      _bookingResult = response;
    } catch (e) {
      if (e is Exception) {
        _errorMessage = _cleanExceptionMessage(e.toString());
      } else {
        _errorMessage = "Booking failed: ${e.toString()}";
      }
    }
   
    _isLoading = false;
    notifyListeners();
  }
    String _cleanExceptionMessage(String message) {
    // Remove "Exception: " prefix if present
    const prefix = "Exception: ";
    return message.startsWith(prefix) 
        ? message.substring(prefix.length)
        : message;
  }

  /// Clear state
  void reset() {
    _isLoading = false;
    _errorMessage = null;
    _bookingResult = null;
    notifyListeners();
  }
}
