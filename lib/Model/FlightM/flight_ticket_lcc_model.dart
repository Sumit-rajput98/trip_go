class FlightTicketRequest {
  final bool isLcc;
  final String? userEmail;
  final String? userPhone;
  final String? type;
  final String traceId;
  final String resultIndex;
  final List<Passenger> passengers;
  final List<SeatDynamic> seatDynamic;
  final List<BaggageDynamic>? baggageDynamic;
  final List<MealDynamic>? mealDynamic;

  FlightTicketRequest({
    required this.isLcc,
     this.userEmail,
    this.userPhone,
    this.type,
    required this.traceId,
    required this.resultIndex,
    required this.passengers,
    required this.seatDynamic,
    this.baggageDynamic,
    this.mealDynamic,
  });

  Map<String, dynamic> toJson() => {
    'IsLCC': isLcc,
    'UserEmail': userEmail,
    'UserPhone': userPhone,
    "Type":type,
    "TraceId": traceId,
    "ResultIndex": resultIndex,
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
  final List<SeatDynamic> seatDynamic;
  final List<BaggageDynamic>? baggageDynamic;
  final List<MealDynamic>? mealDynamic;

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
    required this.city,
    required this.countryCode,
    required this.countryName,
    required this.nationality,
    required this.contactNo,
    required this.email,
    required this.isLeadPax,
    required this.ffAirlineCode,
    required this.ffNumber,
    required this.seatDynamic,
    this.baggageDynamic,
    this.mealDynamic,
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
    "City": city,
    "CountryCode": countryCode,
    "CountryName": countryName,
    "Nationality": nationality,
    "ContactNo": contactNo,
    "Email": email,
    "IsLeadPax": isLeadPax,
    "FFAirlineCode": ffAirlineCode,
    "FFNumber": ffNumber,
    "SeatDynamic": seatDynamic.map((e) => e.toJson()).toList(),
    "Baggage": baggageDynamic?.map((e) => e.toJson()).toList(),
    "MealDynamic": mealDynamic?.map((e) => e.toJson()).toList(),
    "GSTCompanyAddress": gstCompanyAddress,
    "GSTCompanyContactNumber": gstCompanyContactNumber,
    "GSTCompanyName": gstCompanyName,
    "GSTNumber": gstNumber,
    "GSTCompanyEmail": gstCompanyEmail,
  };
}

class MealDynamic {
  final String airlineCode;
  final String flightNumber;
  final int wayType;
  final String code;
  final dynamic description; // Can be int or string
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

  factory MealDynamic.fromJson(Map<String, dynamic> json) {
    return MealDynamic(
      airlineCode: json['AirlineCode'] ?? '',
      flightNumber: json['FlightNumber'] ?? '',
      wayType: json['WayType'] ?? 0,
      code: json['Code'] ?? '',
      description: json['Description'],
      airlineDescription: json['AirlineDescription'] ?? '',
      quantity: json['Quantity'] ?? 0,
      currency: json['Currency'] ?? '',
      price: (json['Price'] as num?)?.toDouble() ?? 0.0,
      origin: json['Origin'] ?? '',
      destination: json['Destination'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'AirlineCode': airlineCode,
      'FlightNumber': flightNumber,
      'WayType': wayType,
      'Code': code,
      'Description': description,
      'AirlineDescription': airlineDescription,
      'Quantity': quantity,
      'Currency': currency,
      'Price': price,
      'Origin': origin,
      'Destination': destination,
    };
  }
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

class BaggageDynamic {
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

  BaggageDynamic({
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

  Map<String, dynamic> toJson() {
    return {
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

  factory BaggageDynamic.fromJson(Map<String, dynamic> json) {
    return BaggageDynamic(
      airlineCode: json['AirlineCode'] ?? '',
      flightNumber: json['FlightNumber'] ?? '',
      wayType: json['WayType'] ?? 0,
      code: json['Code'] ?? '',
      description: json['Description'] ?? 0,
      weight: json['Weight'] ?? 0,
      currency: json['Currency'] ?? '',
      price: (json['Price'] as num?)?.toDouble() ?? 0.0,
      origin: json['Origin'] ?? '',
      destination: json['Destination'] ?? '',
    );
  }
}

class FlightTicketResponse {
  final bool success;
  final String message;
  final ResponseData data;

  FlightTicketResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory FlightTicketResponse.fromJson(Map<String, dynamic> json) =>
      FlightTicketResponse(
        success: json['success'],
        message: json['message'],
        data: ResponseData.fromJson(json['data']),
      );
}

class ResponseData {
  final int responseStatus;
  final String traceId;
  final String pnr;
  final int bookingId;

  ResponseData({
    required this.responseStatus,
    required this.traceId,
    required this.pnr,
    required this.bookingId,
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
    responseStatus: json['ResponseStatus'],
    traceId: json['TraceId'],
    pnr: json['Response']['PNR'],
    bookingId: json['Response']['BookingId'],
  );
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
