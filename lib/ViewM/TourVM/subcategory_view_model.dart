import 'package:flutter/material.dart';

import '../../AppManager/Api/api_service/TourService/subcategory_service.dart';
import '../../Model/TourM/subcategory_model.dart';

class SubCategoryViewModel extends ChangeNotifier {
  final SubCategoryService _service = SubCategoryService();
  SubCategoryModel? subCategoryData;
  bool isLoading = false;

  Future<void> getSubCategory(String slug2) async {
    isLoading = true;
    notifyListeners();

    subCategoryData = await _service.fetchSubCategory(slug2);

    isLoading = false;
    notifyListeners();
  }
}
