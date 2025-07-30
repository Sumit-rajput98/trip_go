import 'package:flutter/material.dart';

import '../../AppManager/Api/api_service/TourService/destinantion_service.dart';
import '../../Model/TourM/destination_model.dart';

class DestinationViewModel extends ChangeNotifier {
  List<List<DestinationModel>> groupedDestinations = [];
  bool isLoading = false;

  void loadDestinations() async {
    isLoading = true;
    notifyListeners();

    try {
      final destinations = await DestinationService.fetchDestinations();
      groupedDestinations = [];

      for (int i = 0; i < destinations.length; i += 2) {
        final chunk = destinations.sublist(
          i,
          i + 2 > destinations.length ? destinations.length : i + 2,
        );
        groupedDestinations.add(chunk);
      }
    } catch (e) {
      debugPrint('Error loading destinations: \$e');
    }

    isLoading = false;
    notifyListeners();
  }
}