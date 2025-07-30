// traveller_provider.dart
import 'package:flutter/material.dart';

class BusPassenger {
  String title;
  String firstName;
  String lastName;
  int age;
  String gender;
  String email;
  String phone;
  bool isLead;
  dynamic seat;

  BusPassenger({
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.gender,
    required this.email,
    required this.phone,
    required this.isLead,
    required this.seat,
  });

  Map<String, dynamic> toMap() {
    return {
      "LeadPassenger": isLead,
      "PassengerId": 0,
      "Title": title,
      "Address": null,
      "Age": age,
      "Email": email,
      "FirstName": firstName,
      "Gender": gender == "Male" ? 1 : 2,
      "LastName": lastName,
      "Phoneno": phone,
      "Seat": seat,
    };
  }
}

class BusTravellerProvider extends ChangeNotifier {
  final Map<int, BusPassenger> _passengers = {};

  void updatePassenger(int index, BusPassenger passenger) {
    _passengers[index] = passenger;
    notifyListeners();
  }

  List<Map<String, dynamic>> get passengerList {
    return _passengers.entries.map((e) {
      final p = e.value;
      p.isLead = e.key == 0;
      return p.toMap();
    }).toList();
  }

  void clear() {
    _passengers.clear();
    notifyListeners();
  }
}
