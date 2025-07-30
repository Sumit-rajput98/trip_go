// To parse this JSON data, do
//
//     final loginOtpModel = loginOtpModelFromJson(jsonString);

import 'dart:convert';

LoginOtpModel loginOtpModelFromJson(String str) => LoginOtpModel.fromJson(json.decode(str));

String loginOtpModelToJson(LoginOtpModel data) => json.encode(data.toJson());

class LoginOtpModel {
    final bool? success;
    final String? message;
    final Data? data;

    LoginOtpModel({
        this.success,
        this.message,
        this.data,
    });

    factory LoginOtpModel.fromJson(Map<String, dynamic> json) => LoginOtpModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
    final String? token;

    Data({
        this.token,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "token": token,
    };
}
