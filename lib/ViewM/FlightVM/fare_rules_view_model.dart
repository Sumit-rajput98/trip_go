import 'package:flutter/material.dart';
import 'package:trip_go/AppManager/Api/api_service/FlightSearchService/fare_rule_service.dart';
import 'package:trip_go/Model/FlightM/fare_rules_model.dart';

class FareRulesViewModel extends ChangeNotifier{
  FareRulesModel? _fareRulesModel;
  FareRulesModel? get fareRulesResponse => _fareRulesModel;
  bool isLoading = false;

  Future<void> fetchFareRules(FareRulesRequest request) async{
    try {
      isLoading =true;
      _fareRulesModel = await FareRuleService().fetchFareRule(request);
      notifyListeners();
    } catch (e) {
      print("Error fetching flight search results: $e");
    }
    isLoading = false;
    notifyListeners();
  }


}