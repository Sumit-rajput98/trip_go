/*class SearchCityModel{
  final bool success;
  final String message;
  final int id;
  final String airportCode;
  final String airportName;
  final String? cityCode;
  final String? cityName;
  final String? countryName;
  final String? countryCode;
  final int? topCities;
  final dynamic markupFee;
  final dynamic markupType;
  final int? noOfAirport;
  final String? airportCity;
  SearchCityModel({required this.success, required this.message,
    required this.id,
    required this.airportCode,
    required this.airportName,
    required this.cityCode,
    required this.cityName,
    required this.countryName,
    required this.countryCode,
    required this.topCities,
    required this.markupFee,
    required this.markupType,
    required this.noOfAirport,
    required this.airportCity,
});
  factory SearchCityModel.fromJson(Map<String, dynamic> json) => SearchCityModel(
    success: json["success"],
    message: json["message"],
    id: json["data"]["id"],
    airportCode: json["data"]["AIRPORTCODE"],
    airportName: json["data"]["AIRPORTNAME"],
    cityCode: json["data"]["CITYCODE"],
    cityName: json["data"]["CITYNAME"],
    countryName: json["data"]["COUNTRYNAME"],
    countryCode: json["data"]["COUNTRYCODE"],
    topCities: json["data"]["TOPCITIES"],
    markupFee: json["data"]["MARKUPFEE"],
    markupType: json["data"]["MARKUPTYPE"],
    noOfAirport: json["data"]["NOOFAIRPORT"],
    airportCity: json["data"]["AIRPORTCITY"],
  );
}*/
import 'dart:convert';

SearchCityModel searchCityModelFromJson(String str) => SearchCityModel.fromJson(json.decode(str));

String searchCityModelToJson(SearchCityModel data) => json.encode(data.toJson());

class SearchCityModel {
  final bool success;
  final String message;
  final List<Datum> data;

  SearchCityModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory SearchCityModel.fromJson(Map<String, dynamic> json) => SearchCityModel(
    success: json["success"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  final int id;
  final String airportcode;
  final String airportname;
  final String? citycode;
  final String? cityname;
  final String? countryname;
  final String? countrycode;
  final int? topcities;
  final dynamic markupfee;
  final dynamic markuptype;
  final int? noofairport;
  final String? airportcity;

  Datum({
    required this.id,
    required this.airportcode,
    required this.airportname,
    required this.citycode,
    required this.cityname,
    required this.countryname,
    required this.countrycode,
    required this.topcities,
    required this.markupfee,
    required this.markuptype,
    required this.noofairport,
    required this.airportcity,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    airportcode: json["AIRPORTCODE"],
    airportname: json["AIRPORTNAME"],
    citycode: json["CITYCODE"],
    cityname: json["CITYNAME"],
    countryname: json["COUNTRYNAME"],
    countrycode: json["COUNTRYCODE"],
    topcities: json["TOPCITIES"],
    markupfee: json["MARKUPFEE"],
    markuptype: json["MARKUPTYPE"],
    noofairport: json["NOOFAIRPORT"],
    airportcity: json["AIRPORTCITY"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "AIRPORTCODE": airportcode,
    "AIRPORTNAME": airportname,
    "CITYCODE": citycode,
    "CITYNAME": cityname,
    "COUNTRYNAME": countryname,
    "COUNTRYCODE": countrycode,
    "TOPCITIES": topcities,
    "MARKUPFEE": markupfee,
    "MARKUPTYPE": markuptype,
    "NOOFAIRPORT": noofairport,
    "AIRPORTCITY": airportcity,
  };
}
