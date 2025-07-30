import 'package:flutter/material.dart';

import '../../AppManager/Api/api_service/TourService/international_destination_service.dart';
import '../../Model/TourM/international_destination_model.dart';

class InternationalDestinationViewModel extends ChangeNotifier {
  List<InternationalDestinationModel> destinations = [];
  bool isLoading = false;

  Future<void> loadDestinations() async {
    isLoading = true;
    notifyListeners();
    try {
      destinations = await InternationalDestinationService.fetchDestinations();
    } catch (e) {
      debugPrint(e.toString());
    }
    isLoading = false;
    notifyListeners();
  }
}