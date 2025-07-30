import 'package:flutter/material.dart';
import '../../AppManager/Api/api_service/BusService/bus_book_service.dart';
import '../../Model/BusM/bus_book_model.dart';

class BusBookViewModel extends ChangeNotifier {
  BusBookResponse? _bookResponse;
  bool _isLoading = false;
  String? _error;

  BusBookResponse? get bookResponse => _bookResponse;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> bookBus(Map<String, dynamic> requestBody) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _bookResponse = await BusBookService.bookBus(requestBody);
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  void clear() {
    _bookResponse = null;
    _error = null;
    notifyListeners();
  }
}
