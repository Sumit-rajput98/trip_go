// To parse this JSON data, do
//
//     final flightSearchModel = flightSearchModelFromJson(jsonString);

import 'dart:convert';

FlightSearchModel flightSearchModelFromJson(String str) => FlightSearchModel.fromJson(json.decode(str));

String flightSearchModelToJson(FlightSearchModel data) => json.encode(data.toJson());

class FlightSearchModel {
  bool success;
  String message;
  Data data;

  FlightSearchModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory FlightSearchModel.fromJson(Map<String, dynamic> json) => FlightSearchModel(
    success: json["success"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  int resultRecommendationType;
  int responseStatus;
  Error error;
  String traceId;
  OriginEnum origin;
  String destination;
  List<List<Result>> results;

  Data({
    required this.resultRecommendationType,
    required this.responseStatus,
    required this.error,
    required this.traceId,
    required this.origin,
    required this.destination,
    required this.results,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    resultRecommendationType: json["ResultRecommendationType"],
    responseStatus: json["ResponseStatus"],
    error: Error.fromJson(json["Error"]),
    traceId: json["TraceId"],
    origin: originEnumValues.map[json["Origin"]]!,
    destination: json["Destination"],
    results: List<List<Result>>.from(json["Results"].map((x) => List<Result>.from(x.map((x) => Result.fromJson(x))))),
  );

  Map<String, dynamic> toJson() => {
    "ResultRecommendationType": resultRecommendationType,
    "ResponseStatus": responseStatus,
    "Error": error.toJson(),
    "TraceId": traceId,
    "Origin": originEnumValues.reverse[origin],
    "Destination": destination,
    "Results": List<dynamic>.from(results.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
  };
}

class Error {
  int errorCode;
  String errorMessage;

  Error({
    required this.errorCode,
    required this.errorMessage,
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

enum OriginEnum {
  AMS,
  DEL,
  FCO,
  MUC,
  MXP
}

final originEnumValues = EnumValues({
  "AMS": OriginEnum.AMS,
  "DEL": OriginEnum.DEL,
  "FCO": OriginEnum.FCO,
  "MUC": OriginEnum.MUC,
  "MXP": OriginEnum.MXP
});

class Result {
  List<dynamic> fareInclusions;
  dynamic firstNameFormat;
  bool isBookableIfSeatNotAvailable;
  bool isFreeMealAvailable;
  bool isHoldAllowedWithSsr;
  bool isHoldMandatoryWithSsr;
  bool isUpsellAllowed;
  dynamic lastNameFormat;
  String resultIndex;
  int source;
  bool isLcc;
  bool isRefundable;
  bool isPanRequiredAtBook;
  bool isPanRequiredAtTicket;
  bool isPassportRequiredAtBook;
  bool isPassportRequiredAtTicket;
  bool gstAllowed;
  bool isCouponAppilcable;
  bool isGstMandatory;
  dynamic airlineRemark;
  bool isPassportFullDetailRequiredAtBook;
  ResultFareType resultFareType;
  Fare fare;
  List<FareBreakdown> fareBreakdown;
  List<List<Segment>> segments;
  LastTicketDate lastTicketDate;
  String ticketAdvisory;
  List<FareRule> fareRules;
  PenaltyCharges penaltyCharges;
  AirlineCode airlineCode;
  List<List<MiniFareRule>> miniFareRules;
  ValidatingAirline validatingAirline;
  ResultFareClassification fareClassification;

  Result({
    required this.fareInclusions,
    required this.firstNameFormat,
    required this.isBookableIfSeatNotAvailable,
    required this.isFreeMealAvailable,
    required this.isHoldAllowedWithSsr,
    required this.isHoldMandatoryWithSsr,
    required this.isUpsellAllowed,
    required this.lastNameFormat,
    required this.resultIndex,
    required this.source,
    required this.isLcc,
    required this.isRefundable,
    required this.isPanRequiredAtBook,
    required this.isPanRequiredAtTicket,
    required this.isPassportRequiredAtBook,
    required this.isPassportRequiredAtTicket,
    required this.gstAllowed,
    required this.isCouponAppilcable,
    required this.isGstMandatory,
    required this.airlineRemark,
    required this.isPassportFullDetailRequiredAtBook,
    required this.resultFareType,
    required this.fare,
    required this.fareBreakdown,
    required this.segments,
    required this.lastTicketDate,
    required this.ticketAdvisory,
    required this.fareRules,
    required this.penaltyCharges,
    required this.airlineCode,
    required this.miniFareRules,
    required this.validatingAirline,
    required this.fareClassification,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    fareInclusions: List<dynamic>.from(json["FareInclusions"].map((x) => x)),
    firstNameFormat: json["FirstNameFormat"],
    airlineRemark: json["AirlineRemark"],
    resultIndex: json["ResultIndex"],
    source: json["Source"],
    lastNameFormat: json["LastNameFormat"],
    isBookableIfSeatNotAvailable: json["IsBookableIfSeatNotAvailable"]?? false,
    isFreeMealAvailable: json["IsFreeMealAvailable"] ?? false,
    isHoldAllowedWithSsr: json["IsHoldAllowedWithSSR"] ?? false,
    isHoldMandatoryWithSsr: json["IsHoldMandatoryWithSSR"] ?? false,
    isUpsellAllowed: json["IsUpsellAllowed"] ?? false,
    isLcc: json["IsLCC"] ?? false,
    isRefundable: json["IsRefundable"] ?? false,
    isPanRequiredAtBook: json["IsPanRequiredAtBook"] ?? false,
    isPanRequiredAtTicket: json["IsPanRequiredAtTicket"] ?? false,
    isPassportRequiredAtBook: json["IsPassportRequiredAtBook"] ?? false,
    isPassportRequiredAtTicket: json["IsPassportRequiredAtTicket"] ?? false,
    gstAllowed: json["GSTAllowed"] ?? false,
    isCouponAppilcable: json["IsCouponAppilcable"] ?? false,
    isGstMandatory: json["IsGSTMandatory"] ?? false,
    isPassportFullDetailRequiredAtBook: json["IsPassportFullDetailRequiredAtBook"] ?? false,
    resultFareType: resultFareTypeValues.map[json["ResultFareType"]]!,
    fare: Fare.fromJson(json["Fare"]),
    fareBreakdown: List<FareBreakdown>.from(json["FareBreakdown"].map((x) => FareBreakdown.fromJson(x))),
    segments: List<List<Segment>>.from(json["Segments"].map((x) => List<Segment>.from(x.map((x) => Segment.fromJson(x))))),
    lastTicketDate: lastTicketDateValues.map[json["LastTicketDate"]]!,
    ticketAdvisory: json["TicketAdvisory"],
    fareRules: List<FareRule>.from(json["FareRules"].map((x) => FareRule.fromJson(x))),
    penaltyCharges: PenaltyCharges.fromJson(json["PenaltyCharges"]),
    airlineCode: airlineCodeValues.map[json["AirlineCode"]]!,
    miniFareRules: List<List<MiniFareRule>>.from(json["MiniFareRules"].map((x) => List<MiniFareRule>.from(x.map((x) => MiniFareRule.fromJson(x))))),
    validatingAirline: validatingAirlineValues.map[json["ValidatingAirline"]]!,
    fareClassification: ResultFareClassification.fromJson(json["FareClassification"]),
  );

  Map<String, dynamic> toJson() => {
    "FareInclusions": List<dynamic>.from(fareInclusions.map((x) => x)),
    "FirstNameFormat": firstNameFormat,
    "IsBookableIfSeatNotAvailable": isBookableIfSeatNotAvailable,
    "IsFreeMealAvailable": isFreeMealAvailable,
    "IsHoldAllowedWithSSR": isHoldAllowedWithSsr,
    "IsHoldMandatoryWithSSR": isHoldMandatoryWithSsr,
    "IsUpsellAllowed": isUpsellAllowed,
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
    "ResultFareType": resultFareTypeValues.reverse[resultFareType],
    "Fare": fare.toJson(),
    "FareBreakdown": List<dynamic>.from(fareBreakdown.map((x) => x.toJson())),
    "Segments": List<dynamic>.from(segments.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
    "LastTicketDate": lastTicketDateValues.reverse[lastTicketDate],
    "TicketAdvisory": ticketAdvisory,
    "FareRules": List<dynamic>.from(fareRules.map((x) => x.toJson())),
    "PenaltyCharges": penaltyCharges.toJson(),
    "AirlineCode": airlineCodeValues.reverse[airlineCode],
    "MiniFareRules": List<dynamic>.from(miniFareRules.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
    "ValidatingAirline": validatingAirlineValues.reverse[validatingAirline],
    "FareClassification": fareClassification.toJson(),
  };
}

enum AirlineCode {
  AZ,
  LH,
  YY
}

final airlineCodeValues = EnumValues({
  "AZ": AirlineCode.AZ,
  "LH": AirlineCode.LH,
  "YY": AirlineCode.YY
});

class Fare {
  int serviceFeeDisplayType;
  Currency currency;
  int baseFare;
  int tax;
  List<ChargeBu> taxBreakup;
  int yqTax;
  int additionalTxnFeeOfrd;
  int additionalTxnFeePub;
  int pgCharge;
  int otherCharges;
  List<ChargeBu> chargeBu;
  int discount;
  int publishedFare;
  double commissionEarned;
  double plbEarned;
  double incentiveEarned;
  double offeredFare;
  double tdsOnCommission;
  double tdsOnPlb;
  double tdsOnIncentive;
  int serviceFee;
  int totalBaggageCharges;
  int totalMealCharges;
  int totalSeatCharges;
  int totalSpecialServiceCharges;

  Fare({
    required this.serviceFeeDisplayType,
    required this.currency,
    required this.baseFare,
    required this.tax,
    required this.taxBreakup,
    required this.yqTax,
    required this.additionalTxnFeeOfrd,
    required this.additionalTxnFeePub,
    required this.pgCharge,
    required this.otherCharges,
    required this.chargeBu,
    required this.discount,
    required this.publishedFare,
    required this.commissionEarned,
    required this.plbEarned,
    required this.incentiveEarned,
    required this.offeredFare,
    required this.tdsOnCommission,
    required this.tdsOnPlb,
    required this.tdsOnIncentive,
    required this.serviceFee,
    required this.totalBaggageCharges,
    required this.totalMealCharges,
    required this.totalSeatCharges,
    required this.totalSpecialServiceCharges,
  });

  factory Fare.fromJson(Map<String, dynamic> json) => Fare(
    serviceFeeDisplayType: json["ServiceFeeDisplayType"],
    currency: currencyValues.map[json["Currency"]]!,
    baseFare: json["BaseFare"],
    tax: json["Tax"],
    taxBreakup: json["TaxBreakup"] == null
        ? []
        : List<ChargeBu>.from(json["TaxBreakup"].map((x) => ChargeBu.fromJson(x))),
    yqTax: json["YQTax"],
    additionalTxnFeeOfrd: json["AdditionalTxnFeeOfrd"],
    additionalTxnFeePub: json["AdditionalTxnFeePub"],
    pgCharge: json["PGCharge"],
    otherCharges: json["OtherCharges"],
    chargeBu: List<ChargeBu>.from(json["ChargeBU"].map((x) => ChargeBu.fromJson(x))),
    discount: json["Discount"],
    publishedFare: json["PublishedFare"],
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
    "Currency": currencyValues.reverse[currency],
    "BaseFare": baseFare,
    "Tax": tax,
    "TaxBreakup": List<dynamic>.from(taxBreakup.map((x) => x.toJson())),
    "YQTax": yqTax,
    "AdditionalTxnFeeOfrd": additionalTxnFeeOfrd,
    "AdditionalTxnFeePub": additionalTxnFeePub,
    "PGCharge": pgCharge,
    "OtherCharges": otherCharges,
    "ChargeBU": List<dynamic>.from(chargeBu.map((x) => x.toJson())),
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
  Key key;
  int value;

  ChargeBu({
    required this.key,
    required this.value,
  });

  factory ChargeBu.fromJson(Map<String, dynamic> json) => ChargeBu(
    key: keyValues.map[json["key"]]!,
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "key": keyValues.reverse[key],
    "value": value,
  };
}

enum Key {
  CONVENIENCECHARGE,
  GLOBALPROCUREMENTCHARGE,
  IN_TAX,
  K3,
  OTHERCHARGE,
  OTHER_TAXES,
  PSF,
  TBOMARKUP,
  TRANSACTION_FEE,
  UDF,
  YQ_TAX,
  YR
}

final keyValues = EnumValues({
  "CONVENIENCECHARGE": Key.CONVENIENCECHARGE,
  "GLOBALPROCUREMENTCHARGE": Key.GLOBALPROCUREMENTCHARGE,
  "INTax": Key.IN_TAX,
  "K3": Key.K3,
  "OTHERCHARGE": Key.OTHERCHARGE,
  "OtherTaxes": Key.OTHER_TAXES,
  "PSF": Key.PSF,
  "TBOMARKUP": Key.TBOMARKUP,
  "TransactionFee": Key.TRANSACTION_FEE,
  "UDF": Key.UDF,
  "YQTax": Key.YQ_TAX,
  "YR": Key.YR
});

enum Currency {
  INR
}

final currencyValues = EnumValues({
  "INR": Currency.INR
});

class FareBreakdown {
  Currency currency;
  int passengerType;
  int passengerCount;
  int baseFare;
  int tax;
  List<ChargeBu> taxBreakUp;
  int yqTax;
  int additionalTxnFeeOfrd;
  int additionalTxnFeePub;
  int pgCharge;
  int supplierReissueCharges;

  FareBreakdown({
    required this.currency,
    required this.passengerType,
    required this.passengerCount,
    required this.baseFare,
    required this.tax,
    required this.taxBreakUp,
    required this.yqTax,
    required this.additionalTxnFeeOfrd,
    required this.additionalTxnFeePub,
    required this.pgCharge,
    required this.supplierReissueCharges,
  });

  factory FareBreakdown.fromJson(Map<String, dynamic> json) => FareBreakdown(
    currency: currencyValues.map[json["Currency"]]!,
    passengerType: json["PassengerType"],
    passengerCount: json["PassengerCount"],
    baseFare: json["BaseFare"],
    tax: json["Tax"],
    taxBreakUp: List<ChargeBu>.from(json["TaxBreakUp"].map((x) => ChargeBu.fromJson(x))),
    yqTax: json["YQTax"],
    additionalTxnFeeOfrd: json["AdditionalTxnFeeOfrd"],
    additionalTxnFeePub: json["AdditionalTxnFeePub"],
    pgCharge: json["PGCharge"],
    supplierReissueCharges: json["SupplierReissueCharges"],
  );

  Map<String, dynamic> toJson() => {
    "Currency": currencyValues.reverse[currency],
    "PassengerType": passengerType,
    "PassengerCount": passengerCount,
    "BaseFare": baseFare,
    "Tax": tax,
    "TaxBreakUp": List<dynamic>.from(taxBreakUp.map((x) => x.toJson())),
    "YQTax": yqTax,
    "AdditionalTxnFeeOfrd": additionalTxnFeeOfrd,
    "AdditionalTxnFeePub": additionalTxnFeePub,
    "PGCharge": pgCharge,
    "SupplierReissueCharges": supplierReissueCharges,
  };
}

class ResultFareClassification {
  Color color;
  FareClassificationType type;

  ResultFareClassification({
    required this.color,
    required this.type,
  });

  factory ResultFareClassification.fromJson(Map<String, dynamic> json) => ResultFareClassification(
    color: colorValues.map[json["Color"]]!,
    type: fareClassificationTypeValues.map[json["Type"]]!,
  );

  Map<String, dynamic> toJson() => {
    "Color": colorValues.reverse[color],
    "Type": fareClassificationTypeValues.reverse[type],
  };
}

enum Color {
  LIGHT_BLUE
}

final colorValues = EnumValues({
  "lightBlue": Color.LIGHT_BLUE
});

enum FareClassificationType {
  PUBLISH
}

final fareClassificationTypeValues = EnumValues({
  "Publish": FareClassificationType.PUBLISH
});

class FareRule {
  OriginEnum origin;
  String destination;
  ValidatingAirline airline;
  FareBasisCode fareBasisCode;
  String fareRuleDetail;
  FareRestriction fareRestriction;
  String fareFamilyCode;
  String fareRuleIndex;

  FareRule({
    required this.origin,
    required this.destination,
    required this.airline,
    required this.fareBasisCode,
    required this.fareRuleDetail,
    required this.fareRestriction,
    required this.fareFamilyCode,
    required this.fareRuleIndex,
  });

  factory FareRule.fromJson(Map<String, dynamic> json) => FareRule(
    origin: originEnumValues.map[json["Origin"]]!,
    destination: json["Destination"],
    airline: validatingAirlineValues.map[json["Airline"]]!,
    fareBasisCode: fareBasisCodeValues.map[json["FareBasisCode"]]!,
    fareRuleDetail: json["FareRuleDetail"],
    fareRestriction: fareRestrictionValues.map[json["FareRestriction"]]!,
    fareFamilyCode: json["FareFamilyCode"],
    fareRuleIndex: json["FareRuleIndex"],
  );

  Map<String, dynamic> toJson() => {
    "Origin": originEnumValues.reverse[origin],
    "Destination": destination,
    "Airline": validatingAirlineValues.reverse[airline],
    "FareBasisCode": fareBasisCodeValues.reverse[fareBasisCode],
    "FareRuleDetail": fareRuleDetail,
    "FareRestriction": fareRestrictionValues.reverse[fareRestriction],
    "FareFamilyCode": fareFamilyCode,
    "FareRuleIndex": fareRuleIndex,
  };
}

enum ValidatingAirline {
  AI,
  AZ,
  KL,
  LH,
  THE_9_B
}

final validatingAirlineValues = EnumValues({
  "AI": ValidatingAirline.AI,
  "AZ": ValidatingAirline.AZ,
  "KL": ValidatingAirline.KL,
  "LH": ValidatingAirline.LH,
  "9B": ValidatingAirline.THE_9_B
});

enum FareBasisCode {
  GL3_YXSDY,
  NCLOWIA,
  SNCOWAA,
  UL3_YXSDY
}

final fareBasisCodeValues = EnumValues({
  "GL3YXSDY": FareBasisCode.GL3_YXSDY,
  "NCLOWIA": FareBasisCode.NCLOWIA,
  "SNCOWAA": FareBasisCode.SNCOWAA,
  "UL3YXSDY": FareBasisCode.UL3_YXSDY
});

enum FareRestriction {
  N,
  Y
}

final fareRestrictionValues = EnumValues({
  "N": FareRestriction.N,
  "Y": FareRestriction.Y
});

enum LastTicketDate {
  THE_10_MAY25,
  THE_25_MAY25
}

final lastTicketDateValues = EnumValues({
  "10MAY25": LastTicketDate.THE_10_MAY25,
  "25MAY25": LastTicketDate.THE_25_MAY25
});

class MiniFareRule {
  String journeyPoints;
  MiniFareRuleType type;
  dynamic from;
  dynamic to;
  dynamic unit;
  String details;
  bool onlineReissueAllowed;
  bool onlineRefundAllowed;

  MiniFareRule({
    required this.journeyPoints,
    required this.type,
    required this.from,
    required this.to,
    required this.unit,
    required this.details,
    required this.onlineReissueAllowed,
    required this.onlineRefundAllowed,
  });

  factory MiniFareRule.fromJson(Map<String, dynamic> json) => MiniFareRule(
    journeyPoints: json["JourneyPoints"],
    type: miniFareRuleTypeValues.map[json["Type"]]!,
    from: json["From"],
    to: json["To"],
    unit: json["Unit"],
    details: json["Details"],
    onlineReissueAllowed: json["OnlineReissueAllowed"],
    onlineRefundAllowed: json["OnlineRefundAllowed"],
  );

  Map<String, dynamic> toJson() => {
    "JourneyPoints": journeyPoints,
    "Type": miniFareRuleTypeValues.reverse[type],
    "From": from,
    "To": to,
    "Unit": unit,
    "Details": details,
    "OnlineReissueAllowed": onlineReissueAllowed,
    "OnlineRefundAllowed": onlineRefundAllowed,
  };
}

enum MiniFareRuleType {
  CANCELLATION,
  REISSUE
}

final miniFareRuleTypeValues = EnumValues({
  "Cancellation": MiniFareRuleType.CANCELLATION,
  "Reissue": MiniFareRuleType.REISSUE
});

class PenaltyCharges {
  ReissueCharge reissueCharge;
  CancellationCharge? cancellationCharge;

  PenaltyCharges({
    required this.reissueCharge,
    this.cancellationCharge,
  });

  factory PenaltyCharges.fromJson(Map<String, dynamic> json) => PenaltyCharges(
    reissueCharge: reissueChargeValues.map[json["ReissueCharge"]]!,
    cancellationCharge: cancellationChargeValues.map[json["CancellationCharge"]]!,
  );

  Map<String, dynamic> toJson() => {
    "ReissueCharge": reissueChargeValues.reverse[reissueCharge],
    "CancellationCharge": cancellationChargeValues.reverse[cancellationCharge],
  };
}

enum CancellationCharge {
  INR_12000,
  INR_18000
}

final cancellationChargeValues = EnumValues({
  "INR 12000*": CancellationCharge.INR_12000,
  "INR 18000*": CancellationCharge.INR_18000
});

enum ReissueCharge {
  INR_14360,
  INR_22000,
  INR_8000
}

final reissueChargeValues = EnumValues({
  "INR 14360*": ReissueCharge.INR_14360,
  "INR 22000*": ReissueCharge.INR_22000,
  "INR 8000*": ReissueCharge.INR_8000
});

enum ResultFareType {
  REGULAR_FARE
}

final resultFareTypeValues = EnumValues({
  "RegularFare": ResultFareType.REGULAR_FARE
});

class Segment {
  Baggage baggage;
  dynamic cabinBaggage;
  int cabinClass;
  dynamic supplierFareClass;
  int tripIndicator;
  int segmentIndicator;
  Airline airline;
  int noOfSeatAvailable;
  OriginClass origin;
  Destination destination;
  int duration;
  int groundTime;
  int mile;
  bool stopOver;
  String flightInfoIndex;
  StopPoint stopPoint;
  DateTime? stopPointArrivalTime;
  DateTime? stopPointDepartureTime;
  String craft;
  String? remark;
  bool isETicketEligible;
  FlightStatus flightStatus;
  String status;
  SegmentFareClassification fareClassification;
  int? accumulatedDuration;

  Segment({
    required this.baggage,
    required this.cabinBaggage,
    required this.cabinClass,
    required this.supplierFareClass,
    required this.tripIndicator,
    required this.segmentIndicator,
    required this.airline,
    required this.noOfSeatAvailable,
    required this.origin,
    required this.destination,
    required this.duration,
    required this.groundTime,
    required this.mile,
    required this.stopOver,
    required this.flightInfoIndex,
    required this.stopPoint,
    required this.stopPointArrivalTime,
    required this.stopPointDepartureTime,
    required this.craft,
    required this.remark,
    required this.isETicketEligible,
    required this.flightStatus,
    required this.status,
    required this.fareClassification,
    this.accumulatedDuration,
  });

  factory Segment.fromJson(Map<String, dynamic> json) => Segment(
    baggage: baggageValues.map[json["Baggage"]]!,
    cabinBaggage: json["CabinBaggage"],
    cabinClass: json["CabinClass"],
    supplierFareClass: json["SupplierFareClass"],
    tripIndicator: json["TripIndicator"],
    segmentIndicator: json["SegmentIndicator"],
    airline: Airline.fromJson(json["Airline"]),
    noOfSeatAvailable: json["NoOfSeatAvailable"],
    origin: OriginClass.fromJson(json["Origin"]),
    destination: Destination.fromJson(json["Destination"]),
    duration: json["Duration"],
    groundTime: json["GroundTime"],
    mile: json["Mile"],
    stopOver: json["StopOver"],
    flightInfoIndex: json["FlightInfoIndex"],
    stopPoint: stopPointValues.map[json["StopPoint"]]!,
    stopPointArrivalTime: json["StopPointArrivalTime"] == null ? null : DateTime.parse(json["StopPointArrivalTime"]),
    stopPointDepartureTime: json["StopPointDepartureTime"] == null ? null : DateTime.parse(json["StopPointDepartureTime"]),
    craft: json["Craft"],
    remark: json["Remark"],
    isETicketEligible: json["IsETicketEligible"],
    flightStatus: flightStatusValues.map[json["FlightStatus"]]!,
    status: json["Status"],
    fareClassification: SegmentFareClassification.fromJson(json["FareClassification"]),
    accumulatedDuration: json["AccumulatedDuration"],
  );

  Map<String, dynamic> toJson() => {
    "Baggage": baggageValues.reverse[baggage],
    "CabinBaggage": cabinBaggage,
    "CabinClass": cabinClass,
    "SupplierFareClass": supplierFareClass,
    "TripIndicator": tripIndicator,
    "SegmentIndicator": segmentIndicator,
    "Airline": airline.toJson(),
    "NoOfSeatAvailable": noOfSeatAvailable,
    "Origin": origin.toJson(),
    "Destination": destination.toJson(),
    "Duration": duration,
    "GroundTime": groundTime,
    "Mile": mile,
    "StopOver": stopOver,
    "FlightInfoIndex": flightInfoIndex,
    "StopPoint": stopPointValues.reverse[stopPoint],
    "StopPointArrivalTime": stopPointArrivalTime?.toIso8601String(),
    "StopPointDepartureTime": stopPointDepartureTime?.toIso8601String(),
    "Craft": craft,
    "Remark": remark,
    "IsETicketEligible": isETicketEligible,
    "FlightStatus": flightStatusValues.reverse[flightStatus],
    "Status": status,
    "FareClassification": fareClassification.toJson(),
    "AccumulatedDuration": accumulatedDuration,
  };
}

class Airline {
  ValidatingAirline airlineCode;
  AirlineName airlineName;
  String flightNumber;
  String fareClass;
  String operatingCarrier;

  Airline({
    required this.airlineCode,
    required this.airlineName,
    required this.flightNumber,
    required this.fareClass,
    required this.operatingCarrier,
  });

  factory Airline.fromJson(Map<String, dynamic> json) => Airline(
    airlineCode: validatingAirlineValues.map[json["AirlineCode"]]!,
    airlineName: airlineNameValues.map[json["AirlineName"]]!,
    flightNumber: json["FlightNumber"],
    fareClass: json["FareClass"],
    operatingCarrier: json["OperatingCarrier"],
  );

  Map<String, dynamic> toJson() => {
    "AirlineCode": validatingAirlineValues.reverse[airlineCode],
    "AirlineName": airlineNameValues.reverse[airlineName],
    "FlightNumber": flightNumber,
    "FareClass": fareClass,
    "OperatingCarrier": operatingCarrier,
  };
}

enum AirlineName {
  ACCESRAIL,
  AIR_INDIA,
  ITA_AIRWAYS,
  KLM_ROYAL_DUTCH,
  LUFTHANSA
}

final airlineNameValues = EnumValues({
  "ACCESRAIL": AirlineName.ACCESRAIL,
  "Air India": AirlineName.AIR_INDIA,
  "ITA Airways": AirlineName.ITA_AIRWAYS,
  "Klm Royal Dutch": AirlineName.KLM_ROYAL_DUTCH,
  "Lufthansa": AirlineName.LUFTHANSA
});

enum Baggage {
  THE_1_PC_S
}

final baggageValues = EnumValues({
  "1 PC(s)": Baggage.THE_1_PC_S
});

class Destination {
  Airport airport;
  DateTime arrTime;

  Destination({
    required this.airport,
    required this.arrTime,
  });

  factory Destination.fromJson(Map<String, dynamic> json) => Destination(
    airport: Airport.fromJson(json["Airport"]),
    arrTime: DateTime.parse(json["ArrTime"]),
  );

  Map<String, dynamic> toJson() => {
    "Airport": airport.toJson(),
    "ArrTime": arrTime.toIso8601String(),
  };
}

class Airport {
  String airportCode;
  AirportName airportName;
  String terminal;
  String cityCode;
  CityName cityName;
  CountryCode countryCode;
  CountryName countryName;

  Airport({
    required this.airportCode,
    required this.airportName,
    required this.terminal,
    required this.cityCode,
    required this.cityName,
    required this.countryCode,
    required this.countryName,
  });

  factory Airport.fromJson(Map<String, dynamic> json) => Airport(
    airportCode: json["AirportCode"],
    airportName: airportNameValues.map[json["AirportName"]]!,
    terminal: json["Terminal"],
    cityCode: json["CityCode"],
    cityName: cityNameValues.map[json["CityName"]]!,
    countryCode: countryCodeValues.map[json["CountryCode"]]!,
    countryName: countryNameValues.map[json["CountryName"]]!,
  );

  Map<String, dynamic> toJson() => {
    "AirportCode": airportCode,
    "AirportName": airportNameValues.reverse[airportName],
    "Terminal": terminal,
    "CityCode": cityCode,
    "CityName": cityNameValues.reverse[cityName],
    "CountryCode": countryCodeValues.reverse[countryCode],
    "CountryName": countryNameValues.reverse[countryName],
  };
}

enum AirportName {
  CRISTOFORO_COLOMBO,
  EMPTY,
  FIUMICINO,
  FRANZ_JOSEF_STRAUSS,
  INDIRA_GANDHI_AIRPORT,
  MALPENSA,
  SCHIPHOL
}

final airportNameValues = EnumValues({
  "Cristoforo Colombo": AirportName.CRISTOFORO_COLOMBO,
  "": AirportName.EMPTY,
  "Fiumicino": AirportName.FIUMICINO,
  "Franz Josef Strauss": AirportName.FRANZ_JOSEF_STRAUSS,
  "Indira Gandhi Airport": AirportName.INDIRA_GANDHI_AIRPORT,
  "Malpensa": AirportName.MALPENSA,
  "Schiphol": AirportName.SCHIPHOL
});

enum CityName {
  AMSTERDAM,
  DELHI,
  EMPTY,
  GENOA,
  MILAN,
  MUNICH,
  ROME
}

final cityNameValues = EnumValues({
  "Amsterdam": CityName.AMSTERDAM,
  "Delhi": CityName.DELHI,
  "": CityName.EMPTY,
  "Genoa": CityName.GENOA,
  "Milan": CityName.MILAN,
  "Munich": CityName.MUNICH,
  "Rome": CityName.ROME
});

enum CountryCode {
  DE,
  EMPTY,
  IN,
  IT,
  NL
}

final countryCodeValues = EnumValues({
  "DE": CountryCode.DE,
  "": CountryCode.EMPTY,
  "IN": CountryCode.IN,
  "IT": CountryCode.IT,
  "NL": CountryCode.NL
});

enum CountryName {
  EMPTY,
  GERMANY,
  INDIA,
  ITALY,
  NETHERLANDS
}

final countryNameValues = EnumValues({
  "": CountryName.EMPTY,
  "Germany": CountryName.GERMANY,
  "India": CountryName.INDIA,
  "Italy": CountryName.ITALY,
  "Netherlands": CountryName.NETHERLANDS
});

class SegmentFareClassification {
  String type;

  SegmentFareClassification({
    required this.type,
  });

  factory SegmentFareClassification.fromJson(Map<String, dynamic> json) => SegmentFareClassification(
    type: json["Type"],
  );

  Map<String, dynamic> toJson() => {
    "Type": type,
  };
}

enum FlightStatus {
  CONFIRMED
}

final flightStatusValues = EnumValues({
  "Confirmed": FlightStatus.CONFIRMED
});

class OriginClass {
  Airport airport;
  DateTime depTime;

  OriginClass({
    required this.airport,
    required this.depTime,
  });

  factory OriginClass.fromJson(Map<String, dynamic> json) => OriginClass(
    airport: Airport.fromJson(json["Airport"]),
    depTime: DateTime.parse(json["DepTime"]),
  );

  Map<String, dynamic> toJson() => {
    "Airport": airport.toJson(),
    "DepTime": depTime.toIso8601String(),
  };
}

enum StopPoint {
  EMPTY,
  XIK,
  XRJ
}

final stopPointValues = EnumValues({
  "": StopPoint.EMPTY,
  "XIK": StopPoint.XIK,
  "XRJ": StopPoint.XRJ
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
