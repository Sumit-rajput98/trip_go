import 'package:flutter/material.dart';
import 'package:trip_go/AppManager/Api/api_service/FlightSearchService/flight_SSR_lcc_service.dart';
import 'package:trip_go/Model/FlightM/flight_SSR_model_lcc.dart';

class FlightSsrLccViewModel extends ChangeNotifier{
  FlightSsrModelLcc? _flightSsrLccRes;
  FlightSsrModelLcc? _flightSsrLccRes1;
  FlightSsrModelLcc? _flightSsrLccRes2;

  FlightSsrModelLcc? get flightSsrLccRes => _flightSsrLccRes;
  FlightSsrModelLcc? get flightSsrLccRes1 => _flightSsrLccRes1;
  FlightSsrModelLcc? get flightSsrLccRes2 => _flightSsrLccRes2;

  Future<void> fetchSsrLcc(FlightSsrLccRequest request) async{
    try {
      _flightSsrLccRes = await FlightSsrLccService().fetchSsrLcc(request);
      notifyListeners();
    } catch (e) {
      print("Error fetching flight search results: $e");
    }
  }
  Future<void> fetchSsrLccRT(FlightSsrLccRequest request1,FlightSsrLccRequest request2) async{
    try {
      _flightSsrLccRes1 = await FlightSsrLccService().fetchSsrLcc(request1);
      _flightSsrLccRes2 = await FlightSsrLccService().fetchSsrLcc(request2);
      notifyListeners();
    } catch (e) {
      print("Error fetching flight search results: $e");
    }
  }
}