import 'dart:convert';

UpsellModel upsellModelFromJson(String str) => UpsellModel.fromJson(json.decode(str));

String upsellModelToJson(UpsellModel data) => json.encode(data.toJson());

class UpsellModel {
    final bool? success;
    final String? message;
    final Data? data;

    UpsellModel({
        this.success,
        this.message,
        this.data,
    });

    factory UpsellModel.fromJson(Map<String, dynamic> json) => UpsellModel(
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
    final Error? error;
    final int? responseStatus;
    final List<Result>? results;
    final String? traceId;

    Data({
        this.error,
        this.responseStatus,
        this.results,
        this.traceId,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        error: json["Error"] == null ? null : Error.fromJson(json["Error"]),
        responseStatus: json["ResponseStatus"],
        results: json["Results"] == null ? [] : List<Result>.from(json["Results"]!.map((x) => Result.fromJson(x))),
        traceId: json["TraceId"],
    );

    Map<String, dynamic> toJson() => {
        "Error": error?.toJson(),
        "ResponseStatus": responseStatus,
        "Results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
        "TraceId": traceId,
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

class Result {
    final List<dynamic>? fareInclusions;
    final dynamic firstNameFormat;
    final bool? isBookableIfSeatNotAvailable;
    final bool? isFreeMealAvailable;
    final bool? isHoldAllowedWithSsr;
    final bool? isHoldMandatoryWithSsr;
    final dynamic lastNameFormat;
    final int? nonStopFirstRanking;
    final int? smartChoiceRanking;
    final String? resultIndex;
    final int? source;
    final bool? isLcc;
    final bool? isRefundable;
    final bool? isPanRequiredAtBook;
    final bool? isPanRequiredAtTicket;
    final bool? isPassportRequiredAtBook;
    final bool? isPassportRequiredAtTicket;
    final bool? gstAllowed;
    final bool? isCouponAppilcable;
    final bool? isGstMandatory;
    final dynamic airlineRemark;
    final bool? isPassportFullDetailRequiredAtBook;
    final String? resultFareType;
    final Fare? fare;
    final List<FareBreakdown>? fareBreakdown;
    final List<List<Segment>>? segments;
    final DateTime? lastTicketDate;
    final dynamic ticketAdvisory;
    final List<FareRule>? fareRules;
    final String? airlineCode;
    final List<List<MiniFareRule>>? miniFareRules;
    final String? validatingAirline;
    final UpsellOptionsList? upsellOptionsList;
    final ResultFareClassification? fareClassification;

    Result({
        this.fareInclusions,
        this.firstNameFormat,
        this.isBookableIfSeatNotAvailable,
        this.isFreeMealAvailable,
        this.isHoldAllowedWithSsr,
        this.isHoldMandatoryWithSsr,
        this.lastNameFormat,
        this.nonStopFirstRanking,
        this.smartChoiceRanking,
        this.resultIndex,
        this.source,
        this.isLcc,
        this.isRefundable,
        this.isPanRequiredAtBook,
        this.isPanRequiredAtTicket,
        this.isPassportRequiredAtBook,
        this.isPassportRequiredAtTicket,
        this.gstAllowed,
        this.isCouponAppilcable,
        this.isGstMandatory,
        this.airlineRemark,
        this.isPassportFullDetailRequiredAtBook,
        this.resultFareType,
        this.fare,
        this.fareBreakdown,
        this.segments,
        this.lastTicketDate,
        this.ticketAdvisory,
        this.fareRules,
        this.airlineCode,
        this.miniFareRules,
        this.validatingAirline,
        this.upsellOptionsList,
        this.fareClassification,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        fareInclusions: json["FareInclusions"] == null ? [] : List<dynamic>.from(json["FareInclusions"]!.map((x) => x)),
        firstNameFormat: json["FirstNameFormat"],
        isBookableIfSeatNotAvailable: json["IsBookableIfSeatNotAvailable"],
        isFreeMealAvailable: json["IsFreeMealAvailable"],
        isHoldAllowedWithSsr: json["IsHoldAllowedWithSSR"],
        isHoldMandatoryWithSsr: json["IsHoldMandatoryWithSSR"],
        lastNameFormat: json["LastNameFormat"],
        nonStopFirstRanking: toInt(json["NonStopFirstRanking"]),
        smartChoiceRanking: toInt(json["SmartChoiceRanking"]),
        resultIndex: json["ResultIndex"],
        source: json["Source"],
        isLcc: json["IsLCC"],
        isRefundable: json["IsRefundable"],
        isPanRequiredAtBook: json["IsPanRequiredAtBook"],
        isPanRequiredAtTicket: json["IsPanRequiredAtTicket"],
        isPassportRequiredAtBook: json["IsPassportRequiredAtBook"],
        isPassportRequiredAtTicket: json["IsPassportRequiredAtTicket"],
        gstAllowed: json["GSTAllowed"],
        isCouponAppilcable: json["IsCouponAppilcable"],
        isGstMandatory: json["IsGSTMandatory"],
        airlineRemark: json["AirlineRemark"],
        isPassportFullDetailRequiredAtBook: json["IsPassportFullDetailRequiredAtBook"],
        resultFareType: json["ResultFareType"],
        fare: json["Fare"] == null ? null : Fare.fromJson(json["Fare"]),
        fareBreakdown: json["FareBreakdown"] == null ? [] : List<FareBreakdown>.from(json["FareBreakdown"]!.map((x) => FareBreakdown.fromJson(x))),
        segments: json["Segments"] == null ? [] : List<List<Segment>>.from(json["Segments"]!.map((x) => List<Segment>.from(x.map((x) => Segment.fromJson(x))))),
        lastTicketDate: json["LastTicketDate"] == null ? null : DateTime.parse(json["LastTicketDate"]),
        ticketAdvisory: json["TicketAdvisory"],
        fareRules: json["FareRules"] == null ? [] : List<FareRule>.from(json["FareRules"]!.map((x) => FareRule.fromJson(x))),
        airlineCode: json["AirlineCode"],
        miniFareRules: json["MiniFareRules"] == null ? [] : List<List<MiniFareRule>>.from(json["MiniFareRules"]!.map((x) => List<MiniFareRule>.from(x.map((x) => MiniFareRule.fromJson(x))))),
        validatingAirline: json["ValidatingAirline"],
        upsellOptionsList: json["UpsellOptionsList"] == null ? null : UpsellOptionsList.fromJson(json["UpsellOptionsList"]),
        fareClassification: json["FareClassification"] == null ? null : ResultFareClassification.fromJson(json["FareClassification"]),
    );

    Map<String, dynamic> toJson() => {
        "FareInclusions": fareInclusions == null ? [] : List<dynamic>.from(fareInclusions!.map((x) => x)),
        "FirstNameFormat": firstNameFormat,
        "IsBookableIfSeatNotAvailable": isBookableIfSeatNotAvailable,
        "IsFreeMealAvailable": isFreeMealAvailable,
        "IsHoldAllowedWithSSR": isHoldAllowedWithSsr,
        "IsHoldMandatoryWithSSR": isHoldMandatoryWithSsr,
        "LastNameFormat": lastNameFormat,
        "NonStopFirstRanking": nonStopFirstRanking,
        "SmartChoiceRanking": smartChoiceRanking,
        "ResultIndex": resultIndex,
        "Source": source,
        "IsLCC": isLcc,
        "IsRefundable": isRefundable,
        "IsPanRequiredAtBook": isPanRequiredAtBook,
        "IsPanRequiredAtTicket": isPanRequiredAtTicket,
        "IsPassportRequiredAtBook": isPassportRequiredAtBook,
        "IsPassportRequiredAtTicket": isPassportRequiredAtTicket,
        "GSTAllowed": gstAllowed,
        "IsCouponAppilcable": isCouponAppilcable,
        "IsGSTMandatory": isGstMandatory,
        "AirlineRemark": airlineRemark,
        "IsPassportFullDetailRequiredAtBook": isPassportFullDetailRequiredAtBook,
        "ResultFareType": resultFareType,
        "Fare": fare?.toJson(),
        "FareBreakdown": fareBreakdown == null ? [] : List<dynamic>.from(fareBreakdown!.map((x) => x.toJson())),
        "Segments": segments == null ? [] : List<dynamic>.from(segments!.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
        "LastTicketDate": lastTicketDate?.toIso8601String(),
        "TicketAdvisory": ticketAdvisory,
        "FareRules": fareRules == null ? [] : List<dynamic>.from(fareRules!.map((x) => x.toJson())),
        "AirlineCode": airlineCode,
        "MiniFareRules": miniFareRules == null ? [] : List<dynamic>.from(miniFareRules!.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
        "ValidatingAirline": validatingAirline,
        "UpsellOptionsList": upsellOptionsList?.toJson(),
        "FareClassification": fareClassification?.toJson(),
    };
}

class Fare {
    final int? serviceFeeDisplayType;
    final String? currency;
    final int? baseFare;
    final int? tax;
    final List<ChargeBu>? taxBreakup;
    final int? yqTax;
    final int? additionalTxnFeeOfrd;
    final int? additionalTxnFeePub;
    final int? pgCharge;
    final int? otherCharges;
    final List<ChargeBu>? chargeBu;
    final int? discount;
    final int? publishedFare;
    final int? commissionEarned;
    final double? plbEarned;
    final int? incentiveEarned;
    final double? offeredFare;
    final double? tdsOnCommission;
    final double? tdsOnPlb;
    final int? tdsOnIncentive;
    final int? serviceFee;
    final int? totalBaggageCharges;
    final int? totalMealCharges;
    final int? totalSeatCharges;
    final int? totalSpecialServiceCharges;
    final int? reissueDifferenceAmount;

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
        this.reissueDifferenceAmount,
    });

    factory Fare.fromJson(Map<String, dynamic> json) => Fare(
        serviceFeeDisplayType: toInt(json["ServiceFeeDisplayType"]),
        currency: json["Currency"],
        baseFare: toInt(json["BaseFare"]),
        tax: toInt(json["Tax"]),
        taxBreakup: json["TaxBreakup"] == null ? [] : List<ChargeBu>.from(json["TaxBreakup"]!.map((x) => ChargeBu.fromJson(x))),
        yqTax: toInt(json["YQTax"]),
        additionalTxnFeeOfrd: toInt(json["AdditionalTxnFeeOfrd"]),
        additionalTxnFeePub: toInt(json["AdditionalTxnFeePub"]),
        pgCharge: toInt(json["PGCharge"]),
        otherCharges: toInt(json["OtherCharges"]),
        chargeBu: json["ChargeBU"] == null ? [] : List<ChargeBu>.from(json["ChargeBU"]!.map((x) => ChargeBu.fromJson(x))),
        discount: toInt(json["Discount"]),
        publishedFare: toInt(json["PublishedFare"]),
        commissionEarned: toInt(json["CommissionEarned"]),
        plbEarned: toDouble(json["PLBEarned"]),
        incentiveEarned: toInt(json["IncentiveEarned"]),
        offeredFare: toDouble(json["OfferedFare"]),
        tdsOnCommission: toDouble(json["TdsOnCommission"]),
        tdsOnPlb: toDouble(json["TdsOnPLB"]),
        tdsOnIncentive: toInt(json["TdsOnIncentive"]),
        serviceFee: toInt(json["ServiceFee"]),
        totalBaggageCharges: toInt(json["TotalBaggageCharges"]),
        totalMealCharges: toInt(json["TotalMealCharges"]),
        totalSeatCharges: toInt(json["TotalSeatCharges"]),
        totalSpecialServiceCharges: toInt(json["TotalSpecialServiceCharges"]),
        reissueDifferenceAmount: toInt(json["ReissueDifferenceAmount"]),
    );

    Map<String, dynamic> toJson() => {
        "ServiceFeeDisplayType": serviceFeeDisplayType,
        "Currency": currency,
        "BaseFare": baseFare,
        "Tax": tax,
        "TaxBreakup": taxBreakup == null ? [] : List<dynamic>.from(taxBreakup!.map((x) => x.toJson())),
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
        "ReissueDifferenceAmount": reissueDifferenceAmount,
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
        value: toInt(json["value"]),
    );

    Map<String, dynamic> toJson() => {
        "key": key,
        "value": value,
    };
}

class FareBreakdown {
    final String? currency;
    final int? passengerType;
    final int? passengerCount;
    final int? baseFare;
    final int? tax;
    final List<ChargeBu>? taxBreakUp;
    final int? yqTax;
    final int? additionalTxnFeeOfrd;
    final int? additionalTxnFeePub;
    final int? pgCharge;
    final int? supplierReissueCharges;

    FareBreakdown({
        this.currency,
        this.passengerType,
        this.passengerCount,
        this.baseFare,
        this.tax,
        this.taxBreakUp,
        this.yqTax,
        this.additionalTxnFeeOfrd,
        this.additionalTxnFeePub,
        this.pgCharge,
        this.supplierReissueCharges,
    });

    factory FareBreakdown.fromJson(Map<String, dynamic> json) => FareBreakdown(
        currency: json["Currency"],
        passengerType: toInt(json["PassengerType"]),
        passengerCount: toInt(json["PassengerCount"]),
        baseFare: toInt(json["BaseFare"]),
        tax: toInt(json["Tax"]),
        taxBreakUp: json["TaxBreakUp"] == null ? [] : List<ChargeBu>.from(json["TaxBreakUp"]!.map((x) => ChargeBu.fromJson(x))),
        yqTax: toInt(json["YQTax"]),
        additionalTxnFeeOfrd: toInt(json["AdditionalTxnFeeOfrd"]),
        additionalTxnFeePub: toInt(json["AdditionalTxnFeePub"]),
        pgCharge: toInt(json["PGCharge"]),
        supplierReissueCharges: toInt(json["SupplierReissueCharges"]),
    );

    Map<String, dynamic> toJson() => {
        "Currency": currency,
        "PassengerType": passengerType,
        "PassengerCount": passengerCount,
        "BaseFare": baseFare,
        "Tax": tax,
        "TaxBreakUp": taxBreakUp == null ? [] : List<dynamic>.from(taxBreakUp!.map((x) => x.toJson())),
        "YQTax": yqTax,
        "AdditionalTxnFeeOfrd": additionalTxnFeeOfrd,
        "AdditionalTxnFeePub": additionalTxnFeePub,
        "PGCharge": pgCharge,
        "SupplierReissueCharges": supplierReissueCharges,
    };
}

class ResultFareClassification {
    final String? color;
    final String? type;

    ResultFareClassification({
        this.color,
        this.type,
    });

    factory ResultFareClassification.fromJson(Map<String, dynamic> json) => ResultFareClassification(
        color: json["Color"],
        type: json["Type"],
    );

    Map<String, dynamic> toJson() => {
        "Color": color,
        "Type": type,
    };
}

class FareRule {
    final String? origin;
    final String? destination;
    final String? airline;
    final String? fareBasisCode;
    final String? fareRuleDetail;
    final dynamic fareRestriction;
    final String? fareFamilyCode;
    final String? fareRuleIndex;

    FareRule({
        this.origin,
        this.destination,
        this.airline,
        this.fareBasisCode,
        this.fareRuleDetail,
        this.fareRestriction,
        this.fareFamilyCode,
        this.fareRuleIndex,
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

class Segment {
    final String? baggage;
    final String? cabinBaggage;
    final int? cabinClass;
    final dynamic supplierFareClass;
    final int? tripIndicator;
    final int? segmentIndicator;
    final Airline? airline;
    final Origin? origin;
    final Destination? destination;
    final int? duration;
    final int? groundTime;
    final int? mile;
    final bool? stopOver;
    final String? flightInfoIndex;
    final String? stopPoint;
    final DateTime? stopPointArrivalTime;
    final DateTime? stopPointDepartureTime;
    final String? craft;
    final dynamic remark;
    final bool? isETicketEligible;
    final String? flightStatus;
    final String? status;
    final SegmentFareClassification? fareClassification;

    Segment({
        this.baggage,
        this.cabinBaggage,
        this.cabinClass,
        this.supplierFareClass,
        this.tripIndicator,
        this.segmentIndicator,
        this.airline,
        this.origin,
        this.destination,
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
        cabinClass: toInt(json["CabinClass"]),
        supplierFareClass: json["SupplierFareClass"],
        tripIndicator: toInt(json["TripIndicator"]),
        segmentIndicator: toInt(json["SegmentIndicator"]),
        airline: json["Airline"] == null ? null : Airline.fromJson(json["Airline"]),
        origin: json["Origin"] == null ? null : Origin.fromJson(json["Origin"]),
        destination: json["Destination"] == null ? null : Destination.fromJson(json["Destination"]),
        duration: toInt(json["Duration"]),
        groundTime: toInt(json["GroundTime"]),
        mile: toInt(json["Mile"]),
        stopOver: json["StopOver"],
        flightInfoIndex: json["FlightInfoIndex"],
        stopPoint: json["StopPoint"],
        stopPointArrivalTime: json["StopPointArrivalTime"] == null ? null : DateTime.parse(json["StopPointArrivalTime"]),
        stopPointDepartureTime: json["StopPointDepartureTime"] == null ? null : DateTime.parse(json["StopPointDepartureTime"]),
        craft: json["Craft"],
        remark: json["Remark"],
        isETicketEligible: json["IsETicketEligible"],
        flightStatus: json["FlightStatus"],
        status: json["Status"],
        fareClassification: json["FareClassification"] == null ? null : SegmentFareClassification.fromJson(json["FareClassification"]),
    );


    Map<String, dynamic> toJson() => {
        "Baggage": baggage,
        "CabinBaggage": cabinBaggage,
        "CabinClass": cabinClass,
        "SupplierFareClass": supplierFareClass,
        "TripIndicator": tripIndicator,
        "SegmentIndicator": segmentIndicator,
        "Airline": airline?.toJson(),
        "Origin": origin?.toJson(),
        "Destination": destination?.toJson(),
        "Duration": duration,
        "GroundTime": groundTime,
        "Mile": mile,
        "StopOver": stopOver,
        "FlightInfoIndex": flightInfoIndex,
        "StopPoint": stopPoint,
        "StopPointArrivalTime": stopPointArrivalTime?.toIso8601String(),
        "StopPointDepartureTime": stopPointDepartureTime?.toIso8601String(),
        "Craft": craft,
        "Remark": remark,
        "IsETicketEligible": isETicketEligible,
        "FlightStatus": flightStatus,
        "Status": status,
        "FareClassification": fareClassification?.toJson(),
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

class SegmentFareClassification {
    final String? type;

    SegmentFareClassification({
        this.type,
    });

    factory SegmentFareClassification.fromJson(Map<String, dynamic> json) => SegmentFareClassification(
        type: json["Type"],
    );

    Map<String, dynamic> toJson() => {
        "Type": type,
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

class UpsellOptionsList {
    final List<UpsellList>? upsellList;

    UpsellOptionsList({
        this.upsellList,
    });

    factory UpsellOptionsList.fromJson(Map<String, dynamic> json) => UpsellOptionsList(
        upsellList: json["UpsellList"] == null ? [] : List<UpsellList>.from(json["UpsellList"]!.map((x) => UpsellList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "UpsellList": upsellList == null ? [] : List<dynamic>.from(upsellList!.map((x) => x.toJson())),
    };
}

class UpsellList {
    final String? fareFamilyCode;
    final String? fareFamilyName;
    final String? fareRuleIndex;
    final String? flightInfoIndex;
    final int? passengerType;
    final List<ServicesList>? servicesList;

    UpsellList({
        this.fareFamilyCode,
        this.fareFamilyName,
        this.fareRuleIndex,
        this.flightInfoIndex,
        this.passengerType,
        this.servicesList,
    });

    factory UpsellList.fromJson(Map<String, dynamic> json) => UpsellList(
        fareFamilyCode: json["FareFamilyCode"],
        fareFamilyName: json["FareFamilyName"],
        fareRuleIndex: json["FareRuleIndex"],
        flightInfoIndex: json["FlightInfoIndex"],
        passengerType: json["PassengerType"],
        servicesList: json["ServicesList"] == null ? [] : List<ServicesList>.from(json["ServicesList"]!.map((x) => ServicesList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "FareFamilyCode": fareFamilyCode,
        "FareFamilyName": fareFamilyName,
        "FareRuleIndex": fareRuleIndex,
        "FlightInfoIndex": flightInfoIndex,
        "PassengerType": passengerType,
        "ServicesList": servicesList == null ? [] : List<dynamic>.from(servicesList!.map((x) => x.toJson())),
    };
}

class ServicesList {
    final String? code;
    final String? isChargeable;
    final String? isIncluded;
    final String? upsellDescription;

    ServicesList({
        this.code,
        this.isChargeable,
        this.isIncluded,
        this.upsellDescription,
    });

    factory ServicesList.fromJson(Map<String, dynamic> json) => ServicesList(
        code: json["Code"],
        isChargeable: json["IsChargeable"],
        isIncluded: json["IsIncluded"],
        upsellDescription: json["UpsellDescription"],
    );

    Map<String, dynamic> toJson() => {
        "Code": code,
        "IsChargeable": isChargeable,
        "IsIncluded": isIncluded,
        "UpsellDescription": upsellDescription,
    };
}
