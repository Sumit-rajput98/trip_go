import 'package:trip_go/AppManager/Api/api_service/api_call.dart';

class BusSeatService {
  final ApiCall _api = ApiCall();

  Future<Map<String, dynamic>> fetchBusSeatLayout({
    required String traceId,
    required String resultIndex,
  }) async {
    Map<String, dynamic> body = {
      "TraceId": traceId,
      "ResultIndex": resultIndex,
    };

    final response = await _api.call(
      url: "api/Bus/SeatLayout",
      apiCallType: ApiCallType.post(
        body: body,
        header: {"Content-Type": "application/json"},
      ),
    );

    return response;
  }
}
