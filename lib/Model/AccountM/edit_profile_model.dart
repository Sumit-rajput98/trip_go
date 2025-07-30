// To parse this JSON data, do
//
//     final editProfileModel = editProfileModelFromJson(jsonString);

import 'dart:convert';

EditProfileModel editProfileModelFromJson(String str) => EditProfileModel.fromJson(json.decode(str));

String editProfileModelToJson(EditProfileModel data) => json.encode(data.toJson());

class EditProfileModel {
    final bool? success;
    final String? message;
    final Data? data;

    EditProfileModel({
        this.success,
        this.message,
        this.data,
    });

    factory EditProfileModel.fromJson(Map<String, dynamic> json) => EditProfileModel(
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
    final int? id;
    final String? title;
    final String? firstName;
    final dynamic lastName;
    final String? email;
    final String? phone;
    final int? mobileVerifyStatus;
    final int? emailVerifyStatus;
    final dynamic country;
    final dynamic state;
    final dynamic city;
    final dynamic address;
    final dynamic zip;
    final dynamic profileImg;
    final dynamic gender;
    final dynamic dob;
    final int? status;

    Data({
        this.id,
        this.title,
        this.firstName,
        this.lastName,
        this.email,
        this.phone,
        this.mobileVerifyStatus,
        this.emailVerifyStatus,
        this.country,
        this.state,
        this.city,
        this.address,
        this.zip,
        this.profileImg,
        this.gender,
        this.dob,
        this.status,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["Id"],
        title: json["Title"],
        firstName: json["FirstName"],
        lastName: json["LastName"],
        email: json["Email"],
        phone: json["Phone"],
        mobileVerifyStatus: json["MobileVerifyStatus"],
        emailVerifyStatus: json["EmailVerifyStatus"],
        country: json["Country"],
        state: json["State"],
        city: json["City"],
        address: json["Address"],
        zip: json["Zip"],
        profileImg: json["ProfileImg"],
        gender: json["Gender"],
        dob: json["DOB"],
        status: json["Status"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "Title": title,
        "FirstName": firstName,
        "LastName": lastName,
        "Email": email,
        "Phone": phone,
        "MobileVerifyStatus": mobileVerifyStatus,
        "EmailVerifyStatus": emailVerifyStatus,
        "Country": country,
        "State": state,
        "City": city,
        "Address": address,
        "Zip": zip,
        "ProfileImg": profileImg,
        "Gender": gender,
        "DOB": dob,
        "Status": status,
    };
}
