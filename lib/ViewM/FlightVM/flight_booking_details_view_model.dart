import 'package:flutter/material.dart';
import '../../AppManager/Api/api_service/FlightSearchService/flight_booking_details_service.dart';
import '../../Model/FlightM/flight_booking_details.dart';

class FlightBookingDetailsViewModel extends ChangeNotifier {
  final FlightBookingDetailsService _service = FlightBookingDetailsService();

  FlightBookingDetailsModel? bookingDetails;
  bool isLoading = false;
  String? errorMessage;

  Future<void> loadBookingDetails({
    required String traceId,
    required String pnr,
    required String bookingId,
  }) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final result = await _service.fetchFlightBookingDetails(
        traceId: traceId,
        pnr: pnr,
        bookingId: bookingId,
      );

      if (result != null && result.success!) {
        bookingDetails = result;
      } else {
        errorMessage = result?.message ?? 'Unknown error';
      }
    } catch (e) {
      errorMessage = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }
}
