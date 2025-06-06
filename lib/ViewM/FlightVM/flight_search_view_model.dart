import 'package:flutter/material.dart';
import '../../AppManager/Api/api_service/FlightSearchService/flight_search_service.dart';
import '../../Model/FlightM/flight_search_model.dart';

class FlightSearchViewModel extends ChangeNotifier {
  FlightSearchResponse? _flightSearchResponse;
  FlightSearchResponse? get flightSearchResponse => _flightSearchResponse;

  Future<void> searchFlights(FlightSearchRequest request) async {
    try {
      _flightSearchResponse = await FlightSearchService().searchFlights(request);
      notifyListeners();
    } catch (e) {
      print("Error fetching flight search results: $e");
    }
  }
}
