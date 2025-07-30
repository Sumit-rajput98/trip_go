import 'package:flutter/material.dart';
import '../../AppManager/Api/api_service/HotelService/hotel_detail_service.dart';
import '../../Model/HotelM/hotel_detail_data.dart';

class HotelDetailViewModel extends ChangeNotifier {
  final _service = HotelDetailService();

  bool isLoading = false;
  HotelDetailResponse? hotelDetailData;

  Future<void> getHotelDetail({
    required String hid,
    required String batchKey,
    required List<Map<String, dynamic>> roomsJson,
  }) async {
    isLoading = true;
    notifyListeners();

    try {
      final result = await _service.fetchHotelDetail(
        hid: hid,
        batchKey: batchKey,
        roomsJson: roomsJson,
      );

      hotelDetailData = HotelDetailResponse.fromJson(result);
    } catch (e) {
      debugPrint("Hotel detail fetch error: $e");
    }

    isLoading = false;
    notifyListeners();
  }
}
