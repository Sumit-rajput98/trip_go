import 'package:trip_go/AppManager/Api/api_service/api_call.dart';
import 'package:trip_go/Model/AccountM/login_model.dart';
import 'package:trip_go/Model/AccountM/validate_otp_model.dart';

class ValidateOtpService{
  Future<ValidateOtpModel?> login(String countryCode, String phoneNumber,String otp) async {
    final String url = "api/User/ValidateOTP";
    final response = await ApiCall().call(url: url, apiCallType: ApiCallType.post(body:{
    "CountryCode": countryCode,
    "PhoneNumber": phoneNumber,
    "OTP": otp
},header: {"Content-Type": "application/json"}));
    if (response!=null) {
      return ValidateOtpModel.fromJson(response);
    }
    else{
      throw Exception("Err");
    }
  }
}