import 'package:flutter/material.dart';
import '../../AppManager/Api/api_service/FlightSearchService/flight_SSR_lcc_round_service.dart';
import '../../Model/FlightM/flight_SSR_round_model.dart';

class FlightSsrLccRoundViewModel extends ChangeNotifier{
  FlightSsrModelRoundLcc? _flightSsrLccRoundRes;
  FlightSsrModelRoundLcc? _flightSsrLccRoundRes1;
  FlightSsrModelRoundLcc? _flightSsrLccRoundRes2;

  FlightSsrModelRoundLcc? get flightSsrLccRes => _flightSsrLccRoundRes;
  FlightSsrModelRoundLcc? get flightSsrLccRoundRes1 => _flightSsrLccRoundRes1;
  FlightSsrModelRoundLcc? get flightSsrLccRes2 => _flightSsrLccRoundRes2;

  Future<void> fetchSsrRoundLcc(FlightSsrLccRoundRequest request) async{
    try {
      _flightSsrLccRoundRes = await FlightSsrLccRoundService().fetchSsrRoundLcc(request);
      notifyListeners();
    } catch (e) {
      print("Error fetching flight search results: $e");
    }
  }
  Future<void> fetchSsrLccRoundRT(FlightSsrLccRoundRequest request1) async{
    try {
      _flightSsrLccRoundRes1 = await FlightSsrLccRoundService().fetchSsrRoundLcc(request1);
      // _flightSsrLccRoundRes2 = await FlightSsrLccRoundService().fetchSsrRoundLcc(request2);
      notifyListeners();
    } catch (e) {
      print("Error fetching flight search results: $e");
    }
  }
}