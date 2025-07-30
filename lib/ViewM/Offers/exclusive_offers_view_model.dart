import 'package:flutter/material.dart';
import 'package:trip_go/AppManager/Api/api_service/Offers/exclusive_offers_service.dart';
import 'package:trip_go/Model/Offers/ExclusiveOffersModel.dart';


class ExclusiveOffersViewModel extends ChangeNotifier {
  final ExclusiveOffersService _service = ExclusiveOffersService();

  ExclusiveOffersModel? _offersModel;
  bool _isLoading = false;
  String? _error;

  ExclusiveOffersModel? get offersModel => _offersModel;
  List<Datum> get offersList => _offersModel?.data ?? [];
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchExclusiveOffers() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _service.getOffer();
      _offersModel = response;
    } catch (e) {
      _error = "Failed to load offers";
    }

    _isLoading = false;
    notifyListeners();
  }

  void clearData() {
    _offersModel = null;
    _error = null;
    notifyListeners();
  }
}
