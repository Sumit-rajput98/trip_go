import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MealProvider extends ChangeNotifier {
  final Map<String, Map<String, dynamic>> _selectedMeals = {};

  Map<String, Map<String, dynamic>> get selectedMeals => _selectedMeals;

  String get mealJson => jsonEncode(_selectedMeals.values.toList());

  double get totalMealPrice {
    double total = 0;
    for (var meal in _selectedMeals.values) {
      total += (meal['Price'] ?? 0) * (meal['Quantity'] ?? 1);
    }
    return total;
  }

  void addMeal(Map<String, dynamic> meal) {
    _selectedMeals[meal['Code']] = meal;
    notifyListeners();
  }

  void removeMeal(String code) {
    _selectedMeals.remove(code);
    notifyListeners();
  }

  void clearMeals() {
    _selectedMeals.clear();
    notifyListeners();
  }
}


