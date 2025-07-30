import 'package:flutter/material.dart';

import '../../AppManager/Api/api_service/TourService/quick_enquiry_service.dart';
import '../../Model/TourM/quick_enquiry_model.dart';

class QuickEnquiryViewModel extends ChangeNotifier {
  bool isLoading = false;

  Future<Map<String, dynamic>> sendEnquiry(BuildContext context, QuickEnquiryModel model) async {
    isLoading = true;
    notifyListeners();

    try {
      final result = await QuickEnquiryService.submitEnquiry(model);
      isLoading = false;
      notifyListeners();

      print("🔄 API Response: $result");

      return result; // Must return a Map like {'success': true, 'message': '...'}
    } catch (e) {
      isLoading = false;
      notifyListeners();
      print("❌ Error: $e");

      return {
        'success': false,
        'message': 'Error sending enquiry',
      };
    }
  }

}
