import 'package:trip_go/AppManager/Api/api_service/api_call.dart';
import 'package:trip_go/Model/AccountM/edit_profile_model.dart';

class EditProfileService{
  Future<EditProfileModel?> editUserDetail(dynamic body) async {
    final String url = "api/User/EditProfile";
    final response = await ApiCall().call(url: url, apiCallType: ApiCallType.post(body:body,header: {"Content-Type": "application/json"}));
    if (response!=null) {
      return EditProfileModel.fromJson(response);
    }
    else{
      throw Exception("Err");
    }
  }
}