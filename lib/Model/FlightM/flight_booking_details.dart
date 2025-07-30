// To parse this JSON data, do
//
//     final flightBookingDetailsModel = flightBookingDetailsModelFromJson(jsonString);

import 'dart:convert';

FlightBookingDetailsModel flightBookingDetailsModelFromJson(String str) => FlightBookingDetailsModel.fromJson(json.decode(str));

String flightBookingDetailsModelToJson(FlightBookingDetailsModel data) => json.encode(data.toJson());

int? _toInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
}

class FlightBookingDetailsModel {
    final bool? success;
    final String? message;
    final Data? data;

    FlightBookingDetailsModel({
        this.success,
        this.message,
        this.data,
    });

    factory FlightBookingDetailsModel.fromJson(Map<String, dynamic> json) => FlightBookingDetailsModel(
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
    final Error? error;
    final int? responseStatus;
    final String? traceId;
    final FlightItinerary? flightItinerary;

    Data({
        this.error,
        this.responseStatus,
        this.traceId,
        this.flightItinerary,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        error: json["Error"] == null ? null : Error.fromJson(json["Error"]),
        responseStatus: json["ResponseStatus"],
        traceId: json["TraceId"],
        flightItinerary: json["FlightItinerary"] == null ? null : FlightItinerary.fromJson(json["FlightItinerary"]),
    );

    Map<String, dynamic> toJson() => {
        "Error": error?.toJson(),
        "ResponseStatus": responseStatus,
        "TraceId": traceId,
        "FlightItinerary": flightItinerary?.toJson(),
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
        errorCode: json["ErrorCode"],
        errorMessage: json["ErrorMessage"],
    );

    Map<String, dynamic> toJson() => {
        "ErrorCode": errorCode,
        "ErrorMessage": errorMessage,
    };
}

class FlightItinerary {
    final String? agentRemarks;
    final dynamic commentDetails;
    final bool? isSeatsBooked;
    final int? journeyType;
    final int? searchCombinationType;
    final int? tripIndicator;
    final bool? bookingAllowedForRoamer;
    final int? bookingId;
    final bool? isCouponAppilcable;
    final bool? isManual;
    final String? pnr;
    final bool? isDomestic;
    final String? resultFareType;
    final int? source;
    final String? origin;
    final String? destination;
    final String? airlineCode;
    final DateTime? lastTicketDate;
    final String? validatingAirlineCode;
    final String? airlineRemark;
    final bool? isLcc;
    final bool? nonRefundable;
    final String? fareType;
    final dynamic creditNoteNo;
    final Fare? fare;
    final dynamic creditNoteCreatedOn;
    final List<Passenger>? passenger;
    final dynamic cancellationCharges;
    final List<Segment>? segments;
    final List<FareRule>? fareRules;
    final List<MiniFareRule>? miniFareRules;
    final PenaltyCharges? penaltyCharges;
    final int? status;
    final bool? isWebCheckInAllowed;

    FlightItinerary({
        this.agentRemarks,
        this.commentDetails,
        this.isSeatsBooked,
        this.journeyType,
        this.searchCombinationType,
        this.tripIndicator,
        this.bookingAllowedForRoamer,
        this.bookingId,
        this.isCouponAppilcable,
        this.isManual,
        this.pnr,
        this.isDomestic,
        this.resultFareType,
        this.source,
        this.origin,
        this.destination,
        this.airlineCode,
        this.lastTicketDate,
        this.validatingAirlineCode,
        this.airlineRemark,
        this.isLcc,
        this.nonRefundable,
        this.fareType,
        this.creditNoteNo,
        this.fare,
        this.creditNoteCreatedOn,
        this.passenger,
        this.cancellationCharges,
        this.segments,
        this.fareRules,
        this.miniFareRules,
        this.penaltyCharges,
        this.status,
        this.isWebCheckInAllowed,
    });

    factory FlightItinerary.fromJson(Map<String, dynamic> json) => FlightItinerary(
        agentRemarks: json["AgentRemarks"],
        commentDetails: json["CommentDetails"],
        isSeatsBooked: json["IsSeatsBooked"],
        journeyType: (json["JourneyType"] is int)
            ? json["JourneyType"]
            : (json["JourneyType"] as num?)?.toInt(),
        searchCombinationType: (json["SearchCombinationType"] is int)
            ? json["SearchCombinationType"]
            : (json["SearchCombinationType"] as num?)?.toInt(),
        tripIndicator: (json["TripIndicator"] is int)
            ? json["TripIndicator"]
            : (json["TripIndicator"] as num?)?.toInt(),
        bookingAllowedForRoamer: json["BookingAllowedForRoamer"],
        bookingId: (json["BookingId"] is int)
            ? json["BookingId"]
            : (json["BookingId"] as num?)?.toInt(),
        isCouponAppilcable: json["IsCouponAppilcable"],
        isManual: json["IsManual"],
        pnr: json["PNR"],
        isDomestic: json["IsDomestic"],
        resultFareType: json["ResultFareType"],
        source: (json["Source"] is int)
            ? json["Source"]
            : (json["Source"] as num?)?.toInt(),
        origin: json["Origin"],
        destination: json["Destination"],
        airlineCode: json["AirlineCode"],
        lastTicketDate: json["LastTicketDate"] == null
            ? null
            : DateTime.tryParse(json["LastTicketDate"]),
        validatingAirlineCode: json["ValidatingAirlineCode"],
        airlineRemark: json["AirlineRemark"],
        isLcc: json["IsLCC"],
        nonRefundable: json["NonRefundable"],
        fareType: json["FareType"],
        creditNoteNo: json["CreditNoteNo"],
        fare: json["Fare"] == null ? null : Fare.fromJson(json["Fare"]),
        creditNoteCreatedOn: json["CreditNoteCreatedOn"],
        passenger: json["Passenger"] == null
            ? []
            : List<Passenger>.from(json["Passenger"].map((x) => Passenger.fromJson(x))),
        cancellationCharges: json["CancellationCharges"],
        segments: json["Segments"] == null
            ? []
            : List<Segment>.from(json["Segments"].map((x) => Segment.fromJson(x))),
        fareRules: json["FareRules"] == null
            ? []
            : List<FareRule>.from(json["FareRules"].map((x) => FareRule.fromJson(x))),
        miniFareRules: json["MiniFareRules"] == null
            ? []
            : List<MiniFareRule>.from(json["MiniFareRules"].map((x) => MiniFareRule.fromJson(x))),
        penaltyCharges: json["PenaltyCharges"] == null
            ? null
            : PenaltyCharges.fromJson(json["PenaltyCharges"]),
        status: (json["Status"] is int)
            ? json["Status"]
            : (json["Status"] as num?)?.toInt(),
        isWebCheckInAllowed: json["IsWebCheckInAllowed"],
    );

    Map<String, dynamic> toJson() => {
        "AgentRemarks": agentRemarks,
        "CommentDetails": commentDetails,
        "IsSeatsBooked": isSeatsBooked,
        "JourneyType": journeyType,
        "SearchCombinationType": searchCombinationType,
        "TripIndicator": tripIndicator,
        "BookingAllowedForRoamer": bookingAllowedForRoamer,
        "BookingId": bookingId,
        "IsCouponAppilcable": isCouponAppilcable,
        "IsManual": isManual,
        "PNR": pnr,
        "IsDomestic": isDomestic,
        "ResultFareType": resultFareType,
        "Source": source,
        "Origin": origin,
        "Destination": destination,
        "AirlineCode": airlineCode,
        "LastTicketDate": lastTicketDate?.toIso8601String(),
        "ValidatingAirlineCode": validatingAirlineCode,
        "AirlineRemark": airlineRemark,
        "IsLCC": isLcc,
        "NonRefundable": nonRefundable,
        "FareType": fareType,
        "CreditNoteNo": creditNoteNo,
        "Fare": fare?.toJson(),
        "CreditNoteCreatedOn": creditNoteCreatedOn,
        "Passenger": passenger == null ? [] : List<dynamic>.from(passenger!.map((x) => x.toJson())),
        "CancellationCharges": cancellationCharges,
        "Segments": segments == null ? [] : List<dynamic>.from(segments!.map((x) => x.toJson())),
        "FareRules": fareRules == null ? [] : List<dynamic>.from(fareRules!.map((x) => x.toJson())),
        "MiniFareRules": miniFareRules == null ? [] : List<dynamic>.from(miniFareRules!.map((x) => x.toJson())),
        "PenaltyCharges": penaltyCharges?.toJson(),
        "Status": status,
        "IsWebCheckInAllowed": isWebCheckInAllowed,
    };
}

class Fare {
    final int? serviceFeeDisplayType;
    final String? currency;
    final int? baseFare;
    final int? tax;
    final List<dynamic>? taxBreakup;
    final int? yqTax;
    final int? additionalTxnFeeOfrd;
    final int? additionalTxnFeePub;
    final int? pgCharge;
    final int? otherCharges;
    final List<ChargeBu>? chargeBu;
    final int? discount;
    final int? publishedFare;
    final double? commissionEarned;
    final double? plbEarned;
    final double? incentiveEarned;
    final double? offeredFare;
    final double? tdsOnCommission;
    final double? tdsOnPlb;
    final double? tdsOnIncentive;
    final int? serviceFee;
    final int? totalBaggageCharges;
    final int? totalMealCharges;
    final int? totalSeatCharges;
    final int? totalSpecialServiceCharges;

    Fare({
        this.serviceFeeDisplayType,
        this.currency,
        this.baseFare,
        this.tax,
        this.taxBreakup,
        this.yqTax,
        this.additionalTxnFeeOfrd,
        this.additionalTxnFeePub,
        this.pgCharge,
        this.otherCharges,
        this.chargeBu,
        this.discount,
        this.publishedFare,
        this.commissionEarned,
        this.plbEarned,
        this.incentiveEarned,
        this.offeredFare,
        this.tdsOnCommission,
        this.tdsOnPlb,
        this.tdsOnIncentive,
        this.serviceFee,
        this.totalBaggageCharges,
        this.totalMealCharges,
        this.totalSeatCharges,
        this.totalSpecialServiceCharges,
    });

    factory Fare.fromJson(Map<String, dynamic> json) => Fare(
        serviceFeeDisplayType: _toInt(json["ServiceFeeDisplayType"]),
        baseFare: _toInt(json["BaseFare"]),
        tax: _toInt(json["Tax"]),
        yqTax: _toInt(json["YQTax"]),
        additionalTxnFeeOfrd: _toInt(json["AdditionalTxnFeeOfrd"]),
        additionalTxnFeePub: _toInt(json["AdditionalTxnFeePub"]),
        pgCharge: _toInt(json["PGCharge"]),
        otherCharges: _toInt(json["OtherCharges"]),
        discount: _toInt(json["Discount"]),
        publishedFare: _toInt(json["PublishedFare"]),
        serviceFee: _toInt(json["ServiceFee"]),
        totalBaggageCharges: _toInt(json["TotalBaggageCharges"]),
        totalMealCharges: _toInt(json["TotalMealCharges"]),
        totalSeatCharges: _toInt(json["TotalSeatCharges"]),
        totalSpecialServiceCharges: _toInt(json["TotalSpecialServiceCharges"]),
        // keep these as is
        currency: json["Currency"],
        commissionEarned: json["CommissionEarned"]?.toDouble(),
        plbEarned: json["PLBEarned"]?.toDouble(),
        incentiveEarned: json["IncentiveEarned"]?.toDouble(),
        offeredFare: json["OfferedFare"]?.toDouble(),
        tdsOnCommission: json["TdsOnCommission"]?.toDouble(),
        tdsOnPlb: json["TdsOnPLB"]?.toDouble(),
        tdsOnIncentive: json["TdsOnIncentive"]?.toDouble(),
        taxBreakup: json["TaxBreakup"] == null ? [] : List<dynamic>.from(json["TaxBreakup"].map((x) => x)),
        chargeBu: json["ChargeBU"] == null ? [] : List<ChargeBu>.from(json["ChargeBU"].map((x) => ChargeBu.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ServiceFeeDisplayType": serviceFeeDisplayType,
        "Currency": currency,
        "BaseFare": baseFare,
        "Tax": tax,
        "TaxBreakup": taxBreakup == null ? [] : List<dynamic>.from(taxBreakup!.map((x) => x)),
        "YQTax": yqTax,
        "AdditionalTxnFeeOfrd": additionalTxnFeeOfrd,
        "AdditionalTxnFeePub": additionalTxnFeePub,
        "PGCharge": pgCharge,
        "OtherCharges": otherCharges,
        "ChargeBU": chargeBu == null ? [] : List<dynamic>.from(chargeBu!.map((x) => x.toJson())),
        "Discount": discount,
        "PublishedFare": publishedFare,
        "CommissionEarned": commissionEarned,
        "PLBEarned": plbEarned,
        "IncentiveEarned": incentiveEarned,
        "OfferedFare": offeredFare,
        "TdsOnCommission": tdsOnCommission,
        "TdsOnPLB": tdsOnPlb,
        "TdsOnIncentive": tdsOnIncentive,
        "ServiceFee": serviceFee,
        "TotalBaggageCharges": totalBaggageCharges,
        "TotalMealCharges": totalMealCharges,
        "TotalSeatCharges": totalSeatCharges,
        "TotalSpecialServiceCharges": totalSpecialServiceCharges,
    };
}

class ChargeBu {
    final String? key;
    final int? value;

    ChargeBu({
        this.key,
        this.value,
    });

    factory ChargeBu.fromJson(Map<String, dynamic> json) => ChargeBu(
        key: json["key"],
        value: _toInt(json["value"]),
    );

    Map<String, dynamic> toJson() => {
        "key": key,
        "value": value,
    };
}

class FareRule {
    final String? origin;
    final String? destination;
    final String? airline;
    final String? fareBasisCode;
    final String? fareRuleDetail;
    final String? fareRestriction;
    final String? fareFamilyCode;
    final String? fareRuleIndex;
    final List<dynamic>? fareInclusions;

    FareRule({
        this.origin,
        this.destination,
        this.airline,
        this.fareBasisCode,
        this.fareRuleDetail,
        this.fareRestriction,
        this.fareFamilyCode,
        this.fareRuleIndex,
        this.fareInclusions,
    });

    factory FareRule.fromJson(Map<String, dynamic> json) => FareRule(
        origin: json["Origin"],
        destination: json["Destination"],
        airline: json["Airline"],
        fareBasisCode: json["FareBasisCode"],
        fareRuleDetail: json["FareRuleDetail"],
        fareRestriction: json["FareRestriction"],
        fareFamilyCode: json["FareFamilyCode"],
        fareRuleIndex: json["FareRuleIndex"],
        fareInclusions: json["FareInclusions"] == null ? [] : List<dynamic>.from(json["FareInclusions"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "Origin": origin,
        "Destination": destination,
        "Airline": airline,
        "FareBasisCode": fareBasisCode,
        "FareRuleDetail": fareRuleDetail,
        "FareRestriction": fareRestriction,
        "FareFamilyCode": fareFamilyCode,
        "FareRuleIndex": fareRuleIndex,
        "FareInclusions": fareInclusions == null ? [] : List<dynamic>.from(fareInclusions!.map((x) => x)),
    };
}

class MiniFareRule {
    final String? journeyPoints;
    final String? type;
    final String? from;
    final String? to;
    final String? unit;
    final String? details;
    final bool? onlineReissueAllowed;
    final bool? onlineRefundAllowed;

    MiniFareRule({
        this.journeyPoints,
        this.type,
        this.from,
        this.to,
        this.unit,
        this.details,
        this.onlineReissueAllowed,
        this.onlineRefundAllowed,
    });

    factory MiniFareRule.fromJson(Map<String, dynamic> json) => MiniFareRule(
        journeyPoints: json["JourneyPoints"],
        type: json["Type"],
        from: json["From"],
        to: json["To"],
        unit: json["Unit"],
        details: json["Details"],
        onlineReissueAllowed: json["OnlineReissueAllowed"],
        onlineRefundAllowed: json["OnlineRefundAllowed"],
    );

    Map<String, dynamic> toJson() => {
        "JourneyPoints": journeyPoints,
        "Type": type,
        "From": from,
        "To": to,
        "Unit": unit,
        "Details": details,
        "OnlineReissueAllowed": onlineReissueAllowed,
        "OnlineRefundAllowed": onlineRefundAllowed,
    };
}

class Passenger {
    final dynamic barcodeDetails;
    final List<DocumentDetail>? documentDetails;
    final dynamic guardianDetails;
    final int? paxId;
    final String? title;
    final String? firstName;
    final String? lastName;
    final int? paxType;
    final DateTime? dateOfBirth;
    final int? gender;
    final bool? isPanRequired;
    final bool? isPassportRequired;
    final String? pan;
    final String? passportNo;
    final String? addressLine1;
    final Fare? fare;
    final String? city;
    final String? countryCode;
    final String? nationality;
    final String? contactNo;
    final String? email;
    final bool? isLeadPax;
    final dynamic ffAirlineCode;
    final dynamic ffNumber;
    final List<Baggage>? baggage;
    final List<Ssr>? ssr;

    Passenger({
        this.barcodeDetails,
        this.documentDetails,
        this.guardianDetails,
        this.paxId,
        this.title,
        this.firstName,
        this.lastName,
        this.paxType,
        this.dateOfBirth,
        this.gender,
        this.isPanRequired,
        this.isPassportRequired,
        this.pan,
        this.passportNo,
        this.addressLine1,
        this.fare,
        this.city,
        this.countryCode,
        this.nationality,
        this.contactNo,
        this.email,
        this.isLeadPax,
        this.ffAirlineCode,
        this.ffNumber,
        this.baggage,
        this.ssr,
    });

    factory Passenger.fromJson(Map<String, dynamic> json) => Passenger(
        barcodeDetails: json["BarcodeDetails"],
        documentDetails: json["DocumentDetails"] == null
            ? []
            : List<DocumentDetail>.from(json["DocumentDetails"].map((x) => DocumentDetail.fromJson(x))),
        guardianDetails: json["GuardianDetails"],
        paxId: (json["PaxId"] is int)
            ? json["PaxId"]
            : (json["PaxId"] as num?)?.toInt(),
        title: json["Title"],
        firstName: json["FirstName"],
        lastName: json["LastName"],
        paxType: (json["PaxType"] is int)
            ? json["PaxType"]
            : (json["PaxType"] as num?)?.toInt(),
        dateOfBirth: json["DateOfBirth"] == null ? null : DateTime.tryParse(json["DateOfBirth"]),
        gender: (json["Gender"] is int)
            ? json["Gender"]
            : (json["Gender"] as num?)?.toInt(),
        isPanRequired: json["IsPANRequired"],
        isPassportRequired: json["IsPassportRequired"],
        pan: json["PAN"],
        passportNo: json["PassportNo"],
        addressLine1: json["AddressLine1"],
        fare: json["Fare"] == null ? null : Fare.fromJson(json["Fare"]),
        city: json["City"],
        countryCode: json["CountryCode"],
        nationality: json["Nationality"],
        contactNo: json["ContactNo"],
        email: json["Email"],
        isLeadPax: json["IsLeadPax"],
        ffAirlineCode: json["FFAirlineCode"],
        ffNumber: json["FFNumber"],
        baggage: json["Baggage"] == null
            ? []
            : List<Baggage>.from(json["Baggage"].map((x) => Baggage.fromJson(x))),
        ssr: json["Ssr"] == null
            ? []
            : List<Ssr>.from(json["Ssr"].map((x) => Ssr.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "BarcodeDetails": barcodeDetails,
        "DocumentDetails": documentDetails == null
            ? []
            : List<dynamic>.from(documentDetails!.map((x) => x.toJson())),
        "GuardianDetails": guardianDetails,
        "PaxId": paxId,
        "Title": title,
        "FirstName": firstName,
        "LastName": lastName,
        "PaxType": paxType,
        "DateOfBirth": dateOfBirth?.toIso8601String(),
        "Gender": gender,
        "IsPANRequired": isPanRequired,
        "IsPassportRequired": isPassportRequired,
        "PAN": pan,
        "PassportNo": passportNo,
        "AddressLine1": addressLine1,
        "Fare": fare?.toJson(),
        "City": city,
        "CountryCode": countryCode,
        "Nationality": nationality,
        "ContactNo": contactNo,
        "Email": email,
        "IsLeadPax": isLeadPax,
        "FFAirlineCode": ffAirlineCode,
        "FFNumber": ffNumber,
        "Baggage": baggage == null
            ? []
            : List<dynamic>.from(baggage!.map((x) => x.toJson())),
        "Ssr": ssr == null
            ? []
            : List<dynamic>.from(ssr!.map((x) => x.toJson())),
    };
}

class Baggage {
    final String? airlineCode;
    final String? flightNumber;
    final int? wayType;
    final String? code;
    final int? description;
    final int? weight;
    final String? currency;
    final int? price;
    final String? origin;
    final String? destination;
    final String? text;

    Baggage({
        this.airlineCode,
        this.flightNumber,
        this.wayType,
        this.code,
        this.description,
        this.weight,
        this.currency,
        this.price,
        this.origin,
        this.destination,
        this.text,
    });

    factory Baggage.fromJson(Map<String, dynamic> json) => Baggage(
        airlineCode: json["AirlineCode"],
        flightNumber: json["FlightNumber"],
        wayType: _toInt(json["WayType"]),
        code: json["Code"],
        description: _toInt(json["Description"]),
        weight: _toInt(json["Weight"]),
        currency: json["Currency"],
        price: _toInt(json["Price"]),
        origin: json["Origin"],
        destination: json["Destination"],
        text: json["Text"],
    );

    Map<String, dynamic> toJson() => {
        "AirlineCode": airlineCode,
        "FlightNumber": flightNumber,
        "WayType": wayType,
        "Code": code,
        "Description": description,
        "Weight": weight,
        "Currency": currency,
        "Price": price,
        "Origin": origin,
        "Destination": destination,
        "Text": text,
    };
}

class DocumentDetail {
    final DateTime? documentExpiryDate;
    final DateTime? documentIssueDate;
    final String? documentIssuingCountry;
    final String? documentNumber;
    final String? documentTypeId;
    final int? paxId;
    final int? resultFareType;

    DocumentDetail({
        this.documentExpiryDate,
        this.documentIssueDate,
        this.documentIssuingCountry,
        this.documentNumber,
        this.documentTypeId,
        this.paxId,
        this.resultFareType,
    });

    factory DocumentDetail.fromJson(Map<String, dynamic> json) => DocumentDetail(
        documentExpiryDate: json["DocumentExpiryDate"] == null ? null : DateTime.parse(json["DocumentExpiryDate"]),
        documentIssueDate: json["DocumentIssueDate"] == null ? null : DateTime.parse(json["DocumentIssueDate"]),
        documentIssuingCountry: json["DocumentIssuingCountry"],
        documentNumber: json["DocumentNumber"],
        documentTypeId: json["DocumentTypeId"],
        paxId: _toInt(json["PaxId"]),
        resultFareType: _toInt(json["ResultFareType"]),
    );

    Map<String, dynamic> toJson() => {
        "DocumentExpiryDate": "${documentExpiryDate!.year.toString().padLeft(4, '0')}-${documentExpiryDate!.month.toString().padLeft(2, '0')}-${documentExpiryDate!.day.toString().padLeft(2, '0')}",
        "DocumentIssueDate": "${documentIssueDate!.year.toString().padLeft(4, '0')}-${documentIssueDate!.month.toString().padLeft(2, '0')}-${documentIssueDate!.day.toString().padLeft(2, '0')}",
        "DocumentIssuingCountry": documentIssuingCountry,
        "DocumentNumber": documentNumber,
        "DocumentTypeId": documentTypeId,
        "PaxId": paxId,
        "ResultFareType": resultFareType,
    };
}

class Ssr {
    final String? detail;
    final String? ssrCode;
    final dynamic ssrStatus;
    final int? status;

    Ssr({
        this.detail,
        this.ssrCode,
        this.ssrStatus,
        this.status,
    });

    factory Ssr.fromJson(Map<String, dynamic> json) => Ssr(
        detail: json["Detail"],
        ssrCode: json["SsrCode"],
        ssrStatus: json["SsrStatus"],
        status: _toInt(json["Status"]),
    );

    Map<String, dynamic> toJson() => {
        "Detail": detail,
        "SsrCode": ssrCode,
        "SsrStatus": ssrStatus,
        "Status": status,
    };
}

class PenaltyCharges {
    final String? reissueCharge;
    final String? cancellationCharge;

    PenaltyCharges({
        this.reissueCharge,
        this.cancellationCharge,
    });

    factory PenaltyCharges.fromJson(Map<String, dynamic> json) => PenaltyCharges(
        reissueCharge: json["ReissueCharge"],
        cancellationCharge: json["CancellationCharge"],
    );

    Map<String, dynamic> toJson() => {
        "ReissueCharge": reissueCharge,
        "CancellationCharge": cancellationCharge,
    };
}

class Segment {
    final String? baggage;
    final String? cabinBaggage;
    final int? cabinClass;
    final dynamic supplierFareClass;
    final int? tripIndicator;
    final int? segmentIndicator;
    final Airline? airline;
    final String? airlinePnr;
    final Origin? origin;
    final Destination? destination;
    final int? accumulatedDuration;
    final int? duration;
    final int? groundTime;
    final int? mile;
    final bool? stopOver;
    final String? flightInfoIndex;
    final String? stopPoint;
    final dynamic stopPointArrivalTime;
    final dynamic stopPointDepartureTime;
    final String? craft;
    final dynamic remark;
    final bool? isETicketEligible;
    final String? flightStatus;
    final String? status;
    final dynamic fareClassification;

    Segment({
        this.baggage,
        this.cabinBaggage,
        this.cabinClass,
        this.supplierFareClass,
        this.tripIndicator,
        this.segmentIndicator,
        this.airline,
        this.airlinePnr,
        this.origin,
        this.destination,
        this.accumulatedDuration,
        this.duration,
        this.groundTime,
        this.mile,
        this.stopOver,
        this.flightInfoIndex,
        this.stopPoint,
        this.stopPointArrivalTime,
        this.stopPointDepartureTime,
        this.craft,
        this.remark,
        this.isETicketEligible,
        this.flightStatus,
        this.status,
        this.fareClassification,
    });

    factory Segment.fromJson(Map<String, dynamic> json) => Segment(
        baggage: json["Baggage"],
        cabinBaggage: json["CabinBaggage"],
        cabinClass: _toInt(json["CabinClass"]),
        supplierFareClass: json["SupplierFareClass"],
        tripIndicator: _toInt(json["TripIndicator"]),
        segmentIndicator: _toInt(json["SegmentIndicator"]),
        airline: json["Airline"] == null ? null : Airline.fromJson(json["Airline"]),
        airlinePnr: json["AirlinePNR"],
        origin: json["Origin"] == null ? null : Origin.fromJson(json["Origin"]),
        destination: json["Destination"] == null ? null : Destination.fromJson(json["Destination"]),
        accumulatedDuration: _toInt(json["AccumulatedDuration"]),
        duration: _toInt(json["Duration"]),
        groundTime: _toInt(json["GroundTime"]),
        mile: _toInt(json["Mile"]),
        stopOver: json["StopOver"],
        flightInfoIndex: json["FlightInfoIndex"],
        stopPoint: json["StopPoint"],
        stopPointArrivalTime: json["StopPointArrivalTime"],
        stopPointDepartureTime: json["StopPointDepartureTime"],
        craft: json["Craft"],
        remark: json["Remark"],
        isETicketEligible: json["IsETicketEligible"],
        flightStatus: json["FlightStatus"],
        status: json["Status"],
        fareClassification: json["FareClassification"],
    );

    Map<String, dynamic> toJson() => {
        "Baggage": baggage,
        "CabinBaggage": cabinBaggage,
        "CabinClass": cabinClass,
        "SupplierFareClass": supplierFareClass,
        "TripIndicator": tripIndicator,
        "SegmentIndicator": segmentIndicator,
        "Airline": airline?.toJson(),
        "AirlinePNR": airlinePnr,
        "Origin": origin?.toJson(),
        "Destination": destination?.toJson(),
        "AccumulatedDuration": accumulatedDuration,
        "Duration": duration,
        "GroundTime": groundTime,
        "Mile": mile,
        "StopOver": stopOver,
        "FlightInfoIndex": flightInfoIndex,
        "StopPoint": stopPoint,
        "StopPointArrivalTime": stopPointArrivalTime,
        "StopPointDepartureTime": stopPointDepartureTime,
        "Craft": craft,
        "Remark": remark,
        "IsETicketEligible": isETicketEligible,
        "FlightStatus": flightStatus,
        "Status": status,
        "FareClassification": fareClassification,
    };
}

class Airline {
    final String? airlineCode;
    final String? airlineName;
    final String? flightNumber;
    final String? fareClass;
    final String? operatingCarrier;

    Airline({
        this.airlineCode,
        this.airlineName,
        this.flightNumber,
        this.fareClass,
        this.operatingCarrier,
    });

    factory Airline.fromJson(Map<String, dynamic> json) => Airline(
        airlineCode: json["AirlineCode"],
        airlineName: json["AirlineName"],
        flightNumber: json["FlightNumber"],
        fareClass: json["FareClass"],
        operatingCarrier: json["OperatingCarrier"],
    );

    Map<String, dynamic> toJson() => {
        "AirlineCode": airlineCode,
        "AirlineName": airlineName,
        "FlightNumber": flightNumber,
        "FareClass": fareClass,
        "OperatingCarrier": operatingCarrier,
    };
}

class Destination {
    final Airport? airport;
    final DateTime? arrTime;

    Destination({
        this.airport,
        this.arrTime,
    });

    factory Destination.fromJson(Map<String, dynamic> json) => Destination(
        airport: json["Airport"] == null ? null : Airport.fromJson(json["Airport"]),
        arrTime: json["ArrTime"] == null ? null : DateTime.parse(json["ArrTime"]),
    );

    Map<String, dynamic> toJson() => {
        "Airport": airport?.toJson(),
        "ArrTime": arrTime?.toIso8601String(),
    };
}

class Airport {
    final String? airportCode;
    final String? airportName;
    final String? terminal;
    final String? cityCode;
    final String? cityName;
    final String? countryCode;
    final String? countryName;

    Airport({
        this.airportCode,
        this.airportName,
        this.terminal,
        this.cityCode,
        this.cityName,
        this.countryCode,
        this.countryName,
    });

    factory Airport.fromJson(Map<String, dynamic> json) => Airport(
        airportCode: json["AirportCode"],
        airportName: json["AirportName"],
        terminal: json["Terminal"],
        cityCode: json["CityCode"],
        cityName: json["CityName"],
        countryCode: json["CountryCode"],
        countryName: json["CountryName"],
    );

    Map<String, dynamic> toJson() => {
        "AirportCode": airportCode,
        "AirportName": airportName,
        "Terminal": terminal,
        "CityCode": cityCode,
        "CityName": cityName,
        "CountryCode": countryCode,
        "CountryName": countryName,
    };
}

class Origin {
    final Airport? airport;
    final DateTime? depTime;

    Origin({
        this.airport,
        this.depTime,
    });

    factory Origin.fromJson(Map<String, dynamic> json) => Origin(
        airport: json["Airport"] == null ? null : Airport.fromJson(json["Airport"]),
        depTime: json["DepTime"] == null ? null : DateTime.parse(json["DepTime"]),
    );

    Map<String, dynamic> toJson() => {
        "Airport": airport?.toJson(),
        "DepTime": depTime?.toIso8601String(),
    };
}
