import 'package:flutter/material.dart';
import 'package:trip_go/AppManager/Api/api_service/AccountService/edit_profile_service.dart';
import 'package:trip_go/Model/AccountM/edit_profile_model.dart';


class EditProfileViewModel extends ChangeNotifier {
  final EditProfileService _userService = EditProfileService();

  EditProfileModel? _editProfileResponse;
  bool _isLoading = false;
  String? _errorMessage;

  EditProfileModel? get editProfileResponse => _editProfileResponse;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> updateUserProfile(Map<String, dynamic> body) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _editProfileResponse = await _userService.editUserDetail(body);
    } catch (e) {
      _errorMessage = 'Failed to update profile';
    }

    _isLoading = false;
    notifyListeners();
  }

  void clearResponse() {
    _editProfileResponse = null;
    _errorMessage = null;
    notifyListeners();
  }
}
