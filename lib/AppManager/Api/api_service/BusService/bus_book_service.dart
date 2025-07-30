import '../../../../Model/BusM/bus_book_model.dart';
import '../api_call.dart';

class BusBookService {
  static const String endpoint = "api/Bus/Book"; // Only the endpoint, base URL is in ApiConstant

  static Future<BusBookResponse> bookBus(Map<String, dynamic> requestBody) async {
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

      return BusBookResponse.fromJson(result);
    } catch (e) {
      throw Exception("Failed to block bus: $e");
    }
  }
}
