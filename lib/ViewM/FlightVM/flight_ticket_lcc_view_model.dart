import 'package:flutter/material.dart';
import '../../AppManager/Api/api_service/FlightSearchService/flight_ticket_lcc_service.dart';
import '../../Model/FlightM/flight_ticket_lcc_model.dart';

class FlightTicketLccViewModel extends ChangeNotifier {
  final FlightTicketLccService _service = FlightTicketLccService();

  bool isLoading = false;
  FlightTicketResponse? response;
  String? error;

  Future<void> bookFlight(FlightTicketRequest request) async {
    isLoading = true;
    notifyListeners();

    try {
      response = await _service.bookFlight(request);
      error = null;

    } catch (e) {
      error = e.toString();
      response = null;
      print('❌ Exception during booking: $error');
    }

    isLoading = false;
    notifyListeners();
  }
}

