// To parse this JSON data, do
//
//     final hotelSearchModel = hotelSearchModelFromJson(jsonString);

import 'dart:convert';

HotelSearchModel hotelSearchModelFromJson(String str) => HotelSearchModel.fromJson(json.decode(str));

String hotelSearchModelToJson(HotelSearchModel data) => json.encode(data.toJson());

class HotelSearchModel {
    final bool? success;
    final String? message;
    final Data? data;

    HotelSearchModel({
        this.success,
        this.message,
        this.data,
    });

    factory HotelSearchModel.fromJson(Map<String, dynamic> json) => HotelSearchModel(
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
    final String? city;
    final String? cityId;
    final List<RoomElement>? rooms;
    final String? searchId;
    final String? batchKey;
    final List<Hotel0>? hotels;

    Data({
        this.city,
        this.cityId,
        this.rooms,
        this.searchId,
        this.batchKey,
        this.hotels,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        city: json["city"],
        cityId: json["cityID"],
        rooms: json["rooms"] == null ? [] : List<RoomElement>.from(json["rooms"]!.map((x) => RoomElement.fromJson(x))),
        searchId: json["searchId"],
        batchKey: json["batchKey"],
        hotels: json["hotels"] == null ? [] : List<Hotel0>.from(json["hotels"]!.map((x) => Hotel0.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "city": city,
        "cityID": cityId,
        "rooms": rooms == null ? [] : List<dynamic>.from(rooms!.map((x) => x.toJson())),
        "searchId": searchId,
        "batchKey": batchKey,
        "hotels": hotels == null ? [] : List<dynamic>.from(hotels!.map((x) => x.toJson())),
    };
}

class Hotel0 {
    final String? hotelCode;
    final String? currency;
    final List<Room1>? rooms;
    final int? id;
    final String? hotelHotelCode;
    final String? cityCode;
    final String? name;
    final dynamic locationCategoryCode;
    final String? description;
    final String? latitude;
    final String? longitude;
    final String? address;
    final String? city;
    final String? zip;
    final String? country;
    final dynamic tripadvisor;
    final String? starRating;
    final dynamic hotelCategory;
    final dynamic categoryName;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final dynamic stateCode;
    final dynamic images;
    final dynamic chainId;
    final String? ameneties;
    final dynamic isTopHotel;
    final dynamic attributes;
    final String? phone;
    final String? fax;
    final String? attractions;

    Hotel0({
        this.hotelCode,
        this.currency,
        this.rooms,
        this.id,
        this.hotelHotelCode,
        this.cityCode,
        this.name,
        this.locationCategoryCode,
        this.description,
        this.latitude,
        this.longitude,
        this.address,
        this.city,
        this.zip,
        this.country,
        this.tripadvisor,
        this.starRating,
        this.hotelCategory,
        this.categoryName,
        this.createdAt,
        this.updatedAt,
        this.stateCode,
        this.images,
        this.chainId,
        this.ameneties,
        this.isTopHotel,
        this.attributes,
        this.phone,
        this.fax,
        this.attractions,
    });

    factory Hotel0.fromJson(Map<String, dynamic> json) => Hotel0(
        hotelCode: json["HotelCode"],
        currency: json["Currency"],
        rooms: json["Rooms"] == null ? [] : List<Room1>.from(json["Rooms"]!.map((x) => Room1.fromJson(x))),
        id: json["id"],
        hotelHotelCode: json["hotel_code"],
        cityCode: json["city_code"],
        name: json["name"],
        locationCategoryCode: json["LocationCategoryCode"],
        description: json["description"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        address: json["address"],
        city: json["city"],
        zip: json["zip"],
        country: json["country"],
        tripadvisor: json["tripadvisor"],
        starRating: json["star_rating"],
        hotelCategory: json["hotel_category"],
        categoryName: json["category_name"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        stateCode: json["state_code"],
        images: json["images"],
        chainId: json["chainId"],
        ameneties: json["ameneties"],
        isTopHotel: json["isTopHotel"],
        attributes: json["attributes"],
        phone: json["phone"],
        fax: json["fax"],
        attractions: json["attractions"],
    );

    Map<String, dynamic> toJson() => {
        "HotelCode": hotelCode,
        "Currency": currency,
        "Rooms": rooms == null ? [] : List<dynamic>.from(rooms!.map((x) => x.toJson())),
        "id": id,
        "hotel_code": hotelHotelCode,
        "city_code": cityCode,
        "name": name,
        "LocationCategoryCode": locationCategoryCode,
        "description": description,
        "latitude": latitude,
        "longitude": longitude,
        "address": address,
        "city": city,
        "zip": zip,
        "country": country,
        "tripadvisor": tripadvisor,
        "star_rating": starRating,
        "hotel_category": hotelCategory,
        "category_name": categoryName,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "state_code": stateCode,
        "images": images,
        "chainId": chainId,
        "ameneties": ameneties,
        "isTopHotel": isTopHotel,
        "attributes": attributes,
        "phone": phone,
        "fax": fax,
        "attractions": attractions,
    };
}

class Room1 {
    final List<String>? name;
    final String? bookingCode;
    final String? inclusion;
    final List<List<DayRate>>? dayRates;
    final double? totalFare;
    final double? totalTax;
    final List<String>? roomPromotion;
    final List<CancelPolicy>? cancelPolicies;
    final String? mealType;
    final bool? isRefundable;
    final bool? withTransfers;
    final String? beddingGroup;

    Room1({
        this.name,
        this.bookingCode,
        this.inclusion,
        this.dayRates,
        this.totalFare,
        this.totalTax,
        this.roomPromotion,
        this.cancelPolicies,
        this.mealType,
        this.isRefundable,
        this.withTransfers,
        this.beddingGroup,
    });

    factory Room1.fromJson(Map<String, dynamic> json) => Room1(
        name: json["Name"] == null ? [] : List<String>.from(json["Name"]!.map((x) => x)),
        bookingCode: json["BookingCode"],
        inclusion: json["Inclusion"],
        dayRates: json["DayRates"] == null ? [] : List<List<DayRate>>.from(json["DayRates"]!.map((x) => List<DayRate>.from(x.map((x) => DayRate.fromJson(x))))),
        totalFare: json["TotalFare"]?.toDouble(),
        totalTax: json["TotalTax"]?.toDouble(),
        roomPromotion: json["RoomPromotion"] == null ? [] : List<String>.from(json["RoomPromotion"]!.map((x) => x)),
        cancelPolicies: json["CancelPolicies"] == null ? [] : List<CancelPolicy>.from(json["CancelPolicies"]!.map((x) => CancelPolicy.fromJson(x))),
        mealType: json["MealType"],
        isRefundable: json["IsRefundable"],
        withTransfers: json["WithTransfers"],
        beddingGroup: json["BeddingGroup"],
    );

    Map<String, dynamic> toJson() => {
        "Name": name == null ? [] : List<dynamic>.from(name!.map((x) => x)),
        "BookingCode": bookingCode,
        "Inclusion": inclusion,
        "DayRates": dayRates == null ? [] : List<dynamic>.from(dayRates!.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
        "TotalFare": totalFare,
        "TotalTax": totalTax,
        "RoomPromotion": roomPromotion == null ? [] : List<dynamic>.from(roomPromotion!.map((x) => x)),
        "CancelPolicies": cancelPolicies == null
            ? []
            : List<dynamic>.from(cancelPolicies!.map((x) => x.toJson())),
        "MealType": mealType,
        "IsRefundable": isRefundable,
        "WithTransfers": withTransfers,
        "BeddingGroup": beddingGroup,
    };
}

class CancelPolicy {
    final String? fromDate;
    final String? chargeType;
    final double? cancellationCharge;

    CancelPolicy({
        this.fromDate,
        this.chargeType,
        this.cancellationCharge,
    });

    factory CancelPolicy.fromJson(Map<String, dynamic> json) => CancelPolicy(
        fromDate: json["FromDate"],
        chargeType: json["ChargeType"],
        cancellationCharge: json["CancellationCharge"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "FromDate": fromDate,
        "ChargeType": chargeType,
        "CancellationCharge": cancellationCharge,
    };
}

class DayRate {
    final double? basePrice;

    DayRate({
        this.basePrice,
    });

    factory DayRate.fromJson(Map<String, dynamic> json) => DayRate(
        basePrice: json["BasePrice"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "BasePrice": basePrice,
    };
}

class RoomElement {
    final int? adults;
    final int? children;
    final dynamic childrenAges;

    RoomElement({
        this.adults,
        this.children,
        this.childrenAges,
    });

    factory RoomElement.fromJson(Map<String, dynamic> json) => RoomElement(
        adults: json["adults"],
        children: json["children"],
        childrenAges: json["ChildrenAges"],
    );

    Map<String, dynamic> toJson() => {
        "adults": adults,
        "children": children,
        "ChildrenAges": childrenAges,
    };
}
