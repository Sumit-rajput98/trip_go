import 'dart:convert';

HotelCitySearchModel hotelCitySearchModelFromJson(String str) => HotelCitySearchModel.fromJson(json.decode(str));

String hotelCitySearchModelToJson(HotelCitySearchModel data) => json.encode(data.toJson());

class HotelCitySearchModel {
    final bool? success;
    final String? message;
    final List<Datum>? data;

    HotelCitySearchModel({
        this.success,
        this.message,
        this.data,
    });

    factory HotelCitySearchModel.fromJson(Map<String, dynamic> json) => HotelCitySearchModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    final String? cityName;
    final String? countryCode;
    final String? countryName;
    final int? id;

    Datum({
        this.cityName,
        this.countryCode,
        this.countryName,
        this.id,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        cityName: json["CityName"],
        countryCode: json["CountryCode"],
        countryName: json["CountryName"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "CityName": cityName,
        "CountryCode": countryCode,
        "CountryName": countryName,
        "id": id,
    };
}
