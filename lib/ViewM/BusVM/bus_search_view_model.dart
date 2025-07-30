import 'package:flutter/foundation.dart';
import '../../../Model/BusM/bus_search_model.dart';
import '../../../AppManager/Api/api_service/BusService/bus_search_service.dart';

class BusSearchViewModel extends ChangeNotifier {
  final BusSearchService _service = BusSearchService();

  bool _isLoading = false;
  String? _error;
  BusSearchModel? _searchResult;

  bool get isLoading => _isLoading;
  String? get error => _error;
  BusSearchModel? get searchResult => _searchResult;

  Future<void> searchBuses({
    required String dateOfJourney,
    required String originId,
    required String destinationId,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _searchResult = await _service.fetchBusSearch(
        dateOfJourney: dateOfJourney,
        originId: originId,
        destinationId: destinationId,
      );
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
