// To parse this JSON data, do
//
//     final exclusiveOffersModel = exclusiveOffersModelFromJson(jsonString);

import 'dart:convert';

ExclusiveOffersModel exclusiveOffersModelFromJson(String str) => ExclusiveOffersModel.fromJson(json.decode(str));

String exclusiveOffersModelToJson(ExclusiveOffersModel data) => json.encode(data.toJson());

class ExclusiveOffersModel {
    final bool? success;
    final String? message;
    final List<Datum>? data;

    ExclusiveOffersModel({
        this.success,
        this.message,
        this.data,
    });

    factory ExclusiveOffersModel.fromJson(Map<String, dynamic> json) => ExclusiveOffersModel(
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
    final int? id;
    final String? name;
    final String? image;
    final String? price;
    final String? url;
    final String? offerType;
    final String? type;
    final String? description;

    Datum({
        this.id,
        this.name,
        this.image,
        this.price,
        this.url,
        this.offerType,
        this.type,
        this.description,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        price: json["price"],
        url: json["url"],
        offerType: json["offer_type"],
        type: json["type"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "price": price,
        "url": url,
        "offer_type": offerType,
        "type": type,
        "description": description,
    };
}
