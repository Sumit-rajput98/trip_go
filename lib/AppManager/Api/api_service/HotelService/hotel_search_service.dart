import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:trip_go/AppManager/Api/api_service/api_call.dart';
import 'package:trip_go/Model/HotelM/hotel_search_model.dart';

class HotelSearchService{

  Future<HotelSearchModel> searchHotels(dynamic request) async {
    final String url = "api/Hotel/Search";
    final response = await ApiCall().call(url: url, apiCallType: ApiCallType.post(body:request,header: {"Content-Type": "application/json"}));
    if (response!=null) {
      return HotelSearchModel.fromJson(response);
    } else {
      // Optional: Print error response for debugging
      print('Error Response: ${response.body}');
      throw Exception('Failed to load flight search data');
    }
  }
}
