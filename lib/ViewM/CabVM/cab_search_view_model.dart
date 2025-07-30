import 'package:flutter/material.dart';

import '../../AppManager/Api/api_service/CabService/cab_search_service.dart';
import '../../Model/CabM/cab_search_model.dart';

class CabSearchViewModel extends ChangeNotifier {
  final CabSearchService _cabSearchService = CabSearchService();

  bool isLoading = false;
  List<CabModel> cabs = [];
  String message = '';

  Future<void> fetchCabs(Map<String, dynamic> requestBody) async {
    isLoading = true;
    notifyListeners();

    final response = await _cabSearchService.searchCab(requestBody);

    if (response != null) {
      cabs = response.cabs;
      message = response.message;
    } else {
      message = 'No cabs found or something went wrong.';
      cabs = [];
    }

    isLoading = false;
    notifyListeners();
  }
}
