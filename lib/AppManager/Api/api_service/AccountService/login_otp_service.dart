import 'package:trip_go/AppManager/Api/api_service/api_call.dart';
import 'package:trip_go/Model/AccountM/login_model.dart';
import 'package:trip_go/Model/AccountM/login_otp_model.dart';

class LoginOtpService{
  Future<LoginOtpModel?> login(dynamic body) async {
    final String url = "api/User/LoginOTP";
    final response = await ApiCall().call(url: url, apiCallType: ApiCallType.post(body:body,header: {"Content-Type": "application/json"}));
    if (response!=null) {
      return LoginOtpModel.fromJson(response);
    }
    else{
      throw Exception("Err");
    }
  }
}