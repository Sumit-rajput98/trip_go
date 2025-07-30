import 'package:flutter/material.dart';
import '../../AppManager/Api/api_service/TourService/package_inquiry_service.dart';
import '../../Model/TourM/package_inquiry_model.dart';

class PackageInquiryViewModel extends ChangeNotifier {
  bool _loading = false;
  String? _message;

  bool get isLoading => _loading;
  String? get message => _message;

  Future<String?> submitInquiry(PackageInquiryModel model, BuildContext context) async {
    _loading = true;
    _message = null;
    notifyListeners();

    final responseMsg = await PackageInquiryService.sendInquiry(model);

    _message = responseMsg;
    _loading = false;
    notifyListeners();

    return responseMsg;
  }
}