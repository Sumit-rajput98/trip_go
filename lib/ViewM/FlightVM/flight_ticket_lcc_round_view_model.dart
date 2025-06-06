import 'package:flutter/material.dart';
import '../../AppManager/Api/api_service/FlightSearchService/flight_ticket_round_lcc_service.dart';
import '../../Model/FlightM/flight_ticket_lcc_round_model.dart';

class FlightTicketLccRoundViewModel extends ChangeNotifier {
  final FlightTicketRoundLccService _service = FlightTicketRoundLccService();

  bool isLoading = false;
  FlightTicketResponseRound? response;
  String? error;

  Future<void> bookFlight(FlightTicketRequestRound request) async {
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

