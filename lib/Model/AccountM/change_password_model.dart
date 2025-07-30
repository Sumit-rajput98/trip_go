
import 'dart:convert';

ChangePasswordModel changePasswordModelFromJson(String str) => ChangePasswordModel.fromJson(json.decode(str));

String changePasswordModelToJson(ChangePasswordModel data) => json.encode(data.toJson());

class ChangePasswordModel {
    final bool? success;
    final String? message;
    final List<dynamic>? data;

    ChangePasswordModel({
        this.success,
        this.message,
        this.data,
    });

    factory ChangePasswordModel.fromJson(Map<String, dynamic> json) => ChangePasswordModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? [] : List<dynamic>.from(json["data"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
    };
}
