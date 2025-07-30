import 'package:trip_go/AppManager/Api/api_service/api_call.dart';
import 'package:trip_go/AppManager/Api/api_service/api_constant.dart';
import '../../../../Model/CabM/cab_search_model.dart';

class CabSearchService {
  Future<CabSearchModel?> searchCab(Map<String, dynamic> body) async {
    final api = ApiCall();
    final response = await api.call(
      url: 'api/Cab/Search',
      apiCallType: ApiCallType.post(
        body: body,
        header: {
          'Content-Type': 'application/json',
        },
      ),
    );

    if (response != null && response['success'] == true) {
      return CabSearchModel.fromJson(response);
    } else {
      return null;
    }
  }
}
