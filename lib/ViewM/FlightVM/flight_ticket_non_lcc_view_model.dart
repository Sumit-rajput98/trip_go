import 'package:flutter/material.dart';
import '../../AppManager/Api/api_service/FlightSearchService/flight_book_non_lcc_service.dart';
import '../../AppManager/Api/api_service/FlightSearchService/flight_ticket_lcc_service.dart';
import '../../Model/FlightM/flight_ticket_lcc_model.dart';

class FlightTicketNonLccViewModel extends ChangeNotifier {
  final FlightBookNonLccService _service = FlightBookNonLccService();

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

