import 'package:trip_go/AppManager/Api/api_service/api_call.dart';

class HotelDetailService {
  Future<dynamic> fetchHotelDetail({
    required String hid,
    required String batchKey,
    required List<Map<String, dynamic>> roomsJson,
  }) async {
    final Map<String, dynamic> requestBody = {
      "hid": hid,
      "BatchKey": batchKey,
      "Rooms": roomsJson,
    };

    final response = await ApiCall().call(
      url: "api/Hotel/HotelDetail",
      apiCallType: ApiCallType.post(
        body: requestBody,
        header: {
          "Content-Type": "application/json",
        },
      ),
    );

    return response;
  }
}
