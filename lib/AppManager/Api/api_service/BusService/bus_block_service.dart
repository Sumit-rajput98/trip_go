import '../../../../Model/BusM/bus_block_model.dart';
import '../api_call.dart';

class BusBlockService {
  static const String endpoint = "api/Bus/Block"; // Only the endpoint, base URL is in ApiConstant

  static Future<BusBlockResponse> blockBus(Map<String, dynamic> requestBody) async {
    try {
      final apiCall = ApiCall();
      final result = await apiCall.call(
        url: endpoint,
        apiCallType: ApiCallType.post(
          body: requestBody,
          header: {
            "Content-Type": "application/json",
          },
        ),
      );

      return BusBlockResponse.fromJson(result);
    } catch (e) {
      throw Exception("Failed to block bus: $e");
    }
  }
}
