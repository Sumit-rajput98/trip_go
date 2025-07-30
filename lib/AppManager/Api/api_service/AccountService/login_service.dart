import 'package:trip_go/AppManager/Api/api_service/api_call.dart';
import 'package:trip_go/Model/AccountM/login_model.dart';

class LoginService{
  Future<LoginModel?> login(String email, String password) async {
    final String url = "api/User/Login";
    final response = await ApiCall().call(url: url, apiCallType: ApiCallType.post(body:{
    "Id": email,
    "Pw": password
},header: {"Content-Type": "application/json"}));
    if (response!=null) {
      return LoginModel.fromJson(response);
    }
    else{
      throw Exception("Err");
    }
  }
}