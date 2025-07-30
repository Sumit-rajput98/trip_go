import 'package:trip_go/AppManager/Api/api_service/api_call.dart';
import 'package:trip_go/AppManager/Api/api_service/api_constant.dart';

class BusBoardingService {
  final ApiCall _apiCall = ApiCall();

  Future<dynamic> fetchBoardingPoints({
    required String traceId,
    required String resultIndex,
  }) async {
    const String endpoint = "api/Bus/Boarding";

    Map<String, dynamic> body = {
      "TraceId": traceId,
      "ResultIndex": resultIndex,
    };

    var response = await _apiCall.call(
      url: endpoint,
      apiCallType: ApiCallType.post(
        body: body,
        header: {"Content-Type": "application/json"},
      ),
    );

    return response;
  }
}
