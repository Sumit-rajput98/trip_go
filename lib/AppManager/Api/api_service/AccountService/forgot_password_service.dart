import 'package:trip_go/AppManager/Api/api_service/api_call.dart';
import 'package:trip_go/Model/AccountM/forgot_password_model.dart';
import 'package:trip_go/Model/AccountM/login_model.dart';

class ForgotPasswordService{
  Future<ForgotPasswordModel?> forgotPass(String id) async {
    final String url = "api/User/ForgetPassword";
    final response = await ApiCall().call(url: url, apiCallType: ApiCallType.post(body:{
    "Id": id
},header: {"Content-Type": "application/json"}));
    if (response!=null) {
      return ForgotPasswordModel.fromJson(response);
    }
    else{
      throw Exception("Err");
    }
  }
}