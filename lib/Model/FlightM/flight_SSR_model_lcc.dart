// To parse this JSON data, do
//
//     final flightSsrModelLcc = flightSsrModelLccFromJson(jsonString);

import 'dart:convert';
class FlightSsrLccRequest {
  final Map<String, dynamic> fare;
  final String traceId;
  final String resultIndex;

  FlightSsrLccRequest({
    required this.traceId,
    required this.resultIndex,
    required this.fare,
  });

  Map<String, dynamic> toJson() {
    return {
      'TraceId': traceId,
      'ResultIndex': resultIndex,
    };
  }
}
FlightSsrModelLcc flightSsrModelLccFromJson(String str) => FlightSsrModelLcc.fromJson(json.decode(str));

String flightSsrModelLccToJson(FlightSsrModelLcc data) => json.encode(data.toJson());

class FlightSsrModelLcc {
  final bool? success;
  final String? message;
  final Data? data;

  FlightSsrModelLcc({
    this.success,
    this.message,
    this.data,
  });

  factory FlightSsrModelLcc.fromJson(Map<String, dynamic> json) => FlightSsrModelLcc(
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
  final int? responseStatus;
  final Error? error;
  final String? traceId;
  final List<List<Baggage>>? baggage;
  final List<List<MealDynamic>>? mealDynamic;
  final List<SeatDynamic>? seatDynamic;
  final List<SpecialService>? specialServices;

  Data({
    this.responseStatus,
    this.error,
    this.traceId,
    this.baggage,
    this.mealDynamic,
    this.seatDynamic,
    this.specialServices,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    responseStatus: json["ResponseStatus"],
    error: json["Error"] == null ? null : Error.fromJson(json["Error"]),
    traceId: json["TraceId"],
    baggage: json["Baggage"] == null ? [] : List<List<Baggage>>.from(json["Baggage"]!.map((x) => List<Baggage>.from(x.map((x) => Baggage.fromJson(x))))),
    mealDynamic: json["MealDynamic"] == null
        ? []
        : List<List<MealDynamic>>.from(
        json["MealDynamic"]!.map(
                (x) => List<MealDynamic>.from(x.map((x) => MealDynamic.fromJson(x)))
        )
    ),
    seatDynamic: json["SeatDynamic"] == null ? [] : List<SeatDynamic>.from(json["SeatDynamic"]!.map((x) => SeatDynamic.fromJson(x))),
    specialServices: json["SpecialServices"] == null ? [] : List<SpecialService>.from(json["SpecialServices"]!.map((x) => SpecialService.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ResponseStatus": responseStatus,
    "Error": error?.toJson(),
    "TraceId": traceId,
    "Baggage": baggage == null ? [] : List<dynamic>.from(baggage!.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
    "MealDynamic": mealDynamic == null ? [] : List<dynamic>.from(mealDynamic!.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
    "SeatDynamic": seatDynamic == null ? [] : List<dynamic>.from(seatDynamic!.map((x) => x.toJson())),
    "SpecialServices": specialServices == null ? [] : List<dynamic>.from(specialServices!.map((x) => x.toJson())),
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
  final String? airlineDescription;
  final int? quantity;

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
    this.airlineDescription,
    this.quantity,
  });

  factory Baggage.fromJson(Map<String, dynamic> json) => Baggage(
    airlineCode: json["AirlineCode"],
    flightNumber: json["FlightNumber"],
    wayType: json["WayType"],
    code: json["Code"],
    description: json["Description"],
    weight: json["Weight"],
    currency: json["Currency"],
    price: json["Price"],
    origin: json["Origin"],
    destination: json["Destination"],
    airlineDescription: json["AirlineDescription"],
    quantity: json["Quantity"],
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
    "AirlineDescription": airlineDescription,
    "Quantity": quantity,
  };
}

class MealDynamic {
  final String? airlineCode;
  final String? flightNumber;
  final int? wayType;
  final String? code;
  final int? description;
  final String? airlineDescription;
  final int? quantity;
  final String? currency;
  final int? price;
  final String? origin;
  final String? destination;

  MealDynamic({
    this.airlineCode,
    this.flightNumber,
    this.wayType,
    this.code,
    this.description,
    this.airlineDescription,
    this.quantity,
    this.currency,
    this.price,
    this.origin,
    this.destination,
  });

  factory MealDynamic.fromJson(Map<String, dynamic> json) => MealDynamic(
    airlineCode: json["AirlineCode"],
    flightNumber: json["FlightNumber"],
    wayType: json["WayType"],
    code: json["Code"],
    description: json["Description"],
    airlineDescription: json["AirlineDescription"],
    quantity: json["Quantity"],
    currency: json["Currency"],
    price: json["Price"],
    origin: json["Origin"],
    destination: json["Destination"],
  );

  Map<String, dynamic> toJson() => {
    "AirlineCode": airlineCode,
    "FlightNumber": flightNumber,
    "WayType": wayType,
    "Code": code,
    "Description": description,
    "AirlineDescription": airlineDescription,
    "Quantity": quantity,
    "Currency": currency,
    "Price": price,
    "Origin": origin,
    "Destination": destination,
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

class SeatDynamic {
  final List<SegmentSeat>? segmentSeat;

  SeatDynamic({
    this.segmentSeat,
  });

  factory SeatDynamic.fromJson(Map<String, dynamic> json) => SeatDynamic(
    segmentSeat: json["SegmentSeat"] == null ? [] : List<SegmentSeat>.from(json["SegmentSeat"]!.map((x) => SegmentSeat.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "SegmentSeat": segmentSeat == null ? [] : List<dynamic>.from(segmentSeat!.map((x) => x.toJson())),
  };
}

class SegmentSeat {
  final List<RowSeat>? rowSeats;

  SegmentSeat({
    this.rowSeats,
  });

  factory SegmentSeat.fromJson(Map<String, dynamic> json) => SegmentSeat(
    rowSeats: json["RowSeats"] == null ? [] : List<RowSeat>.from(json["RowSeats"]!.map((x) => RowSeat.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "RowSeats": rowSeats == null ? [] : List<dynamic>.from(rowSeats!.map((x) => x.toJson())),
  };
}

class RowSeat {
  final List<Seat>? seats;

  RowSeat({
    this.seats,
  });

  factory RowSeat.fromJson(Map<String, dynamic> json) => RowSeat(
    seats: json["Seats"] == null ? [] : List<Seat>.from(json["Seats"]!.map((x) => Seat.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Seats": seats == null ? [] : List<dynamic>.from(seats!.map((x) => x.toJson())),
  };
}

class Seat {
  final String? airlineCode;
  final String? flightNumber;
  final String? craftType;
  final String? origin;
  final String? destination;
  final int? availablityType;
  final int? description;
  final String? code;
  final String? rowNo;
  final String? seatNo;
  final int? seatType;
  final int? seatWayType;
  final int? compartment;
  final int? deck;
  final String? currency;
  final int? price;

  Seat({
    this.airlineCode,
    this.flightNumber,
    this.craftType,
    this.origin,
    this.destination,
    this.availablityType,
    this.description,
    this.code,
    this.rowNo,
    this.seatNo,
    this.seatType,
    this.seatWayType,
    this.compartment,
    this.deck,
    this.currency,
    this.price,
  });

  factory Seat.fromJson(Map<String, dynamic> json) => Seat(
    airlineCode: json["AirlineCode"],
    flightNumber: json["FlightNumber"],
    craftType: json["CraftType"],
    origin: json["Origin"],
    destination: json["Destination"],
    availablityType: json["AvailablityType"],
    description: json["Description"],
    code: json["Code"],
    rowNo: json["RowNo"],
    seatNo: json["SeatNo"],
    seatType: json["SeatType"],
    seatWayType: json["SeatWayType"],
    compartment: json["Compartment"],
    deck: json["Deck"],
    currency: json["Currency"],
    price: json["Price"],
  );

  Map<String, dynamic> toJson() => {
    "AirlineCode": airlineCode,
    "FlightNumber": flightNumber,
    "CraftType": craftType,
    "Origin": origin,
    "Destination": destination,
    "AvailablityType": availablityType,
    "Description": description,
    "Code": code,
    "RowNo": rowNo,
    "SeatNo": seatNo,
    "SeatType": seatType,
    "SeatWayType": seatWayType,
    "Compartment": compartment,
    "Deck": deck,
    "Currency": currency,
    "Price": price,
  };
}

class SpecialService {
  final List<SegmentSpecialService>? segmentSpecialService;

  SpecialService({
    this.segmentSpecialService,
  });

  factory SpecialService.fromJson(Map<String, dynamic> json) => SpecialService(
    segmentSpecialService: json["SegmentSpecialService"] == null ? [] : List<SegmentSpecialService>.from(json["SegmentSpecialService"]!.map((x) => SegmentSpecialService.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "SegmentSpecialService": segmentSpecialService == null ? [] : List<dynamic>.from(segmentSpecialService!.map((x) => x.toJson())),
  };
}

class SegmentSpecialService {
  final List<SsrService>? ssrService;

  SegmentSpecialService({
    this.ssrService,
  });

  factory SegmentSpecialService.fromJson(Map<String, dynamic> json) => SegmentSpecialService(
    ssrService: json["SSRService"] == null ? [] : List<SsrService>.from(json["SSRService"]!.map((x) => SsrService.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "SSRService": ssrService == null ? [] : List<dynamic>.from(ssrService!.map((x) => x.toJson())),
  };
}

class SsrService {
  final String? origin;
  final String? destination;
  final DateTime? departureTime;
  final String? airlineCode;
  final String? flightNumber;
  final String? code;
  final int? serviceType;
  final String? text;
  final int? wayType;
  final String? currency;
  final int? price;

  SsrService({
    this.origin,
    this.destination,
    this.departureTime,
    this.airlineCode,
    this.flightNumber,
    this.code,
    this.serviceType,
    this.text,
    this.wayType,
    this.currency,
    this.price,
  });

  factory SsrService.fromJson(Map<String, dynamic> json) => SsrService(
    origin: json["Origin"],
    destination: json["Destination"],
    departureTime: json["DepartureTime"] == null ? null : DateTime.parse(json["DepartureTime"]),
    airlineCode: json["AirlineCode"],
    flightNumber: json["FlightNumber"],
    code: json["Code"],
    serviceType: json["ServiceType"],
    text: json["Text"],
    wayType: json["WayType"],
    currency: json["Currency"],
    price: json["Price"],
  );

  Map<String, dynamic> toJson() => {
    "Origin": origin,
    "Destination": destination,
    "DepartureTime": departureTime?.toIso8601String(),
    "AirlineCode": airlineCode,
    "FlightNumber": flightNumber,
    "Code": code,
    "ServiceType": serviceType,
    "Text": text,
    "WayType": wayType,
    "Currency": currency,
    "Price": price,
  };
}
