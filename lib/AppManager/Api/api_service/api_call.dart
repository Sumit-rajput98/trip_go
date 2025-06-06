import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:trip_go/AppManager/Api/api_service/api_constant.dart';
import 'package:http/http.dart' as http;

enum ApiType { get, post }

class ApiCallType {
  Map? body;
  Map<String, String> header;
  ApiType apiType;

  ApiCallType.get({this.header = const {}})
    : apiType = ApiType.get,
      body = null;

  ApiCallType.post({required this.body, this.header = const {}})
    : apiType = ApiType.post;
}

class ApiCall {
  Future<dynamic> call({
    required String url,
    required ApiCallType apiCallType,
    bool token = false,
  }) async {
    String myUrl = ApiConstant.baseUrl + url;
    Map? body = apiCallType.body;
    Map<String, String> header = apiCallType.header;
    if (kDebugMode) {
      print("Type: ${apiCallType.apiType.name}");
      print("Header: $header");
      print("URL: $myUrl");
      print("BODY: $body");
    }

    http.Response? response;
    try {
      switch (apiCallType.apiType) {
        case ApiType.get:
          response = await http.get(Uri.parse(myUrl), headers: header);
          break;
        case ApiType.post:
          response = await http.post(
            Uri.parse(myUrl),
            body: jsonEncode(body),
            headers: header,
          );
          break;
        default:
          break;
      }
      if (response != null) {
        var data = json.decode(response.body);
        print(data);
        return data;
      }
    } catch (e) {
      rethrow;
    }
  }
}
