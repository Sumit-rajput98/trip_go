import 'dart:convert';

class FareRulesRequest {
  final String traceId;
  final String resultIndex;

  FareRulesRequest({
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

FareRulesModel fareRulesModelFromJson(String str) => FareRulesModel.fromJson(json.decode(str));

String fareRulesModelToJson(FareRulesModel data) => json.encode(data.toJson());

class FareRulesModel {
  final bool? success;
  final String? message;
  final Data? data;

  FareRulesModel({
    this.success,
    this.message,
    this.data,
  });

  factory FareRulesModel.fromJson(Map<String, dynamic> json) => FareRulesModel(
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
  final List<FareRule>? fareRules;
  final int? responseStatus;
  final String? traceId;

  Data({
    this.error,
    this.fareRules,
    this.responseStatus,
    this.traceId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    error: json["Error"] == null ? null : Error.fromJson(json["Error"]),
    fareRules: json["FareRules"] == null ? [] : List<FareRule>.from(json["FareRules"]!.map((x) => FareRule.fromJson(x))),
    responseStatus: json["ResponseStatus"],
    traceId: json["TraceId"],
  );

  Map<String, dynamic> toJson() => {
    "Error": error?.toJson(),
    "FareRules": fareRules == null ? [] : List<dynamic>.from(fareRules!.map((x) => x.toJson())),
    "ResponseStatus": responseStatus,
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

class FareRule {
  final String? airline;
  final DateTime? departureTime;
  final String? destination;
  final String? fareBasisCode;
  final List<String>? fareInclusions;
  final dynamic fareRestriction;
  final String? fareRuleDetail;
  final int? flightId;
  final String? origin;
  final DateTime? returnDate;

  FareRule({
    this.airline,
    this.departureTime,
    this.destination,
    this.fareBasisCode,
    this.fareInclusions,
    this.fareRestriction,
    this.fareRuleDetail,
    this.flightId,
    this.origin,
    this.returnDate,
  });

  factory FareRule.fromJson(Map<String, dynamic> json) => FareRule(
    airline: json["Airline"],
    departureTime: json["DepartureTime"] == null ? null : DateTime.parse(json["DepartureTime"]),
    destination: json["Destination"],
    fareBasisCode: json["FareBasisCode"],
    fareInclusions: json["FareInclusions"] == null ? [] : List<String>.from(json["FareInclusions"]!.map((x) => x)),
    fareRestriction: json["FareRestriction"],
    fareRuleDetail: json["FareRuleDetail"],
    flightId: json["FlightId"],
    origin: json["Origin"],
    returnDate: json["ReturnDate"] == null ? null : DateTime.parse(json["ReturnDate"]),
  );

  Map<String, dynamic> toJson() => {
    "Airline": airline,
    "DepartureTime": departureTime?.toIso8601String(),
    "Destination": destination,
    "FareBasisCode": fareBasisCode,
    "FareInclusions": fareInclusions == null ? [] : List<dynamic>.from(fareInclusions!.map((x) => x)),
    "FareRestriction": fareRestriction,
    "FareRuleDetail": fareRuleDetail,
    "FlightId": flightId,
    "Origin": origin,
    "ReturnDate": returnDate?.toIso8601String(),
  };
}
