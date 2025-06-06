import 'package:flutter/material.dart';
import 'package:trip_go/AppManager/Api/api_service/FlightSearchService/round_trip_flight_search_service.dart';
import 'package:trip_go/Model/FlightM/round_trip_flight_search_model.dart';

class RoundTripFlightSearchViewModel extends ChangeNotifier{
  RoundTripFlightSearchModel? _flightSearchResponse;
  RoundTripFlightSearchModel? get flightSearchResponse => _flightSearchResponse;

  Future<void> searchFlights(RoundTripFlightSearchRequest request) async {
    try {
      _flightSearchResponse = await RoundTripFlightSearchService().fetchFlight(request);
      notifyListeners();
    } catch (e) {
      print("Error fetching flight search results: $e");
    }
  }
}