import 'dart:convert';
class FlightQuoteRequest {
  final String traceId;
  final String resultIndex;

  FlightQuoteRequest({
    required this.traceId,
    required this.resultIndex,
  });

  Map<String, dynamic> toJson() {
    return {
      'TraceId': traceId,
      'ResultIndex': resultIndex,
    };
  }
}
// To parse this JSON data, do
//
//     final flightQuoteModel = flightQuoteModelFromJson(jsonString);



FlightQuoteModel flightQuoteModelFromJson(String str) => FlightQuoteModel.fromJson(json.decode(str));

String flightQuoteModelToJson(FlightQuoteModel data) => json.encode(data.toJson());

class FlightQuoteModel {
  final bool? success;
  final String? message;
  final Data? data;

  FlightQuoteModel({
    this.success,
    this.message,
    this.data,
  });

  factory FlightQuoteModel.fromJson(Map<String, dynamic> json) => FlightQuoteModel(
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
  final dynamic flightDetailChangeInfo;
  final bool? isPriceChanged;
  final int? responseStatus;
  final Results? results;
  final String? traceId;

  Data({
    this.error,
    this.flightDetailChangeInfo,
    this.isPriceChanged,
    this.responseStatus,
    this.results,
    this.traceId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    error: json["Error"] == null ? null : Error.fromJson(json["Error"]),
    flightDetailChangeInfo: json["FlightDetailChangeInfo"],
    isPriceChanged: json["IsPriceChanged"],
    responseStatus: json["ResponseStatus"],
    results: json["Results"] == null ? null : Results.fromJson(json["Results"]),
    traceId: json["TraceId"],
  );

  Map<String, dynamic> toJson() => {
    "Error": error?.toJson(),
    "FlightDetailChangeInfo": flightDetailChangeInfo,
    "IsPriceChanged": isPriceChanged,
    "ResponseStatus": responseStatus,
    "Results": results?.toJson(),
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

class Results {
  final List<dynamic>? fareInclusions;
  final String? firstNameFormat;
  final bool? isBookableIfSeatNotAvailable;
  final bool? isFreeMealAvailable;
  final bool? isHoldAllowedWithSsr;
  final bool? isHoldMandatoryWithSsr;
  final String? lastNameFormat;
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
  final String? airlineRemark;
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
  final ResultsFareClassification? fareClassification;

  Results({
    this.fareInclusions,
    this.firstNameFormat,
    this.isBookableIfSeatNotAvailable,
    this.isFreeMealAvailable,
    this.isHoldAllowedWithSsr,
    this.isHoldMandatoryWithSsr,
    this.lastNameFormat,
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
    this.fareClassification,
  });

  factory Results.fromJson(Map<String, dynamic> json) => Results(
    fareInclusions: json["FareInclusions"] == null ? [] : List<dynamic>.from(json["FareInclusions"]!.map((x) => x)),
    firstNameFormat: json["FirstNameFormat"],
    isBookableIfSeatNotAvailable: json["IsBookableIfSeatNotAvailable"],
    isFreeMealAvailable: json["IsFreeMealAvailable"],
    isHoldAllowedWithSsr: json["IsHoldAllowedWithSSR"],
    isHoldMandatoryWithSsr: json["IsHoldMandatoryWithSSR"],
    lastNameFormat: json["LastNameFormat"],
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
    fareClassification: json["FareClassification"] == null ? null : ResultsFareClassification.fromJson(json["FareClassification"]),
  );

  Map<String, dynamic> toJson() => {
    "FareInclusions": fareInclusions == null ? [] : List<dynamic>.from(fareInclusions!.map((x) => x)),
    "FirstNameFormat": firstNameFormat,
    "IsBookableIfSeatNotAvailable": isBookableIfSeatNotAvailable,
    "IsFreeMealAvailable": isFreeMealAvailable,
    "IsHoldAllowedWithSSR": isHoldAllowedWithSsr,
    "IsHoldMandatoryWithSSR": isHoldMandatoryWithSsr,
    "LastNameFormat": lastNameFormat,
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
  final double? otherCharges;
  final List<ChargeBu>? chargeBu;
  final int? discount;
  final double? publishedFare;
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
    serviceFeeDisplayType: json["ServiceFeeDisplayType"],
    currency: json["Currency"],
    baseFare: json["BaseFare"],
    tax: json["Tax"],
    taxBreakup: json["TaxBreakup"] == null ? [] : List<ChargeBu>.from(json["TaxBreakup"]!.map((x) => ChargeBu.fromJson(x))),
    yqTax: json["YQTax"],
    additionalTxnFeeOfrd: json["AdditionalTxnFeeOfrd"],
    additionalTxnFeePub: json["AdditionalTxnFeePub"],
    pgCharge: json["PGCharge"],
    otherCharges: json["OtherCharges"]?.toDouble(),
    chargeBu: json["ChargeBU"] == null ? [] : List<ChargeBu>.from(json["ChargeBU"]!.map((x) => ChargeBu.fromJson(x))),
    discount: json["Discount"],
    publishedFare: json["PublishedFare"]?.toDouble(),
    commissionEarned: json["CommissionEarned"]?.toDouble(),
    plbEarned: json["PLBEarned"]?.toDouble(),
    incentiveEarned: json["IncentiveEarned"]?.toDouble(),
    offeredFare: json["OfferedFare"]?.toDouble(),
    tdsOnCommission: json["TdsOnCommission"]?.toDouble(),
    tdsOnPlb: json["TdsOnPLB"]?.toDouble(),
    tdsOnIncentive: json["TdsOnIncentive"]?.toDouble(),
    serviceFee: json["ServiceFee"],
    totalBaggageCharges: json["TotalBaggageCharges"],
    totalMealCharges: json["TotalMealCharges"],
    totalSeatCharges: json["TotalSeatCharges"],
    totalSpecialServiceCharges: json["TotalSpecialServiceCharges"],
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
  };
}

class ChargeBu {
  final String? key;
  final double? value;

  ChargeBu({
    this.key,
    this.value,
  });

  factory ChargeBu.fromJson(Map<String, dynamic> json) => ChargeBu(
    key: json["key"],
    value: json["value"]?.toDouble(),
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
    passengerType: json["PassengerType"],
    passengerCount: json["PassengerCount"],
    baseFare: json["BaseFare"],
    tax: json["Tax"],
    taxBreakUp: json["TaxBreakUp"] == null ? [] : List<ChargeBu>.from(json["TaxBreakUp"]!.map((x) => ChargeBu.fromJson(x))),
    yqTax: json["YQTax"],
    additionalTxnFeeOfrd: json["AdditionalTxnFeeOfrd"],
    additionalTxnFeePub: json["AdditionalTxnFeePub"],
    pgCharge: json["PGCharge"],
    supplierReissueCharges: json["SupplierReissueCharges"],
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

class ResultsFareClassification {
  final String? color;
  final String? type;

  ResultsFareClassification({
    this.color,
    this.type,
  });

  factory ResultsFareClassification.fromJson(Map<String, dynamic> json) => ResultsFareClassification(
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
  final String? fareRestriction;
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
    cabinClass: json["CabinClass"],
    supplierFareClass: json["SupplierFareClass"],
    tripIndicator: json["TripIndicator"],
    segmentIndicator: json["SegmentIndicator"],
    airline: json["Airline"] == null ? null : Airline.fromJson(json["Airline"]),
    origin: json["Origin"] == null ? null : Origin.fromJson(json["Origin"]),
    destination: json["Destination"] == null ? null : Destination.fromJson(json["Destination"]),
    duration: json["Duration"],
    groundTime: json["GroundTime"],
    mile: json["Mile"],
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
