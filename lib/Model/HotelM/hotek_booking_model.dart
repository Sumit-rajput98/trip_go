// To parse this JSON data, do
//
//     final hotelBookingModel = hotelBookingModelFromJson(jsonString);

import 'dart:convert';

HotelBookingModel hotelBookingModelFromJson(String str) => HotelBookingModel.fromJson(json.decode(str));

String hotelBookingModelToJson(HotelBookingModel data) => json.encode(data.toJson());

double parseToDouble(dynamic value) {
    if (value == null) return 0.0;
    return double.tryParse(value.toString()) ?? 0.0;
}

class HotelBookingModel {
    final bool? success;
    final String? message;
    final Data? data;

    HotelBookingModel({
        this.success,
        this.message,
        this.data,
    });

    factory HotelBookingModel.fromJson(Map<String, dynamic> json) => HotelBookingModel(
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
    final String? hid;
    // final DateTime? checkin;
    // final DateTime? checkout;
    // final String? pax;
    // final String? rooms;
    final List<RoomElement>? dataRooms;
    final Detail? detail;
    final Status? status;
    final List<HotelResult>? hotelResult;
    final ValidationInfo? validationInfo;

    Data({
        this.hid,
        // this.checkin,
        // this.checkout,
        // this.pax,
        // this.rooms,
        this.dataRooms,
        this.detail,
        this.status,
        this.hotelResult,
        this.validationInfo,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        hid: json["hid"],
        // checkin: json["checkin"] == null ? null : DateTime.parse(json["checkin"]),
        // checkout: json["checkout"] == null ? null : DateTime.parse(json["checkout"]),
        // pax: json["pax"],
        // rooms: json["Rooms"],
        dataRooms: json["rooms"] == null ? [] : List<RoomElement>.from(json["rooms"]!.map((x) => RoomElement.fromJson(x))),
        detail: json["HotelDetail"] == null ? null : Detail.fromJson(json["HotelDetail"]),
        status: json["Status"] == null ? null : Status.fromJson(json["Status"]),
        hotelResult: json["HotelResult"] == null ? [] : List<HotelResult>.from(json["HotelResult"]!.map((x) => HotelResult.fromJson(x))),
        validationInfo: json["ValidationInfo"] == null ? null : ValidationInfo.fromJson(json["ValidationInfo"]),
    );

    Map<String, dynamic> toJson() => {
        "hid": hid,
        // "checkin": "${checkin!.year.toString().padLeft(4, '0')}-${checkin!.month.toString().padLeft(2, '0')}-${checkin!.day.toString().padLeft(2, '0')}",
        // "checkout": "${checkout!.year.toString().padLeft(4, '0')}-${checkout!.month.toString().padLeft(2, '0')}-${checkout!.day.toString().padLeft(2, '0')}",
        // "pax": pax,
        // "Rooms": rooms,
        "rooms": dataRooms == null ? [] : List<dynamic>.from(dataRooms!.map((x) => x.toJson())),
        "detail": detail?.toJson(),
        "Status": status?.toJson(),
        "HotelResult": hotelResult == null ? [] : List<dynamic>.from(hotelResult!.map((x) => x.toJson())),
        "ValidationInfo": validationInfo?.toJson(),
    };
}

class RoomElement {
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

    RoomElement({
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
    });

    factory RoomElement.fromJson(Map<String, dynamic> json) => RoomElement(
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
    );

    Map<String, dynamic> toJson() => {
        "Name": name == null ? [] : List<dynamic>.from(name!.map((x) => x)),
        "BookingCode": bookingCode,
        "Inclusion": inclusion,
        "DayRates": dayRates == null ? [] : List<dynamic>.from(dayRates!.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
        "TotalFare": totalFare,
        "TotalTax": totalTax,
        "RoomPromotion": roomPromotion == null ? [] : List<dynamic>.from(roomPromotion!.map((x) => x)),
        "CancelPolicies": cancelPolicies == null ? [] : List<dynamic>.from(cancelPolicies!.map((x) => x.toJson())),
        "MealType": mealType,
        "IsRefundable": isRefundable,
        "WithTransfers": withTransfers,
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

class Detail {
    final int? id;
    final String? hotelCode;
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
    final List<String>? ameneties;
    final dynamic isTopHotel;
    final dynamic attributes;
    final String? phone;
    final String? fax;
    final String? attractions;

    Detail({
        this.id,
        this.hotelCode,
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

    factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        id: json["id"],
        hotelCode: json["hotel_code"],
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
        ameneties: json["ameneties"] == null ? [] : List<String>.from(json["ameneties"]!.map((x) => x)),
        isTopHotel: json["isTopHotel"],
        attributes: json["attributes"],
        phone: json["phone"],
        fax: json["fax"],
        attractions: json["attractions"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "hotel_code": hotelCode,
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
        "ameneties": ameneties == null ? [] : List<dynamic>.from(ameneties!.map((x) => x)),
        "isTopHotel": isTopHotel,
        "attributes": attributes,
        "phone": phone,
        "fax": fax,
        "attractions": attractions,
    };
}

class HotelResult {
    final String? hotelCode;
    final String? currency;
    final List<Room>? rooms;
    final List<String>? rateConditions;

    HotelResult({
        this.hotelCode,
        this.currency,
        this.rooms,
        this.rateConditions,
    });

    factory HotelResult.fromJson(Map<String, dynamic> json) => HotelResult(
        hotelCode: json["HotelCode"],
        currency: json["Currency"],
        rooms: json["Rooms"] == null ? [] : List<Room>.from(json["Rooms"]!.map((x) => Room.fromJson(x))),
        rateConditions: json["RateConditions"] == null ? [] : List<String>.from(json["RateConditions"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "HotelCode": hotelCode,
        "Currency": currency,
        "Rooms": rooms == null ? [] : List<dynamic>.from(rooms!.map((x) => x.toJson())),
        "RateConditions": rateConditions == null ? [] : List<dynamic>.from(rateConditions!.map((x) => x)),
    };
}

class Room {
    final List<String>? name;
    final String? bookingCode;
    final String? inclusion;
    final List<List<DayRate>>? dayRates;
    final double? totalFare;
    final double? totalTax;
    final double? netAmount;
    final double? netTax;
    final List<String>? roomPromotion;
    final List<CancelPolicy>? cancelPolicies;
    final String? mealType;
    final bool? isRefundable;
    final bool? withTransfers;
    final List<String>? amenities;
    final String? lastCancellationDeadline;
    final List<PriceBreakUp>? priceBreakUp;

    Room({
        this.name,
        this.bookingCode,
        this.inclusion,
        this.dayRates,
        this.totalFare,
        this.totalTax,
        this.netAmount,
        this.netTax,
        this.roomPromotion,
        this.cancelPolicies,
        this.mealType,
        this.isRefundable,
        this.withTransfers,
        this.amenities,
        this.lastCancellationDeadline,
        this.priceBreakUp,
    });

    factory Room.fromJson(Map<String, dynamic> json) => Room(
        name: json["Name"] == null ? [] : List<String>.from(json["Name"]!.map((x) => x)),
        bookingCode: json["BookingCode"],
        inclusion: json["Inclusion"],
        dayRates: json["DayRates"] == null ? [] : List<List<DayRate>>.from(json["DayRates"]!.map((x) => List<DayRate>.from(x.map((x) => DayRate.fromJson(x))))),
        totalFare: json["TotalFare"]?.toDouble(),
        totalTax: json["TotalTax"]?.toDouble(),
        netAmount: json["NetAmount"]?.toDouble(),
        netTax: json["NetTax"]?.toDouble(),
        roomPromotion: json["RoomPromotion"] == null ? [] : List<String>.from(json["RoomPromotion"]!.map((x) => x)),
        cancelPolicies: json["CancelPolicies"] == null ? [] : List<CancelPolicy>.from(json["CancelPolicies"]!.map((x) => CancelPolicy.fromJson(x))),
        mealType: json["MealType"],
        isRefundable: json["IsRefundable"],
        withTransfers: json["WithTransfers"],
        amenities: json["Amenities"] == null ? [] : List<String>.from(json["Amenities"]!.map((x) => x)),
        lastCancellationDeadline: json["LastCancellationDeadline"],
        priceBreakUp: json["PriceBreakUp"] == null ? [] : List<PriceBreakUp>.from(json["PriceBreakUp"]!.map((x) => PriceBreakUp.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Name": name == null ? [] : List<dynamic>.from(name!.map((x) => x)),
        "BookingCode": bookingCode,
        "Inclusion": inclusion,
        "DayRates": dayRates == null ? [] : List<dynamic>.from(dayRates!.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
        "TotalFare": totalFare,
        "TotalTax": totalTax,
        "NetAmount": netAmount,
        "NetTax": netTax,
        "RoomPromotion": roomPromotion == null ? [] : List<dynamic>.from(roomPromotion!.map((x) => x)),
        "CancelPolicies": cancelPolicies == null ? [] : List<dynamic>.from(cancelPolicies!.map((x) => x.toJson())),
        "MealType": mealType,
        "IsRefundable": isRefundable,
        "WithTransfers": withTransfers,
        "Amenities": amenities == null ? [] : List<dynamic>.from(amenities!.map((x) => x)),
        "LastCancellationDeadline": lastCancellationDeadline,
        "PriceBreakUp": priceBreakUp == null ? [] : List<dynamic>.from(priceBreakUp!.map((x) => x.toJson())),
    };
}

class PriceBreakUp {
    final double? roomRate;
    final double? roomTax;

    PriceBreakUp({
        this.roomRate,
        this.roomTax,
    });

    factory PriceBreakUp.fromJson(Map<String, dynamic> json) => PriceBreakUp(
        roomRate: json["RoomRate"]?.toDouble(),
        roomTax: json["RoomTax"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "RoomRate": roomRate,
        "RoomTax": roomTax,
    };
}

class Status {
    final int? code;
    final String? description;

    Status({
        this.code,
        this.description,
    });

    factory Status.fromJson(Map<String, dynamic> json) => Status(
        code: json["Code"],
        description: json["Description"],
    );

    Map<String, dynamic> toJson() => {
        "Code": code,
        "Description": description,
    };
}

class ValidationInfo {
    final bool? panMandatory;
    final bool? passportMandatory;
    final bool? corporateBookingAllowed;
    final int? panCountRequired;
    final bool? samePaxNameAllowed;
    final bool? spaceAllowed;
    final bool? specialCharAllowed;
    final int? paxNameMinLength;
    final int? paxNameMaxLength;
    final bool? charLimit;
    final bool? packageFare;
    final bool? packageDetailsMandatory;
    final bool? departureDetailsMandatory;
    final bool? gstAllowed;

    ValidationInfo({
        this.panMandatory,
        this.passportMandatory,
        this.corporateBookingAllowed,
        this.panCountRequired,
        this.samePaxNameAllowed,
        this.spaceAllowed,
        this.specialCharAllowed,
        this.paxNameMinLength,
        this.paxNameMaxLength,
        this.charLimit,
        this.packageFare,
        this.packageDetailsMandatory,
        this.departureDetailsMandatory,
        this.gstAllowed,
    });

    factory ValidationInfo.fromJson(Map<String, dynamic> json) => ValidationInfo(
        panMandatory: json["PanMandatory"],
        passportMandatory: json["PassportMandatory"],
        corporateBookingAllowed: json["CorporateBookingAllowed"],
        panCountRequired: json["PanCountRequired"],
        samePaxNameAllowed: json["SamePaxNameAllowed"],
        spaceAllowed: json["SpaceAllowed"],
        specialCharAllowed: json["SpecialCharAllowed"],
        paxNameMinLength: json["PaxNameMinLength"],
        paxNameMaxLength: json["PaxNameMaxLength"],
        charLimit: json["CharLimit"],
        packageFare: json["PackageFare"],
        packageDetailsMandatory: json["PackageDetailsMandatory"],
        departureDetailsMandatory: json["DepartureDetailsMandatory"],
        gstAllowed: json["GSTAllowed"],
    );

    Map<String, dynamic> toJson() => {
        "PanMandatory": panMandatory,
        "PassportMandatory": passportMandatory,
        "CorporateBookingAllowed": corporateBookingAllowed,
        "PanCountRequired": panCountRequired,
        "SamePaxNameAllowed": samePaxNameAllowed,
        "SpaceAllowed": spaceAllowed,
        "SpecialCharAllowed": specialCharAllowed,
        "PaxNameMinLength": paxNameMinLength,
        "PaxNameMaxLength": paxNameMaxLength,
        "CharLimit": charLimit,
        "PackageFare": packageFare,
        "PackageDetailsMandatory": packageDetailsMandatory,
        "DepartureDetailsMandatory": departureDetailsMandatory,
        "GSTAllowed": gstAllowed,
    };
}
