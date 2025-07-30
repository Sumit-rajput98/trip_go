import 'package:flutter/material.dart';
import '../../Model/FlightM/flight_SSR_round_model.dart';

class BaggageSelectionRoundProvider extends ChangeNotifier {
  final Map<String, Baggage> _onwardBaggage = {};
  final Map<String, Baggage> _returnBaggage = {};

  double _totalBaggagePrice = 0.0;

  List<Baggage> get onwardBaggage => _onwardBaggage.values.toList();
  List<Baggage> get returnBaggage => _returnBaggage.values.toList();

  double get totalBaggagePrice => _totalBaggagePrice;

  void addBaggage(Baggage baggage, {required bool isReturn}) {
    final target = isReturn ? _returnBaggage : _onwardBaggage;

    final key = baggage.code?.trim();
    if (key == null || key.isEmpty) {
      debugPrint('⚠️ Cannot add baggage with empty code: $baggage');
      return;
    }

    target[key] = baggage;
    _recalculatePrice();
    notifyListeners();
  }

  void removeBaggage(String code, {required bool isReturn}) {
    final key = code.trim();
    if (key.isEmpty) return;

    final target = isReturn ? _returnBaggage : _onwardBaggage;
    target.remove(key);
    _recalculatePrice();
    notifyListeners();
  }

  void clearBaggage() {
    _onwardBaggage.clear();
    _returnBaggage.clear();
    _recalculatePrice();
    notifyListeners();
  }

  void _recalculatePrice() {
    _totalBaggagePrice =
        _onwardBaggage.values.fold(0.0, (sum, b) => sum + (b.price ?? 0.0)) +
            _returnBaggage.values.fold(0.0, (sum, b) => sum + (b.price ?? 0.0));
  }
}
