import 'package:trip_go/AppManager/Api/api_service/api_call.dart';
import 'package:trip_go/Model/FlightM/upsell_model.dart';

class UpsellService{
  Future<UpsellModel?> getUpsellDetail(dynamic body) async {
    final String url = "api/Upsell";
    final response = await ApiCall().call(url: url, apiCallType: ApiCallType.post(body:body,header: {"Content-Type": "application/json"}));
    if (response!=null) {
      return UpsellModel.fromJson(response);
    }
    else{
      throw Exception("Err");
    }
  }
}