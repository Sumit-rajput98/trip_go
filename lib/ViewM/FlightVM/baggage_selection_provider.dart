import 'package:flutter/material.dart';
import '../../Model/FlightM/flight_SSR_model_lcc.dart'; // Replace with correct model import

class BaggageSelectionProvider extends ChangeNotifier {
  final List<Baggage> _selectedBaggage = [];
  double _totalBaggagePrice = 0.0;

  List<Baggage> get selectedBaggage => _selectedBaggage;
  double get totalBaggagePrice => _totalBaggagePrice;

  void addBaggage(Baggage baggage) {
    _selectedBaggage.add(baggage);
    _totalBaggagePrice += baggage.price ?? 0.0;
    notifyListeners();
  }

  void removeBaggage(Baggage baggage) {
    _selectedBaggage.remove(baggage);
    _totalBaggagePrice -= baggage.price ?? 0.0;
    notifyListeners();
  }

  void clearBaggage() {
    _selectedBaggage.clear();
    _totalBaggagePrice = 0.0;
    notifyListeners();
  }
}
