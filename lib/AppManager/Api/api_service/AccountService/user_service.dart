import 'package:trip_go/AppManager/Api/api_service/api_call.dart';
import 'package:trip_go/Model/AccountM/login_model.dart';
import 'package:trip_go/Model/AccountM/login_otp_model.dart';
import 'package:trip_go/Model/AccountM/register_model.dart';
import 'package:trip_go/Model/AccountM/user_model.dart';

class UserService{
  Future<UserModel?> getUserDetail(dynamic body) async {
    final String url = "api/User/Detail";
    final response = await ApiCall().call(url: url, apiCallType: ApiCallType.post(body:body,header: {"Content-Type": "application/json"}));
    if (response!=null) {
      return UserModel.fromJson(response);
    }
    else{
      throw Exception("Err");
    }
  }
}