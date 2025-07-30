class FlightTicketRequestRound {
  final String userEmail;
  final String userPhone;
  final bool isLcc;
  final bool isLccIb;
  final String type;
  final String traceId;
  final String resultIndex;
  final String resultIndex2;
  final List<Passenger> passengers;

  FlightTicketRequestRound( {
    required this.userEmail,
    required this.userPhone,
    required this.isLcc,
    required this.isLccIb,
    required this.type,
    required this.traceId,
    required this.resultIndex,
    required this.resultIndex2,
    required this.passengers,
  });

  Map<String, dynamic> toJson() => {
    "IsLCC": isLcc,
    "IsLCCIB": isLccIb,
    'UserEmail': userEmail,
    'UserPhone': userPhone,
    'Type': type,
    "TraceId": traceId,
    "ResultIndex": resultIndex,
    "ResultIndexIB": resultIndex2,
    "Passengers": passengers.map((e) => e.toJson()).toList(),
  };
}

class Passenger {
  final String title;
  final String firstName;
  final String lastName;
  final int paxType;
  final String dateOfBirth;
  final int gender;
  final String addressLine1;
  final String passportNo;
  final String passportExpiry;
  final Fare fare;
  final Fare fareIb;
  final List<SeatDynamic> seatDynamic;
  final List<SeatDynamic> seatDynamicIb;
  final List<Baggage> baggage;
  final List<Baggage> baggageIb;
  final List<MealDynamic> mealDynamic;
  final List<MealDynamic> mealDynamicIb;
  final String city;
  final String countryCode;
  final String countryName;
  final String nationality;
  final String contactNo;
  final String email;
  final bool isLeadPax;
  final String ffAirlineCode;
  final String ffNumber;
  final String gstCompanyAddress;
  final String gstCompanyContactNumber;
  final String gstCompanyName;
  final String gstNumber;
  final String gstCompanyEmail;

  Passenger({
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.paxType,
    required this.dateOfBirth,
    required this.gender,
    required this.addressLine1,
    required this.passportNo,
    required this.passportExpiry,
    required this.fare,
    required this.fareIb,
    required this.seatDynamic,
    required this.seatDynamicIb,
    required this.baggage,
    required this.baggageIb,
    required this.mealDynamic,
    required this.mealDynamicIb,
    required this.city,
    required this.countryCode,
    required this.countryName,
    required this.nationality,
    required this.contactNo,
    required this.email,
    required this.isLeadPax,
    required this.ffAirlineCode,
    required this.ffNumber,
    required this.gstCompanyAddress,
    required this.gstCompanyContactNumber,
    required this.gstCompanyName,
    required this.gstNumber,
    required this.gstCompanyEmail,
  });

  Map<String, dynamic> toJson() => {
    "Title": title,
    "FirstName": firstName,
    "LastName": lastName,
    "PaxType": paxType,
    "DateOfBirth": dateOfBirth,
    "Gender": gender,
    "AddressLine1": addressLine1,
    "PassportNo": passportNo,
    "PassportExpiry": passportExpiry,
    "Fare": fare.toJson(),
    "FareIB": fare.toJson(),
    "SeatDynamic": seatDynamic.map((e) => e.toJson()).toList(),
    "SeatDynamicIB": seatDynamicIb.map((e) => e.toJson()).toList(),
    "Baggage": baggage.map((e) => e.toJson()).toList(),
    "BaggageIB": baggageIb.map((e) => e.toJson()).toList(),
    "MealDynamic": mealDynamic.map((e) => e.toJson()).toList(),
    "MealDynamicIB": mealDynamicIb.map((e) => e.toJson()).toList(),
    "City": city,
    "CountryCode": countryCode,
    "CountryName": countryName,
    "Nationality": nationality,
    "ContactNo": contactNo,
    "Email": email,
    "IsLeadPax": isLeadPax,
    "FFAirlineCode": ffAirlineCode,
    "FFNumber": ffNumber,
    "GSTCompanyAddress": gstCompanyAddress,
    "GSTCompanyContactNumber": gstCompanyContactNumber,
    "GSTCompanyName": gstCompanyName,
    "GSTNumber": gstNumber,
    "GSTCompanyEmail": gstCompanyEmail,
  };
}

class SeatDynamic {
  final String airlineCode;
  final String flightNumber;
  final String craftType;
  final String origin;
  final String destination;
  final int availablityType;
  final int description;
  final String code;
  final String rowNo;
  final String? seatNo;
  final int seatType;
  final int seatWayType;
  final int compartment;
  final int deck;
  final String currency;
  final double price;

  SeatDynamic({
    required this.airlineCode,
    required this.flightNumber,
    required this.craftType,
    required this.origin,
    required this.destination,
    required this.availablityType,
    required this.description,
    required this.code,
    required this.rowNo,
    this.seatNo,
    required this.seatType,
    required this.seatWayType,
    required this.compartment,
    required this.deck,
    required this.currency,
    required this.price,
  });

  // ✅ Add this method
  static SeatDynamic empty() => SeatDynamic(
    airlineCode: '',
    flightNumber: '',
    craftType: '',
    origin: '',
    destination: '',
    availablityType: 0,
    description: 0,
    code: '',
    rowNo: '',
    seatNo: '',
    seatType: 0,
    seatWayType: 0,
    compartment: 0,
    deck: 0,
    currency: '',
    price: 0.0,
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

class Baggage {
  final String airlineCode;
  final String flightNumber;
  final int wayType;
  final String code;
  final int description;
  final int weight;
  final String currency;
  final double price;
  final String origin;
  final String destination;

  Baggage({
    required this.airlineCode,
    required this.flightNumber,
    required this.wayType,
    required this.code,
    required this.description,
    required this.weight,
    required this.currency,
    required this.price,
    required this.origin,
    required this.destination,
  });

  factory Baggage.empty() {
    return Baggage(
      airlineCode: '',
      flightNumber: '',
      wayType: 0,
      code: '',
      description: 0,
      weight: 0,
      currency: 'INR',
      price: 0.0,
      origin: '',
      destination: '',
    );
  }

  factory Baggage.fromJson(Map<String, dynamic> json) {
    return Baggage(
      airlineCode: json['AirlineCode'],
      flightNumber: json['FlightNumber'],
      wayType: json['WayType'],
      code: json['Code'],
      description: json['Description'],
      weight: json['Weight'],
      currency: json['Currency'],
      price: (json['Price'] as num).toDouble(),
      origin: json['Origin'],
      destination: json['Destination'],
    );
  }

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
  };
}

class MealDynamic {
  final String airlineCode;
  final String flightNumber;
  final int wayType;
  final String code;
  final int description;
  final String airlineDescription;
  final int quantity;
  final String currency;
  final double price;
  final String origin;
  final String destination;

  MealDynamic({
    required this.airlineCode,
    required this.flightNumber,
    required this.wayType,
    required this.code,
    required this.description,
    required this.airlineDescription,
    required this.quantity,
    required this.currency,
    required this.price,
    required this.origin,
    required this.destination,
  });

  factory MealDynamic.empty() {
    return MealDynamic(
      airlineCode: '',
      flightNumber: '',
      wayType: 0,
      code: '',
      description: 0,
      airlineDescription: '',
      quantity: 0,
      currency: 'INR',
      price: 0.0,
      origin: '',
      destination: '',
    );
  }


  factory MealDynamic.fromJson(Map<String, dynamic> json) {
    return MealDynamic(
      airlineCode: json['AirlineCode'],
      flightNumber: json['FlightNumber'],
      wayType: json['WayType'],
      code: json['Code'],
      description: json['Description'],
      airlineDescription: json['AirlineDescription'] ?? '',
      quantity: json['Quantity'],
      currency: json['Currency'],
      price: (json['Price'] as num).toDouble(),
      origin: json['Origin'],
      destination: json['Destination'],
    );
  }

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

class FlightTicketResponseRound {
  final bool success;
  final String message;
  final ResponseData data;

  FlightTicketResponseRound({
    required this.success,
    required this.message,
    required this.data,
  });

  factory FlightTicketResponseRound.fromJson(Map<String, dynamic> json) =>
      FlightTicketResponseRound(
        success: json['success'] ?? false,
        message: json['message'] ?? '',
        data: ResponseData.fromJson(json['data'] ?? {}),
      );
}


// class ResponseData {
//   final bool b2B2BStatus;
//   // final ErrorData error;
//   final int responseStatus;
//   final String traceId;
//   final Response response;
//   final Inbound inbound;    // <-- include inbound here
//
//   ResponseData({
//     required this.b2B2BStatus,
//     // required this.error,
//     required this.responseStatus,
//     required this.traceId,
//     required this.response,
//     required this.inbound,
//   });
//
//   factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
//     b2B2BStatus: json['B2B2BStatus'],
//     // error: ErrorData.fromJson(json['Error']),
//     responseStatus: json['ResponseStatus'],
//     traceId: json['TraceId'],
//     response: Response.fromJson(json['Response']),
//     inbound: Inbound.fromJson(json['Inbound']),
//   );
// }

class ResponseData {
  final bool b2B2BStatus;
  final int responseStatus;
  final String traceId;
  final Response response;
  final Inbound inbound;

  ResponseData({
    required this.b2B2BStatus,
    required this.responseStatus,
    required this.traceId,
    required this.response,
    required this.inbound,
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
    b2B2BStatus: json['B2B2BStatus'] ?? false,
    responseStatus: json['ResponseStatus'] ?? 0,
    traceId: json['TraceId'] ?? '',
    response: Response.fromJson(json['Response'] ?? {}),
    inbound: Inbound.fromJson(json['Inbound'] ?? {}),
  );
}

class Inbound {
  bool b2B2BStatus;
  // Error error;
  int responseStatus;
  String traceId;
  Response response;

  Inbound({
    required this.b2B2BStatus,
    // required this.error,
    required this.responseStatus,
    required this.traceId,
    required this.response,
  });

  factory Inbound.fromJson(Map<String, dynamic> json) {
    return Inbound(
      b2B2BStatus: json['B2B2BStatus'] ?? false,
      responseStatus: json['ResponseStatus'] ?? 0,
      traceId: json['TraceId'] ?? '',
      response: Response.fromJson(json['Response'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
    'B2B2BStatus': b2B2BStatus,
    // 'Error': error.toJson(),
    'ResponseStatus': responseStatus,
    'TraceId': traceId,
    'Response': response,
  };
}

class Response {
  String pnr;
  int bookingId;
  bool ssrDenied;
  dynamic ssrMessage;
  int status;
  bool isPriceChanged;
  bool isTimeChanged;
  int ticketStatus;

  Response({
    required this.pnr,
    required this.bookingId,
    required this.ssrDenied,
    required this.ssrMessage,
    required this.status,
    required this.isPriceChanged,
    required this.isTimeChanged,
    required this.ticketStatus,
  });

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      pnr: json['PNR'] ?? "",
      bookingId: json['BookingId'] ?? 0,
      ssrDenied: json['SsrDenied'] ?? false,           // default false if null
      ssrMessage: json['SsrMessage'],
      status: json['Status'] ?? 0,
      isPriceChanged: json['IsPriceChanged'] ?? false, // default false if null
      isTimeChanged: json['IsTimeChanged'] ?? false,   // default false if null
      ticketStatus: json['TicketStatus'] ?? 0,
    );
  }
}

class TaxBreakup {
  final String key;
  final double value;

  TaxBreakup({required this.key, required this.value});

  Map<String, dynamic> toJson() => {
    "key": key,
    "value": value,
  };
}

class ChargeBU {
  final String key;
  final double value;

  ChargeBU({required this.key, required this.value});

  Map<String, dynamic> toJson() => {
    "key": key,
    "value": value,
  };
}

class Fare {
  final String currency;
  final double baseFare;
  final double tax;
  final List<TaxBreakup> taxBreakup;
  final double yqTax;
  final double additionalTxnFeeOfrd;
  final double additionalTxnFeePub;
  final double pgCharge;
  final double otherCharges;
  final List<ChargeBU> chargeBU;
  final double discount;
  final double publishedFare;
  final double commissionEarned;
  final double plbEarned;
  final double incentiveEarned;
  final double offeredFare;
  final double tdsOnCommission;
  final double tdsOnPLB;
  final double tdsOnIncentive;
  final double serviceFee;
  final double totalBaggageCharges;
  final double totalMealCharges;
  final double totalSeatCharges;
  final double totalSpecialServiceCharges;

  Fare({
    required this.currency,
    required this.baseFare,
    required this.tax,
    required this.taxBreakup,
    required this.yqTax,
    required this.additionalTxnFeeOfrd,
    required this.additionalTxnFeePub,
    required this.pgCharge,
    required this.otherCharges,
    required this.chargeBU,
    required this.discount,
    required this.publishedFare,
    required this.commissionEarned,
    required this.plbEarned,
    required this.incentiveEarned,
    required this.offeredFare,
    required this.tdsOnCommission,
    required this.tdsOnPLB,
    required this.tdsOnIncentive,
    required this.serviceFee,
    required this.totalBaggageCharges,
    required this.totalMealCharges,
    required this.totalSeatCharges,
    required this.totalSpecialServiceCharges,
  });

  factory Fare.fromJson(Map<String, dynamic> json) => Fare(
    currency: json["Currency"],
    baseFare: (json["BaseFare"] as num).toDouble(),
    tax: (json["Tax"] as num).toDouble(),
    taxBreakup: (json["TaxBreakup"] as List)
        .map((e) => TaxBreakup(
      key: e["key"],
      value: (e["value"] as num).toDouble(),
    ))
        .toList(),
    yqTax: (json["YQTax"] as num).toDouble(),
    additionalTxnFeeOfrd: (json["AdditionalTxnFeeOfrd"] as num).toDouble(),
    additionalTxnFeePub: (json["AdditionalTxnFeePub"] as num).toDouble(),
    pgCharge: (json["PGCharge"] as num).toDouble(),
    otherCharges: (json["OtherCharges"] as num).toDouble(),
    chargeBU: (json["ChargeBU"] as List)
        .map((e) => ChargeBU(
      key: e["key"],
      value: (e["value"] as num).toDouble(),
    ))
        .toList(),
    discount: (json["Discount"] as num).toDouble(),
    publishedFare: (json["PublishedFare"] as num).toDouble(),
    commissionEarned: (json["CommissionEarned"] as num).toDouble(),
    plbEarned: (json["PLBEarned"] as num).toDouble(),
    incentiveEarned: (json["IncentiveEarned"] as num).toDouble(),
    offeredFare: (json["OfferedFare"] as num).toDouble(),
    tdsOnCommission: (json["TdsOnCommission"] as num).toDouble(),
    tdsOnPLB: (json["TdsOnPLB"] as num).toDouble(),
    tdsOnIncentive: (json["TdsOnIncentive"] as num).toDouble(),
    serviceFee: (json["ServiceFee"] as num).toDouble(),
    totalBaggageCharges: (json["TotalBaggageCharges"] as num).toDouble(),
    totalMealCharges: (json["TotalMealCharges"] as num).toDouble(),
    totalSeatCharges: (json["TotalSeatCharges"] as num).toDouble(),
    totalSpecialServiceCharges:
    (json["TotalSpecialServiceCharges"] as num).toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "ServiceFeeDisplayType": 0,
    "Currency": currency,
    "BaseFare": baseFare,
    "Tax": tax,
    "TaxBreakup": taxBreakup.map((e) => e.toJson()).toList(),
    "YQTax": yqTax,
    "AdditionalTxnFeeOfrd": additionalTxnFeeOfrd,
    "AdditionalTxnFeePub": additionalTxnFeePub,
    "PGCharge": pgCharge,
    "OtherCharges": otherCharges,
    "ChargeBU": chargeBU.map((e) => e.toJson()).toList(),
    "Discount": discount,
    "PublishedFare": publishedFare,
    "CommissionEarned": commissionEarned,
    "PLBEarned": plbEarned,
    "IncentiveEarned": incentiveEarned,
    "OfferedFare": offeredFare,
    "TdsOnCommission": tdsOnCommission,
    "TdsOnPLB": tdsOnPLB,
    "TdsOnIncentive": tdsOnIncentive,
    "ServiceFee": serviceFee,
    "TotalBaggageCharges": totalBaggageCharges,
    "TotalMealCharges": totalMealCharges,
    "TotalSeatCharges": totalSeatCharges,
    "TotalSpecialServiceCharges": totalSpecialServiceCharges,
  };
}
