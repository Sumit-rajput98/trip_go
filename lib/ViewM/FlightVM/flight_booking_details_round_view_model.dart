import 'package:flutter/material.dart';
import '../../AppManager/Api/api_service/FlightSearchService/flight_booking_details_round_service.dart';
import '../../AppManager/Api/api_service/FlightSearchService/flight_booking_details_service.dart';
import '../../Model/FlightM/flight_booking_details.dart';
import '../../Model/FlightM/flight_booking_details_round_model.dart';

class FlightBookingDetailsRoundViewModel extends ChangeNotifier {
  final FlightBookingDetailsRoundService _service = FlightBookingDetailsRoundService();

  FlightBookingDetailsRoundModel? bookingDetails;
  bool isLoading = false;
  String? errorMessage;

  Future<void> loadBookingDetails({
    required String traceId,
    required String pnr,
    required int bookingId,
    required String pnrIb,
    required int bookingIdIb,
  }) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final result = await _service.fetchFlightBookingDetails(
        traceId: traceId,
        pnr: pnr,
        bookingId: bookingId, pnrIb: pnrIb, bookingIdIb: bookingIdIb,
      );

      if (result != null && result.success) {
        bookingDetails = result as FlightBookingDetailsRoundModel?;
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
