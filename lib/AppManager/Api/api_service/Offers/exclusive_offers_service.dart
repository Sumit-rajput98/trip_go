import 'package:trip_go/AppManager/Api/api_service/api_call.dart';
import 'package:trip_go/Model/Offers/ExclusiveOffersModel.dart';

class ExclusiveOffersService{
  Future<ExclusiveOffersModel?> getOffer() async {
    final String url = "api/AllOffers";
    final response = await ApiCall().call(url: url, apiCallType: ApiCallType.get(header: {"Content-Type": "application/json"}));
    if (response!=null) {
      return ExclusiveOffersModel.fromJson(response);
    }
    else{
      throw Exception("Err");
    }
  }
}