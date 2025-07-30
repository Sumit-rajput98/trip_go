// To parse this JSON data, do
//
//     final hotelBookingDetailModel = hotelBookingDetailModelFromJson(jsonString);

import 'dart:convert';

HotelBookingDetailModel hotelBookingDetailModelFromJson(String str) => HotelBookingDetailModel.fromJson(json.decode(str));

String hotelBookingDetailModelToJson(HotelBookingDetailModel data) => json.encode(data.toJson());

class HotelBookingDetailModel {
    final bool? success;
    final String? message;
    final Data? data;

    HotelBookingDetailModel({
        this.success,
        this.message,
        this.data,
    });

    factory HotelBookingDetailModel.fromJson(Map<String, dynamic> json) => HotelBookingDetailModel(
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

int? toInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
}

double? toDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
}

class Data {
    final GetBookingDetailResult? getBookingDetailResult;

    Data({
        this.getBookingDetailResult,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        getBookingDetailResult: json["GetBookingDetailResult"] == null ? null : GetBookingDetailResult.fromJson(json["GetBookingDetailResult"]),
    );

    Map<String, dynamic> toJson() => {
        "GetBookingDetailResult": getBookingDetailResult?.toJson(),
    };
}

class GetBookingDetailResult {
    final bool? voucherStatus;
    final int? responseStatus;
    final Error? error;
    final String? traceId;
    final int? status;
    final String? hotelBookingStatus;
    final String? confirmationNo;
    final String? bookingRefNo;
    final int? bookingId;
    final bool? isPriceChanged;
    final bool? isCancellationPolicyChanged;
    final List<HotelRoomsDetail>? hotelRoomsDetails;
    final String? agentRemarks;
    final List<BookingHistory>? bookingHistory;
    final String? bookingSource;
    final dynamic creditNoteGstin;
    final dynamic gstin;
    final String? guestNationality;
    final HotelItineraryTracking? hotelItineraryTracking;
    final String? hotelPolicyDetail;
    final dynamic intHotelPassportDetails;
    final int? invoiceAmount;
    final DateTime? invoiceCreatedOn;
    final String? invoiceNo;
    final bool? isCorporate;
    final List<dynamic>? validationInfo;
    final dynamic hotelConfirmationNo;
    final String? hotelCode;
    final int? hotelId;
    final String? hotelName;
    final String? tboHotelCode;
    final int? starRating;
    final String? addressLine1;
    final String? addressLine2;
    final String? countryCode;
    final String? latitude;
    final String? longitude;
    final String? city;
    final int? cityId;
    final DateTime? checkInDate;
    final DateTime? initialCheckInDate;
    final DateTime? checkOutDate;
    final DateTime? initialCheckOutDate;
    final DateTime? lastCancellationDate;
    final DateTime? lastVoucherDate;
    final int? noOfRooms;
    final DateTime? bookingDate;
    final String? specialRequest;
    final bool? isDomestic;
    final bool? bookingAllowedForRoamer;

    GetBookingDetailResult({
        this.voucherStatus,
        this.responseStatus,
        this.error,
        this.traceId,
        this.status,
        this.hotelBookingStatus,
        this.confirmationNo,
        this.bookingRefNo,
        this.bookingId,
        this.isPriceChanged,
        this.isCancellationPolicyChanged,
        this.hotelRoomsDetails,
        this.agentRemarks,
        this.bookingHistory,
        this.bookingSource,
        this.creditNoteGstin,
        this.gstin,
        this.guestNationality,
        this.hotelItineraryTracking,
        this.hotelPolicyDetail,
        this.intHotelPassportDetails,
        this.invoiceAmount,
        this.invoiceCreatedOn,
        this.invoiceNo,
        this.isCorporate,
        this.validationInfo,
        this.hotelConfirmationNo,
        this.hotelCode,
        this.hotelId,
        this.hotelName,
        this.tboHotelCode,
        this.starRating,
        this.addressLine1,
        this.addressLine2,
        this.countryCode,
        this.latitude,
        this.longitude,
        this.city,
        this.cityId,
        this.checkInDate,
        this.initialCheckInDate,
        this.checkOutDate,
        this.initialCheckOutDate,
        this.lastCancellationDate,
        this.lastVoucherDate,
        this.noOfRooms,
        this.bookingDate,
        this.specialRequest,
        this.isDomestic,
        this.bookingAllowedForRoamer,
    });

    factory GetBookingDetailResult.fromJson(Map<String, dynamic> json) => GetBookingDetailResult(
        voucherStatus: json["VoucherStatus"],
        responseStatus: toInt(json["ResponseStatus"]),
        error: json["Error"] == null ? null : Error.fromJson(json["Error"]),
        traceId: json["TraceId"],
        status: toInt(json["Status"]),
        hotelBookingStatus: json["HotelBookingStatus"],
        confirmationNo: json["ConfirmationNo"],
        bookingRefNo: json["BookingRefNo"],
        bookingId: toInt(json["BookingId"]),
        isPriceChanged: json["IsPriceChanged"],
        isCancellationPolicyChanged: json["IsCancellationPolicyChanged"],
        hotelRoomsDetails: json["HotelRoomsDetails"] == null ? [] : List<HotelRoomsDetail>.from(json["HotelRoomsDetails"]!.map((x) => HotelRoomsDetail.fromJson(x))),
        agentRemarks: json["AgentRemarks"],
        bookingHistory: json["BookingHistory"] == null ? [] : List<BookingHistory>.from(json["BookingHistory"]!.map((x) => BookingHistory.fromJson(x))),
        bookingSource: json["BookingSource"],
        creditNoteGstin: json["CreditNoteGSTIN"],
        gstin: json["GSTIN"],
        guestNationality: json["GuestNationality"],
        hotelItineraryTracking: json["HotelItineraryTracking"] == null ? null : HotelItineraryTracking.fromJson(json["HotelItineraryTracking"]),
        hotelPolicyDetail: json["HotelPolicyDetail"],
        intHotelPassportDetails: json["IntHotelPassportDetails"],
        invoiceAmount: toInt(json["InvoiceAmount"]),
        invoiceCreatedOn: json["InvoiceCreatedOn"] == null ? null : DateTime.parse(json["InvoiceCreatedOn"]),
        invoiceNo: json["InvoiceNo"],
        isCorporate: json["IsCorporate"],
        validationInfo: json["ValidationInfo"] == null ? [] : List<dynamic>.from(json["ValidationInfo"]!.map((x) => x)),
        hotelConfirmationNo: json["HotelConfirmationNo"],
        hotelCode: json["HotelCode"],
        hotelId: toInt(json["HotelId"]),
        hotelName: json["HotelName"],
        tboHotelCode: json["TBOHotelCode"],
        starRating: toInt(json["StarRating"]),
        addressLine1: json["AddressLine1"],
        addressLine2: json["AddressLine2"],
        countryCode: json["CountryCode"],
        latitude: json["Latitude"],
        longitude: json["Longitude"],
        city: json["City"],
        cityId: toInt(json["CityId"]),
        checkInDate: json["CheckInDate"] == null ? null : DateTime.parse(json["CheckInDate"]),
        initialCheckInDate: json["InitialCheckInDate"] == null ? null : DateTime.parse(json["InitialCheckInDate"]),
        checkOutDate: json["CheckOutDate"] == null ? null : DateTime.parse(json["CheckOutDate"]),
        initialCheckOutDate: json["InitialCheckOutDate"] == null ? null : DateTime.parse(json["InitialCheckOutDate"]),
        lastCancellationDate: json["LastCancellationDate"] == null ? null : DateTime.parse(json["LastCancellationDate"]),
        lastVoucherDate: json["LastVoucherDate"] == null ? null : DateTime.parse(json["LastVoucherDate"]),
        noOfRooms: toInt(json["NoOfRooms"]),
        bookingDate: json["BookingDate"] == null ? null : DateTime.parse(json["BookingDate"]),
        specialRequest: json["SpecialRequest"],
        isDomestic: json["IsDomestic"],
        bookingAllowedForRoamer: json["BookingAllowedForRoamer"],
    );

    Map<String, dynamic> toJson() => {
        "VoucherStatus": voucherStatus,
        "ResponseStatus": responseStatus,
        "Error": error?.toJson(),
        "TraceId": traceId,
        "Status": status,
        "HotelBookingStatus": hotelBookingStatus,
        "ConfirmationNo": confirmationNo,
        "BookingRefNo": bookingRefNo,
        "BookingId": bookingId,
        "IsPriceChanged": isPriceChanged,
        "IsCancellationPolicyChanged": isCancellationPolicyChanged,
        "HotelRoomsDetails": hotelRoomsDetails == null ? [] : List<dynamic>.from(hotelRoomsDetails!.map((x) => x.toJson())),
        "AgentRemarks": agentRemarks,
        "BookingHistory": bookingHistory == null ? [] : List<dynamic>.from(bookingHistory!.map((x) => x.toJson())),
        "BookingSource": bookingSource,
        "CreditNoteGSTIN": creditNoteGstin,
        "GSTIN": gstin,
        "GuestNationality": guestNationality,
        "HotelItineraryTracking": hotelItineraryTracking?.toJson(),
        "HotelPolicyDetail": hotelPolicyDetail,
        "IntHotelPassportDetails": intHotelPassportDetails,
        "InvoiceAmount": invoiceAmount,
        "InvoiceCreatedOn": invoiceCreatedOn?.toIso8601String(),
        "InvoiceNo": invoiceNo,
        "IsCorporate": isCorporate,
        "ValidationInfo": validationInfo == null ? [] : List<dynamic>.from(validationInfo!.map((x) => x)),
        "HotelConfirmationNo": hotelConfirmationNo,
        "HotelCode": hotelCode,
        "HotelId": hotelId,
        "HotelName": hotelName,
        "TBOHotelCode": tboHotelCode,
        "StarRating": starRating,
        "AddressLine1": addressLine1,
        "AddressLine2": addressLine2,
        "CountryCode": countryCode,
        "Latitude": latitude,
        "Longitude": longitude,
        "City": city,
        "CityId": cityId,
        "CheckInDate": checkInDate?.toIso8601String(),
        "InitialCheckInDate": initialCheckInDate?.toIso8601String(),
        "CheckOutDate": checkOutDate?.toIso8601String(),
        "InitialCheckOutDate": initialCheckOutDate?.toIso8601String(),
        "LastCancellationDate": lastCancellationDate?.toIso8601String(),
        "LastVoucherDate": lastVoucherDate?.toIso8601String(),
        "NoOfRooms": noOfRooms,
        "BookingDate": bookingDate?.toIso8601String(),
        "SpecialRequest": specialRequest,
        "IsDomestic": isDomestic,
        "BookingAllowedForRoamer": bookingAllowedForRoamer,
    };
}

class BookingHistory {
    final int? bookingId;
    final int? createdBy;
    final String? createdByName;
    final DateTime? createdOn;
    final int? eventCategory;
    final int? lastModifiedBy;
    final String? lastModifiedByName;
    final DateTime? lastModifiedOn;
    final String? remarks;

    BookingHistory({
        this.bookingId,
        this.createdBy,
        this.createdByName,
        this.createdOn,
        this.eventCategory,
        this.lastModifiedBy,
        this.lastModifiedByName,
        this.lastModifiedOn,
        this.remarks,
    });

    factory BookingHistory.fromJson(Map<String, dynamic> json) => BookingHistory(
        bookingId: toInt(json["BookingId"]),
        createdBy: toInt(json["CreatedBy"]),
        createdByName: json["CreatedByName"],
        createdOn: json["CreatedOn"] == null ? null : DateTime.parse(json["CreatedOn"]),
        eventCategory: toInt(json["EventCategory"]),
        lastModifiedBy: toInt(json["LastModifiedBy"]),
        lastModifiedByName: json["LastModifiedByName"],
        lastModifiedOn: json["LastModifiedOn"] == null ? null : DateTime.parse(json["LastModifiedOn"]),
        remarks: json["Remarks"],
    );

    Map<String, dynamic> toJson() => {
        "BookingId": bookingId,
        "CreatedBy": createdBy,
        "CreatedByName": createdByName,
        "CreatedOn": createdOn?.toIso8601String(),
        "EventCategory": eventCategory,
        "LastModifiedBy": lastModifiedBy,
        "LastModifiedByName": lastModifiedByName,
        "LastModifiedOn": lastModifiedOn?.toIso8601String(),
        "Remarks": remarks,
    };
}

class Error {
    final int? errorCode;
    final String? errorMessage;

    Error({
        this.errorCode,
        this.errorMessage,
    });

    factory Error.fromJson(Map<String, dynamic> json) => Error(
        errorCode: toInt(json["ErrorCode"]),
        errorMessage: json["ErrorMessage"],
    );

    Map<String, dynamic> toJson() => {
        "ErrorCode": errorCode,
        "ErrorMessage": errorMessage,
    };
}

class HotelItineraryTracking {
    final dynamic campaignId;
    final dynamic campaignName;
    final bool? isLovedByIndians;
    final bool? isSelectedFromSimilar;
    final dynamic itineraryTrackingJson;
    final int? searchType;

    HotelItineraryTracking({
        this.campaignId,
        this.campaignName,
        this.isLovedByIndians,
        this.isSelectedFromSimilar,
        this.itineraryTrackingJson,
        this.searchType,
    });

    factory HotelItineraryTracking.fromJson(Map<String, dynamic> json) =>
        HotelItineraryTracking(
            campaignId: json["CampaignId"],
            campaignName: json["CampaignName"],
            isLovedByIndians: json["IsLovedByIndians"],
            isSelectedFromSimilar: json["IsSelectedFromSimilar"],
            itineraryTrackingJson: json["ItineraryTrackingJson"],
            searchType: toInt(json["SearchType"]),
        );

    Map<String, dynamic> toJson() => {
        "CampaignId": campaignId,
        "CampaignName": campaignName,
        "IsLovedByIndians": isLovedByIndians,
        "IsSelectedFromSimilar": isSelectedFromSimilar,
        "ItineraryTrackingJson": itineraryTrackingJson,
        "SearchType": searchType,
    };
}

class HotelRoomsDetail {
    final int? adultCount;
    final String? availabilityType;
    final int? childCount;
    final List<HotelPassenger>? hotelPassenger;
    final bool? requireAllPaxDetails;
    final int? roomId;
    final int? roomStatus;
    final int? roomIndex;
    final String? roomTypeCode;
    final String? roomDescription;
    final String? roomTypeName;
    final String? ratePlanCode;
    final int? ratePlan;
    final bool? isPerStay;
    final dynamic supplierPrice;
    final Price? price;
    final String? roomPromotion;
    final List<String>? amenities;
    final List<String>? amenity;
    final String? smokingPreference;
    final List<dynamic>? bedTypes;
    final dynamic hotelSupplements;
    final DateTime? lastCancellationDate;
    final List<CancellationPolicy>? cancellationPolicies;
    final DateTime? lastVoucherDate;
    final String? cancellationPolicy;
    final List<String>? inclusion;
    final dynamic beddingGroup;

    HotelRoomsDetail({
        this.adultCount,
        this.availabilityType,
        this.childCount,
        this.hotelPassenger,
        this.requireAllPaxDetails,
        this.roomId,
        this.roomStatus,
        this.roomIndex,
        this.roomTypeCode,
        this.roomDescription,
        this.roomTypeName,
        this.ratePlanCode,
        this.ratePlan,
        this.isPerStay,
        this.supplierPrice,
        this.price,
        this.roomPromotion,
        this.amenities,
        this.amenity,
        this.smokingPreference,
        this.bedTypes,
        this.hotelSupplements,
        this.lastCancellationDate,
        this.cancellationPolicies,
        this.lastVoucherDate,
        this.cancellationPolicy,
        this.inclusion,
        this.beddingGroup,
    });

    factory HotelRoomsDetail.fromJson(Map<String, dynamic> json) => HotelRoomsDetail(
        adultCount: toInt(json["AdultCount"]),
        availabilityType: json["AvailabilityType"],
        childCount: toInt(json["ChildCount"]),
        hotelPassenger: json["HotelPassenger"] == null ? [] : List<HotelPassenger>.from(json["HotelPassenger"]!.map((x) => HotelPassenger.fromJson(x))),
        requireAllPaxDetails: json["RequireAllPaxDetails"],
        roomId: toInt(json["RoomId"]),
        roomStatus: toInt(json["RoomStatus"]),
        roomIndex: toInt(json["RoomIndex"]),
        roomTypeCode: json["RoomTypeCode"],
        roomDescription: json["RoomDescription"],
        roomTypeName: json["RoomTypeName"],
        ratePlanCode: json["RatePlanCode"],
        ratePlan: toInt(json["RatePlan"]),
        isPerStay: json["IsPerStay"],
        supplierPrice: json["SupplierPrice"],
        price: json["Price"] == null ? null : Price.fromJson(json["Price"]),
        roomPromotion: json["RoomPromotion"],
        amenities: json["Amenities"] == null ? [] : List<String>.from(json["Amenities"]!.map((x) => x)),
        amenity: json["Amenity"] == null ? [] : List<String>.from(json["Amenity"]!.map((x) => x)),
        smokingPreference: json["SmokingPreference"],
        bedTypes: json["BedTypes"] == null ? [] : List<dynamic>.from(json["BedTypes"]!.map((x) => x)),
        hotelSupplements: json["HotelSupplements"],
        lastCancellationDate: json["LastCancellationDate"] == null ? null : DateTime.parse(json["LastCancellationDate"]),
        cancellationPolicies: json["CancellationPolicies"] == null ? [] : List<CancellationPolicy>.from(json["CancellationPolicies"]!.map((x) => CancellationPolicy.fromJson(x))),
        lastVoucherDate: json["LastVoucherDate"] == null ? null : DateTime.parse(json["LastVoucherDate"]),
        cancellationPolicy: json["CancellationPolicy"],
        inclusion: json["Inclusion"] == null ? [] : List<String>.from(json["Inclusion"]!.map((x) => x)),
        beddingGroup: json["BeddingGroup"],
    );

    Map<String, dynamic> toJson() => {
        "AdultCount": adultCount,
        "AvailabilityType": availabilityType,
        "ChildCount": childCount,
        "HotelPassenger": hotelPassenger == null ? [] : List<dynamic>.from(hotelPassenger!.map((x) => x.toJson())),
        "RequireAllPaxDetails": requireAllPaxDetails,
        "RoomId": roomId,
        "RoomStatus": roomStatus,
        "RoomIndex": roomIndex,
        "RoomTypeCode": roomTypeCode,
        "RoomDescription": roomDescription,
        "RoomTypeName": roomTypeName,
        "RatePlanCode": ratePlanCode,
        "RatePlan": ratePlan,
        "IsPerStay": isPerStay,
        "SupplierPrice": supplierPrice,
        "Price": price?.toJson(),
        "RoomPromotion": roomPromotion,
        "Amenities": amenities == null ? [] : List<dynamic>.from(amenities!.map((x) => x)),
        "Amenity": amenity == null ? [] : List<dynamic>.from(amenity!.map((x) => x)),
        "SmokingPreference": smokingPreference,
        "BedTypes": bedTypes == null ? [] : List<dynamic>.from(bedTypes!.map((x) => x)),
        "HotelSupplements": hotelSupplements,
        "LastCancellationDate": lastCancellationDate?.toIso8601String(),
        "CancellationPolicies": cancellationPolicies == null ? [] : List<dynamic>.from(cancellationPolicies!.map((x) => x.toJson())),
        "LastVoucherDate": lastVoucherDate?.toIso8601String(),
        "CancellationPolicy": cancellationPolicy,
        "Inclusion": inclusion == null ? [] : List<dynamic>.from(inclusion!.map((x) => x)),
        "BeddingGroup": beddingGroup,
    };
}

class CancellationPolicy {
    final int? charge;
    final int? chargeType;
    final String? currency;
    final DateTime? fromDate;
    final DateTime? toDate;

    CancellationPolicy({
        this.charge,
        this.chargeType,
        this.currency,
        this.fromDate,
        this.toDate,
    });

    factory CancellationPolicy.fromJson(Map<String, dynamic> json) => CancellationPolicy(
        charge: toInt(json["Charge"]),
        chargeType: toInt(json["ChargeType"]),
        currency: json["Currency"],
        fromDate: json["FromDate"] == null ? null : DateTime.parse(json["FromDate"]),
        toDate: json["ToDate"] == null ? null : DateTime.parse(json["ToDate"]),
    );

    Map<String, dynamic> toJson() => {
        "Charge": charge,
        "ChargeType": chargeType,
        "Currency": currency,
        "FromDate": fromDate?.toIso8601String(),
        "ToDate": toDate?.toIso8601String(),
    };
}

class HotelPassenger {
    final int? age;
    final String? email;
    final dynamic fileDocument;
    final String? firstName;
    final dynamic gstCompanyAddress;
    final dynamic gstCompanyContactNumber;
    final dynamic gstCompanyEmail;
    final dynamic gstCompanyName;
    final dynamic gstNumber;
    final dynamic guardianDetail;
    final String? lastName;
    final bool? leadPassenger;
    final dynamic middleName;
    final String? pan;
    final dynamic passportExpDate;
    final dynamic passportIssueDate;
    final dynamic passportNo;
    final int? paxId;
    final int? paxType;
    final String? phoneno;
    final String? title;

    HotelPassenger({
        this.age,
        this.email,
        this.fileDocument,
        this.firstName,
        this.gstCompanyAddress,
        this.gstCompanyContactNumber,
        this.gstCompanyEmail,
        this.gstCompanyName,
        this.gstNumber,
        this.guardianDetail,
        this.lastName,
        this.leadPassenger,
        this.middleName,
        this.pan,
        this.passportExpDate,
        this.passportIssueDate,
        this.passportNo,
        this.paxId,
        this.paxType,
        this.phoneno,
        this.title,
    });

    factory HotelPassenger.fromJson(Map<String, dynamic> json) => HotelPassenger(
        age: toInt(json["Age"]),
        email: json["Email"],
        fileDocument: json["FileDocument"],
        firstName: json["FirstName"],
        gstCompanyAddress: json["GSTCompanyAddress"],
        gstCompanyContactNumber: json["GSTCompanyContactNumber"],
        gstCompanyEmail: json["GSTCompanyEmail"],
        gstCompanyName: json["GSTCompanyName"],
        gstNumber: json["GSTNumber"],
        guardianDetail: json["GuardianDetail"],
        lastName: json["LastName"],
        leadPassenger: json["LeadPassenger"],
        middleName: json["MiddleName"],
        pan: json["PAN"],
        passportExpDate: json["PassportExpDate"],
        passportIssueDate: json["PassportIssueDate"],
        passportNo: json["PassportNo"],
        paxId: toInt(json["PaxId"]),
        paxType: toInt(json["PaxType"]),
        phoneno: json["Phoneno"],
        title: json["Title"],
    );

    Map<String, dynamic> toJson() => {
        "Age": age,
        "Email": email,
        "FileDocument": fileDocument,
        "FirstName": firstName,
        "GSTCompanyAddress": gstCompanyAddress,
        "GSTCompanyContactNumber": gstCompanyContactNumber,
        "GSTCompanyEmail": gstCompanyEmail,
        "GSTCompanyName": gstCompanyName,
        "GSTNumber": gstNumber,
        "GuardianDetail": guardianDetail,
        "LastName": lastName,
        "LeadPassenger": leadPassenger,
        "MiddleName": middleName,
        "PAN": pan,
        "PassportExpDate": passportExpDate,
        "PassportIssueDate": passportIssueDate,
        "PassportNo": passportNo,
        "PaxId": paxId,
        "PaxType": paxType,
        "Phoneno": phoneno,
        "Title": title,
    };
}

class Price {
    final String? currencyCode;
    final double? roomPrice;
    final double? tax;
    final int? extraGuestCharge;
    final int? childCharge;
    final int? otherCharges;
    final int? discount;
    final double? publishedPrice;
    final int? publishedPriceRoundedOff;
    final double? offeredPrice;
    final int? offeredPriceRoundedOff;
    final double? agentCommission;
    final int? agentMarkUp;
    final int? serviceTax;
    final int? tcs;
    final double? tds;
    final int? serviceCharge;
    final int? totalGstAmount;
    final Gst? gst;

    Price({
        this.currencyCode,
        this.roomPrice,
        this.tax,
        this.extraGuestCharge,
        this.childCharge,
        this.otherCharges,
        this.discount,
        this.publishedPrice,
        this.publishedPriceRoundedOff,
        this.offeredPrice,
        this.offeredPriceRoundedOff,
        this.agentCommission,
        this.agentMarkUp,
        this.serviceTax,
        this.tcs,
        this.tds,
        this.serviceCharge,
        this.totalGstAmount,
        this.gst,
    });

    factory Price.fromJson(Map<String, dynamic> json) => Price(
        currencyCode: json["CurrencyCode"],
        roomPrice: toDouble(json["RoomPrice"]),
        tax: toDouble(json["Tax"]),
        extraGuestCharge: toInt(json["ExtraGuestCharge"]),
        childCharge: toInt(json["ChildCharge"]),
        otherCharges: toInt(json["OtherCharges"]),
        discount: toInt(json["Discount"]),
        publishedPrice: toDouble(json["PublishedPrice"]),
        publishedPriceRoundedOff: toInt(json["PublishedPriceRoundedOff"]),
        offeredPrice: toDouble(json["OfferedPrice"]),
        offeredPriceRoundedOff: toInt(json["OfferedPriceRoundedOff"]),
        agentCommission: toDouble(json["AgentCommission"]),
        agentMarkUp: toInt(json["AgentMarkUp"]),
        serviceTax: toInt(json["ServiceTax"]),
        tcs: toInt(json["TCS"]),
        tds: toDouble(json["TDS"]),
        serviceCharge: toInt(json["ServiceCharge"]),
        totalGstAmount: toInt(json["TotalGSTAmount"]),
        gst: json["GST"] == null ? null : Gst.fromJson(json["GST"]),
    );

    Map<String, dynamic> toJson() => {
        "CurrencyCode": currencyCode,
        "RoomPrice": roomPrice,
        "Tax": tax,
        "ExtraGuestCharge": extraGuestCharge,
        "ChildCharge": childCharge,
        "OtherCharges": otherCharges,
        "Discount": discount,
        "PublishedPrice": publishedPrice,
        "PublishedPriceRoundedOff": publishedPriceRoundedOff,
        "OfferedPrice": offeredPrice,
        "OfferedPriceRoundedOff": offeredPriceRoundedOff,
        "AgentCommission": agentCommission,
        "AgentMarkUp": agentMarkUp,
        "ServiceTax": serviceTax,
        "TCS": tcs,
        "TDS": tds,
        "ServiceCharge": serviceCharge,
        "TotalGSTAmount": totalGstAmount,
        "GST": gst?.toJson(),
    };
}

class Gst {
    final int? cgstAmount;
    final int? cgstRate;
    final int? cessAmount;
    final int? cessRate;
    final int? igstAmount;
    final int? igstRate;
    final int? sgstAmount;
    final int? sgstRate;
    final int? taxableAmount;

    Gst({
        this.cgstAmount,
        this.cgstRate,
        this.cessAmount,
        this.cessRate,
        this.igstAmount,
        this.igstRate,
        this.sgstAmount,
        this.sgstRate,
        this.taxableAmount,
    });

    factory Gst.fromJson(Map<String, dynamic> json) => Gst(
        cgstAmount: toInt(json["CGSTAmount"]),
        cgstRate: toInt(json["CGSTRate"]),
        cessAmount: toInt(json["CessAmount"]),
        cessRate: toInt(json["CessRate"]),
        igstAmount: toInt(json["IGSTAmount"]),
        igstRate: toInt(json["IGSTRate"]),
        sgstAmount: toInt(json["SGSTAmount"]),
        sgstRate: toInt(json["SGSTRate"]),
        taxableAmount: toInt(json["TaxableAmount"]),
    );


    Map<String, dynamic> toJson() => {
        "CGSTAmount": cgstAmount,
        "CGSTRate": cgstRate,
        "CessAmount": cessAmount,
        "CessRate": cessRate,
        "IGSTAmount": igstAmount,
        "IGSTRate": igstRate,
        "SGSTAmount": sgstAmount,
        "SGSTRate": sgstRate,
        "TaxableAmount": taxableAmount,
    };
}
