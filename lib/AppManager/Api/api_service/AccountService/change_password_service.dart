import 'package:trip_go/AppManager/Api/api_service/api_call.dart';
import 'package:trip_go/Model/AccountM/change_password_model.dart';


class ChangePasswordService{
  Future<ChangePasswordModel?> changePassword(dynamic body) async {
    final String url = "api/User/ChangePassword";
    final response = await ApiCall().call(url: url, apiCallType: ApiCallType.post(body:body,header: {"Content-Type": "application/json"}));
    if (response!=null) {
      return ChangePasswordModel.fromJson(response);
    }
    else{
      throw Exception("Err");
    }
  }
}