import 'package:flutter/material.dart';
import '../../Model/FlightM/flight_SSR_model_lcc.dart'; // Replace with the file where Seat is defined
class SeatSelectionProvider extends ChangeNotifier {
  final List<Seat> _selectedSeats = [];
  double _totalPrice = 0.0;

  List<Seat> get selectedSeats => _selectedSeats;
  double get totalPrice => _totalPrice;

  void addSeat(Seat seat) {
    _selectedSeats.add(seat);
    _totalPrice += seat.price ?? 0.0;  
    notifyListeners();
  }

  void removeSeat(String seatId) {
    final seat = _selectedSeats.firstWhere((s) => s.code == seatId,);
    _totalPrice -= seat.price ?? 0.0;  
    _selectedSeats.remove(seat);
    notifyListeners();
    }

  void clearSeats() {
    _selectedSeats.clear();
    _totalPrice = 0.0;
    notifyListeners();
  }
}
