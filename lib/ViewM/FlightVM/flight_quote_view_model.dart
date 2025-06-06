import 'package:flutter/material.dart';
import 'package:trip_go/AppManager/Api/api_service/FlightSearchService/flight_quote_service.dart';
import 'package:trip_go/Model/FlightM/flight_quote_model.dart';

class FlightQuoteViewModel extends ChangeNotifier{
  FlightQuoteModel? _flightQuoteModel;
  FlightQuoteModel? get flightQuoteModel => _flightQuoteModel;
  FlightQuoteModel? _flightQuoteRes1;
  FlightQuoteModel? _flightQuoteRes2;
  FlightQuoteModel? get flightQuoteRes1 => _flightQuoteRes1;
  FlightQuoteModel? get flightQuoteRes2=> _flightQuoteRes2;
  Future<void> fetchQuote(FlightQuoteRequest request) async {
    try {
      _flightQuoteModel = await FlightQuoteService().fetchQuote(request);
      notifyListeners();
    } catch (e) {
      print("Error fetching flight search results: $e");
    }
  }
  Future<void> fetchQuoteRT(FlightQuoteRequest request1,FlightQuoteRequest request2) async {
    try {
      _flightQuoteRes1 = await FlightQuoteService().fetchQuote(request1);
      _flightQuoteRes2 = await FlightQuoteService().fetchQuote(request2);
      notifyListeners();
    } catch (e) {
      print("Error fetching flight search results: $e");
    }
  }
}