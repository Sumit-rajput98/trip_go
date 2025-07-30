import 'package:trip_go/AppManager/Api/api_service/api_call.dart';
import 'package:trip_go/Model/AccountM/login_model.dart';
import 'package:trip_go/Model/AccountM/login_otp_model.dart';
import 'package:trip_go/Model/AccountM/register_model.dart';

class RegisterService{
  Future<RegisterModel?> login(dynamic body) async {
    final String url = "api/User/Register";
    final response = await ApiCall().call(url: url, apiCallType: ApiCallType.post(body:body,header: {"Content-Type": "application/json"}));
    if (response!=null) {
      return RegisterModel.fromJson(response);
    }
    else{
      throw Exception("Err");
    }
  }
}