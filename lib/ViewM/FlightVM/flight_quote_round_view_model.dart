import 'package:flutter/material.dart';
import 'package:trip_go/AppManager/Api/api_service/FlightSearchService/flight_quote_service.dart';
import 'package:trip_go/Model/FlightM/flight_quote_model.dart';

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
  Future<void> fetchQuoteRoundRT(FlightQuoteRoundRequest request1) async {
    try {
      _flightQuoteRoundRes1 = await FlightQuoteRoundService().fetchQuote(request1);
      notifyListeners();
    } catch (e) {
      print("Error fetching flight search results: $e");
    }
  }
}