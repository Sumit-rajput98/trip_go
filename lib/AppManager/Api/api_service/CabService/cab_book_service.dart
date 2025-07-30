import '../../../../Model/CabM/cab_book_model.dart';
import '../api_call.dart';

class CabBookService {
  Future<CabBookingResponse?> bookCab(Map<String, dynamic> requestData) async {
    final apiCall = ApiCall();

    final response = await apiCall.call(
      url: 'api/Cab/Book',
      apiCallType: ApiCallType.post(
        body: requestData,
        header: {
          'Content-Type': 'application/json',
        },
      ),
    );

    if (response != null && response['success'] == true) {
      return CabBookingResponse.fromJson(response);
    } else {
      return null;
    }
  }
}
