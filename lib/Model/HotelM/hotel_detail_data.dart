import 'dart:convert';
import 'hotel_search_model.dart';

// Root Response Model
class HotelDetailResponse {
  final bool? success;
  final String? message;
  final HotelDetailData? data;

  HotelDetailResponse({this.success, this.message, this.data});

  factory HotelDetailResponse.fromJson(Map<String, dynamic> json) => HotelDetailResponse(
    success: json['success'],
    message: json['message'],
    data: json['data'] != null ? HotelDetailData.fromJson(json['data']) : null,
  );
}

// Main Data Block
class HotelDetailData {
  final List<RoomDetail>? rooms;
  final Hotel1? detail;
  final String? hid;
  // final String? checkin;
  // final String? checkout;
  // final String? pax;
  // final String? roomsCount;

  HotelDetailData({
    this.rooms,
    this.detail,
    this.hid,
    // this.checkin,
    // this.checkout,
    // this.pax,
    // this.roomsCount,
  });

  factory HotelDetailData.fromJson(Map<String, dynamic> json) => HotelDetailData(
    rooms: json['rooms'] != null
        ? List<RoomDetail>.from(json['rooms'].map((x) => RoomDetail.fromJson(x)))
        : [],
    detail: json['HotelDetail'] != null ? Hotel1.fromJson(json['HotelDetail']) : null,
    hid: json['hid'],
    // checkin: json['checkin'],
    // checkout: json['checkout'],
    // pax: json['pax'],
    // roomsCount: json['Rooms'],
  );
}

// Room Detail Model
class RoomDetail {
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

  RoomDetail({
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

  factory RoomDetail.fromJson(Map<String, dynamic> json) => RoomDetail(
    name: json['Name'] != null ? List<String>.from(json['Name']) : [],
    bookingCode: json['BookingCode'],
    inclusion: json['Inclusion'],
    dayRates: json['DayRates'] != null
        ? List<List<DayRate>>.from(json['DayRates'].map(
            (list) => List<DayRate>.from(list.map((x) => DayRate.fromJson(x)))))
        : [],
    totalFare: (json['TotalFare'] as num?)?.toDouble(),
    totalTax: (json['TotalTax'] as num?)?.toDouble(),
    roomPromotion: json['RoomPromotion'] != null
        ? List<String>.from(json['RoomPromotion'])
        : [],
    cancelPolicies: json['CancelPolicies'] != null
        ? List<CancelPolicy>.from(json['CancelPolicies'].map((x) => CancelPolicy.fromJson(x)))
        : [],
    mealType: json['MealType'],
    isRefundable: json['IsRefundable'],
    withTransfers: json['WithTransfers'],
  );

  Map<String, dynamic> toJson() {
  return {
    'Name': name,
    'BookingCode': bookingCode,
    'Inclusion': inclusion,
    'DayRates': dayRates?.map((list) => list.map((rate) => rate.toJson()).toList()).toList(),
    'TotalFare': totalFare,
    'TotalTax': totalTax,
    'RoomPromotion': roomPromotion,
    'CancelPolicies': cancelPolicies?.map((policy) => policy.toJson()).toList(),
    'MealType': mealType,
    'IsRefundable': isRefundable,
    'WithTransfers': withTransfers,
  };
}

}

// Day Rate
class DayRate {
  final double? basePrice;

  DayRate({this.basePrice});

  factory DayRate.fromJson(Map<String, dynamic> json) => DayRate(
    basePrice: (json['BasePrice'] as num?)?.toDouble(),
  );
   Map<String, dynamic> toJson() {
    return {
      'BasePrice': basePrice
    }
    ;
   }
}

// Cancel Policy
class CancelPolicy {
  final String? fromDate;
  final String? chargeType;
  final double? cancellationCharge;

  CancelPolicy({this.fromDate, this.chargeType, this.cancellationCharge});

  factory CancelPolicy.fromJson(Map<String, dynamic> json) => CancelPolicy(
    fromDate: json['FromDate'],
    chargeType: json['ChargeType'],
    cancellationCharge: (json['CancellationCharge'] as num?)?.toDouble(),
  );
  Map<String, dynamic> toJson() {
    return {
      'FromDate': fromDate,
      'ChargeType': chargeType,
      'CancellationCharge': cancellationCharge
    }
    ;
   }
}

// Hotel Detail (Hotel1)
class Hotel1 {
  final int? id;
  final String? hotelCode;
  final String? cityCode;
  final String? name;
  final String? description;
  final String? latitude;
  final String? longitude;
  final String? address;
  final String? city;
  final String? zip;
  final String? country;
  final String? tripadvisor;
  final String? starRating;
  final String? hotelCategory;
  final String? categoryName;
  final String? createdAt;
  final String? updatedAt;
  final String? stateCode;
  final String? images;
  final String? chainId;
  final List<String>? ameneties;
  final bool? isTopHotel;
  final String? attributes;
  final String? phone;
  final String? fax;
  final String? attractions;

  Hotel1({
    this.id,
    this.hotelCode,
    this.cityCode,
    this.name,
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

  factory Hotel1.fromJson(Map<String, dynamic> json) => Hotel1(
    id: json['id'],
    hotelCode: json['hotel_code'],
    cityCode: json['city_code'],
    name: json['name'],
    description: json['description'],
    latitude: json['latitude'],
    longitude: json['longitude'],
    address: json['address'],
    city: json['city'],
    zip: json['zip'],
    country: json['country'],
    tripadvisor: json['tripadvisor'],
    starRating: json['star_rating'],
    hotelCategory: json['hotel_category'],
    categoryName: json['category_name'],
    createdAt: json['created_at'],
    updatedAt: json['updated_at'],
    stateCode: json['state_code'],
    images: json['images'],
    chainId: json['chainId'],
    ameneties: json['ameneties'] != null
        ? List<String>.from(json['ameneties'])
        : [],
    isTopHotel: json['isTopHotel'],
    attributes: json['attributes'],
    phone: json['phone'],
    fax: json['fax'],
    attractions: json['attractions'],
  );
}


// Reuse your Room, CancelPolicy, DayRate classes here (you already defined them earlier).
