// seat_provider.dart
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trip_go/constants.dart';

import '../../../../../Model/BusM/bus_seat_model.dart';
import '../../../../../Model/BusM/selected_seat_model.dart';

class BusSeatProvider extends ChangeNotifier {
  final Map<String, SelectedSeatModel> _selectedSeats = {};

  Map<String, SelectedSeatModel> get selectedSeats => _selectedSeats;

  void toggleSeat(SelectedSeatModel seat) {
    if (_selectedSeats.containsKey(seat.seatName)) {
      _selectedSeats.remove(seat.seatName);
    } else {
      _selectedSeats[seat.seatName] = seat;
    }
    notifyListeners();
  }

  bool isSelected(String seatName) => _selectedSeats.containsKey(seatName);

  double get totalPrice => _selectedSeats.values
      // .fold(0, (sum, seat) => sum + seat.price.offeredPrice);
      .fold(0, (sum, seat) => sum + seat.price.basePrice);

  // double get totalPrice => _selectedSeats.values
  //     .fold(0, (sum, seat) => sum + seat.price.basePrice.floor());

  List<SelectedSeatModel> get selectedSeatList => _selectedSeats.values.toList();
}


