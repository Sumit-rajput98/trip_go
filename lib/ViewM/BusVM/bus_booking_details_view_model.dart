import 'package:flutter/material.dart';
import '../../AppManager/Api/api_service/BusService/bus_booking_details_service.dart';
import '../../Model/BusM/bus_booking_details_model.dart';

class BusBookingDetailsViewModel extends ChangeNotifier {
  final BusBookingDetailsService _service = BusBookingDetailsService();

  BusBookingDetailsModel? _bookingDetails;
  bool _isLoading = false;
  String? _error;

  BusBookingDetailsModel? get bookingDetails => _bookingDetails;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> getBusBookingDetails({
    required String traceId,
    required int busId,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _bookingDetails = await _service.fetchBookingDetails(
        traceId: traceId,
        busId: busId,
      );
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
