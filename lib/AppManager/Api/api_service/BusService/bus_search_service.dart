import 'package:trip_go/AppManager/Api/api_service/api_call.dart';
import '../../../../Model/BusM/bus_search_model.dart';

class BusSearchService {
  Future<BusSearchModel> fetchBusSearch({
    required String dateOfJourney,
    required String originId,
    required String destinationId,
  }) async {
    final response = await ApiCall().call(
      url: 'api/Bus/Search',
      apiCallType: ApiCallType.post(
        body: {
          "DateOfJourney": dateOfJourney,
          "DestinationId": destinationId.toString(),
          "OriginId": originId.toString(),
        },
        header: {
          'Content-Type': 'application/json', // ✅ Required for most APIs
          // Add Authorization here if needed
          // 'Authorization': 'Bearer YOUR_TOKEN',
        },
      ),
    );

    if (response['success'] == true &&
        response['data']?['BusSearchResult'] != null) {
      return BusSearchModel.fromJson(response['data']['BusSearchResult']);
    } else {
      throw Exception(response['message'] ?? 'Bus search failed');
    }
  }
}

