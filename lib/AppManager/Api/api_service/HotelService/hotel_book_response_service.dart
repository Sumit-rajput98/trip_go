import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:trip_go/AppManager/Api/api_service/api_call.dart';
import 'package:trip_go/Model/HotelM/book_response_model.dart';
import 'package:trip_go/Model/HotelM/hotek_booking_model.dart';

class HotelBookResponseService {
  Future<BookResponseModel> bookHotels(dynamic request) async {
    final String url = "api/Hotel/Book";
    final response = await ApiCall().call(
      url: url,
      apiCallType: ApiCallType.post(
        body: request,
        header: {"Content-Type": "application/json"}
      )
    );

    if (response == null) {
      throw Exception('No response from server');
    }

    // Check if API response indicates failure
    if (response is Map<String, dynamic> && 
        response['success'] == false) {
      throw Exception(response['message'] ?? 'Unknown booking error');
    }

    try {
      return BookResponseModel.fromJson(response);
    } catch (e) {
      throw Exception('Failed to parse response: ${e.toString()}');
    }
  }
}