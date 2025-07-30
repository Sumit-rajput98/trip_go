import 'package:flutter/material.dart';
import '../../Model/FlightM/flight_SSR_round_model.dart';

class MealSelectionRoundProvider extends ChangeNotifier {
  final Map<String, MealDynamic> _onwardMeals = {};
  final Map<String, MealDynamic> _returnMeals = {};

  double _totalMealPrice = 0.0;

  List<MealDynamic> get onwardMeals => _onwardMeals.values.toList();
  List<MealDynamic> get returnMeals => _returnMeals.values.toList();

  double get totalMealPrice => _totalMealPrice;

  void addMeal(MealDynamic meal, {required bool isReturn}) {
    final target = isReturn ? _returnMeals : _onwardMeals;
    final key = meal.code?.trim();

    if (key == null || key.isEmpty) {
      debugPrint("⚠️ Meal code missing: $meal");
      return;
    }

    target[key] = meal;
    _recalculatePrice();
    notifyListeners();
  }

  void removeMeal(String code, {required bool isReturn}) {
    final target = isReturn ? _returnMeals : _onwardMeals;
    target.remove(code.trim());
    _recalculatePrice();
    notifyListeners();
  }

  void clearMeals() {
    _onwardMeals.clear();
    _returnMeals.clear();
    _recalculatePrice();
    notifyListeners();
  }

  void _recalculatePrice() {
    _totalMealPrice =
        _onwardMeals.values.fold(0.0, (sum, m) => sum + (m.price ?? 0.0)) +
            _returnMeals.values.fold(0.0, (sum, m) => sum + (m.price ?? 0.0));
  }
}
