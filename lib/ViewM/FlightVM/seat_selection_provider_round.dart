import 'package:flutter/material.dart';

import '../../Model/FlightM/flight_SSR_round_model.dart';

class SeatSelectionProviderRound extends ChangeNotifier {
  final List<Seat> _selectedSeats = [];
  double _totalPrice = 0.0;
  final Map<String, Seat> _onwardSeats = {};
  final Map<String, Seat> _returnSeats = {};

  List<Seat> get selectedSeats => _selectedSeats;
  double get totalPrice => _totalPrice;

  void addSeat(Seat seat, {required bool isReturn}) {
    final map = isReturn ? _returnSeats : _onwardSeats;
    map[seat.code ?? ''] = seat;
    _recalculateTotalPrice();
    notifyListeners();
  }

  void removeSeat(String seatCode, {required bool isReturn}) {
    final map = isReturn ? _returnSeats : _onwardSeats;
    map.remove(seatCode);
    _recalculateTotalPrice();
    notifyListeners();
  }

  void _recalculateTotalPrice() {
    _totalPrice = _onwardSeats.values.fold(0.0, (sum, seat) => sum + (seat.price ?? 0.0)) +
        _returnSeats.values.fold(0.0, (sum, seat) => sum + (seat.price ?? 0.0));
  }

  List<Seat> get onwardSeats => _onwardSeats.values.toList();
  List<Seat> get returnSeats => _returnSeats.values.toList();

  void clearSeats() {
    _selectedSeats.clear();
    _totalPrice = 0.0;
    notifyListeners();
  }
}
