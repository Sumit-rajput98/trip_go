import 'package:flutter/material.dart';

import '../../AppManager/Api/api_service/FlightSearchService/flight_quote_round_service.dart';
import '../../Model/FlightM/flight_quote_round_model.dart';

class FlightQuoteRoundViewModel extends ChangeNotifier{
  FlightQuoteRoundModel? _flightQuoteRoundModel;
  FlightQuoteRoundModel? get flightQuoteRoundModel => _flightQuoteRoundModel;
  FlightQuoteRoundModel? _flightQuoteRoundRes1;
  FlightQuoteRoundModel? get flightQuoteRoundRes1 => _flightQuoteRoundRes1;
  Future<void> fetchQuote(FlightQuoteRoundRequest request) async {
    try {
      _flightQuoteRoundModel = await FlightQuoteRoundService().fetchQuote(request);
      notifyListeners();
    } catch (e) {
      print("Error fetching flight search results: $e");
    }
  }
  Future<void> fetchQuoteRoundRT(FlightQuoteRoundRequest request) async {
    try {
      print("📤 Sending round trip quote request...");
      _flightQuoteRoundRes1 = await FlightQuoteRoundService().fetchQuote(request);
      print("✅ Response received");
      notifyListeners();
    } catch (e) {
      print("❌ Error fetching flight search results: $e");
      rethrow; // This lets the UI show or handle the error
    }
  }
}