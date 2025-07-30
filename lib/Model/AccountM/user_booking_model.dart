class UserBookingModel {
  final bool success;
  final String message;
  final List<BookingData> data;

  UserBookingModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory UserBookingModel.fromJson(Map<String, dynamic> json) {
    return UserBookingModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => BookingData.fromJson(e))
          .toList() ??
          [],
    );
  }
}

class BookingData {
  final int id;
  final int? userId;
  final String depart;
  final String arrival;
  final String? returnDepart;
  final String? returnArrival;
  final String? pnr;
  final String? pnrIb;
  final String? departFlight;
  final String? returnFlight;
  final String? source;
  final String? destination;
  final String? fromDate;
  final String? toDate;
  final String? departDate;
  final String? returnDate;
  final String? bookingId;
  final String? traceId;
  final String? policy;
  final String? email;
  final String? mobile;
  final String? createdAt;
  final String? bookingType;
  final int? status;
  final BookingResponse? bookingResponse;
  final FareQuoteIbLog? fareQuoteIbLog;
  final BookingRequest? bookingRequest;
  final PaymentDetail? paymentDetail;

  BookingData({
    required this.id,
    this.userId,
    required this.depart,
    required this.arrival,
    this.returnDepart,
    this.returnArrival,
    this.pnr,
    this.pnrIb,
    this.departFlight,
    this.returnFlight,
    this.source,
    this.destination,
    this.fromDate,
    this.toDate,
    this.departDate,
    this.returnDate,
    this.bookingId,
    this.traceId,
    this.policy,
    this.email,
    this.mobile,
    this.createdAt,
    this.status,
    this.bookingResponse,
    this.bookingType,
    this.fareQuoteIbLog,
    this.bookingRequest,
    this.paymentDetail,
  });

  factory BookingData.fromJson(Map<String, dynamic> json) {
    return BookingData(
      id: json['id'],
      userId: json['user_id'],
      depart: json['depart'] ?? '',
      arrival: json['arrival'] ?? '',
      returnDepart: json['return_depart'],
      returnArrival: json['return_arrival'],
      pnr: json['pnr'],
      pnrIb: json['pnrib'],
      departFlight: json['depart_flight'],
      returnFlight: json['return_flight'],
      source: json['source'],
      destination: json['destination'],
      fromDate: json['from_date'],
      toDate: json['to_date'],
      departDate: json['depart_date'],
      returnDate: json['return_date'],
      bookingId: json['booking_id'],
      traceId: json['trace_id'],
      policy: json['policy'],
      email: json['email'],
      mobile: json['mobile'],
      createdAt: json['created_at'],
      status: json['status'],
      bookingType: json['booking_type'],
      bookingResponse: json['booking_response'] != null
          ? BookingResponse.fromJson(json['booking_response'])
          : null,
      fareQuoteIbLog: json['farequoteib_log'] != null
          ? FareQuoteIbLog.fromJson(json['farequoteib_log'])
          : null,
      bookingRequest: json['booking_request'] != null
          ? BookingRequest.fromJson(json['booking_request'])
          : null,
      paymentDetail: json['payment_detail'] != null
          ? PaymentDetail.fromJson(json['payment_detail'])
          : null,
    );
  }
}

class BookingResponse {
  final bool? b2b2bStatus;
  final ResponseError? error;
  final int? responseStatus;
  final String? traceId;

  BookingResponse({
    this.b2b2bStatus,
    this.error,
    this.responseStatus,
    this.traceId,
  });

  factory BookingResponse.fromJson(Map<String, dynamic> json) {
    return BookingResponse(
      b2b2bStatus: json['B2B2BStatus'],
      error: json['Error'] != null ? ResponseError.fromJson(json['Error']) : null,
      responseStatus: json['ResponseStatus'],
      traceId: json['TraceId'],
    );
  }
}

class ResponseError {
  final int? errorCode;
  final String? errorMessage;

  ResponseError({this.errorCode, this.errorMessage});

  factory ResponseError.fromJson(Map<String, dynamic> json) {
    return ResponseError(
      errorCode: json['ErrorCode'],
      errorMessage: json['ErrorMessage'],
    );
  }
}

class FareQuoteIbLog {
  final ResponseError? error;
  final bool? isPriceChanged;
  final int? responseStatus;
  final FareResult? results;

  FareQuoteIbLog({
    this.error,
    this.isPriceChanged,
    this.responseStatus,
    this.results,
  });

  factory FareQuoteIbLog.fromJson(Map<String, dynamic> json) {
    return FareQuoteIbLog(
      error: json['Error'] != null ? ResponseError.fromJson(json['Error']) : null,
      isPriceChanged: json['IsPriceChanged'],
      responseStatus: json['ResponseStatus'],
      results: json['Results'] != null ? FareResult.fromJson(json['Results']) : null,
    );
  }
}

class FareResult {
  final Fare? fare;
  final List<FareBreakdown>? fareBreakdown;
  final List<List<Segment>>? segments;
  final String? lastTicketDate;
  final String? ticketAdvisory;
  final List<FareRule>? fareRules;
  final List<List<MiniFareRule>>? miniFareRules;
  final String? airlineCode;
  final String? validatingAirline;
  final FareClassification? fareClassification;

  FareResult({
    this.fare,
    this.fareBreakdown,
    this.segments,
    this.lastTicketDate,
    this.ticketAdvisory,
    this.fareRules,
    this.miniFareRules,
    this.airlineCode,
    this.validatingAirline,
    this.fareClassification,
  });

  factory FareResult.fromJson(Map<String, dynamic> json) {
    return FareResult(
      fare: json['Fare'] != null ? Fare.fromJson(json['Fare']) : null,
      fareBreakdown: (json['FareBreakdown'] as List<dynamic>?)
          ?.map((e) => FareBreakdown.fromJson(e))
          .toList() ??
          [],
      segments: (json['Segments'] as List<dynamic>?)
          ?.map<List<Segment>>((segmentList) =>
          (segmentList as List<dynamic>)
              .map((seg) => Segment.fromJson(seg))
              .toList())
          .toList() ??
          [],
      lastTicketDate: json['LastTicketDate'],
      ticketAdvisory: json['TicketAdvisory'],
      fareRules: (json['FareRules'] as List<dynamic>?)
          ?.map((e) => FareRule.fromJson(e))
          .toList() ??
          [],
      miniFareRules: (json['MiniFareRules'] as List<dynamic>?)
          ?.map<List<MiniFareRule>>((group) =>
          (group as List<dynamic>)
              .map((e) => MiniFareRule.fromJson(e))
              .toList())
          .toList() ??
          [],
      airlineCode: json['AirlineCode'],
      validatingAirline: json['ValidatingAirline'],
      fareClassification: json['FareClassification'] != null
          ? FareClassification.fromJson(json['FareClassification'])
          : null,
    );
  }
}

class Fare {
  final String? currency;
  final double? baseFare;
  final double? tax;
  final double? publishedFare;

  Fare({
    this.currency,
    this.baseFare,
    this.tax,
    this.publishedFare,
  });

  factory Fare.fromJson(Map<String, dynamic> json) {
    return Fare(
      currency: json['Currency'],
      baseFare: (json['BaseFare'] as num?)?.toDouble(),
      tax: (json['Tax'] as num?)?.toDouble(),
      publishedFare: (json['PublishedFare'] as num?)?.toDouble(),
    );
  }
}

class FareBreakdown {
  final String? currency;
  final int? passengerType;
  final int? passengerCount;
  final double? baseFare;
  final double? tax;

  FareBreakdown({
    this.currency,
    this.passengerType,
    this.passengerCount,
    this.baseFare,
    this.tax,
  });

  factory FareBreakdown.fromJson(Map<String, dynamic> json) {
    return FareBreakdown(
      currency: json['Currency'],
      passengerType: json['PassengerType'],
      passengerCount: json['PassengerCount'],
      baseFare: (json['BaseFare'] as num?)?.toDouble(),
      tax: (json['Tax'] as num?)?.toDouble(),
    );
  }
}

class Segment {
  final String? baggage;
  final String? cabinBaggage;
  final int? cabinClass;
  final String? supplierFareClass;
  final int? tripIndicator;
  final int? segmentIndicator;
  final Airline? airline;
  final SegmentLocation? origin;
  final SegmentLocation? destination;
  final int? duration;
  final int? groundTime;
  final int? mile;
  final bool? stopOver;
  final String? flightInfoIndex;
  final String? stopPoint;
  final String? stopPointArrivalTime;
  final String? stopPointDepartureTime;
  final String? craft;
  final bool? isETicketEligible;
  final String? flightStatus;
  final String? status;
  final FareClassification? fareClassification;
  final AirportMeta? sourceAirport;
  final AirportMeta? destinationAirport;

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
    this.isETicketEligible,
    this.flightStatus,
    this.status,
    this.fareClassification,
    this.sourceAirport,
    this.destinationAirport,
  });

  factory Segment.fromJson(Map<String, dynamic> json) {
    return Segment(
      baggage: json['Baggage'],
      cabinBaggage: json['CabinBaggage'],
      cabinClass: json['CabinClass'],
      supplierFareClass: json['SupplierFareClass'],
      tripIndicator: json['TripIndicator'],
      segmentIndicator: json['SegmentIndicator'],
      airline:
      json['Airline'] != null ? Airline.fromJson(json['Airline']) : null,
      origin: json['Origin'] != null
          ? SegmentLocation.fromJson(json['Origin'])
          : null,
      destination: json['Destination'] != null
          ? SegmentLocation.fromJson(json['Destination'])
          : null,
      duration: json['Duration'],
      groundTime: json['GroundTime'],
      mile: json['Mile'],
      stopOver: json['StopOver'],
      flightInfoIndex: json['FlightInfoIndex'],
      stopPoint: json['StopPoint'],
      stopPointArrivalTime: json['StopPointArrivalTime'],
      stopPointDepartureTime: json['StopPointDepartureTime'],
      craft: json['Craft'],
      isETicketEligible: json['IsETicketEligible'],
      flightStatus: json['FlightStatus'],
      status: json['Status'],
      fareClassification: json['FareClassification'] != null
          ? FareClassification.fromJson(json['FareClassification'])
          : null,
      sourceAirport: json['SourceAirport'] != null
          ? AirportMeta.fromJson(json['SourceAirport'])
          : null,
      destinationAirport: json['DestinationAirport'] != null
          ? AirportMeta.fromJson(json['DestinationAirport'])
          : null,
    );
  }
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

  factory Airline.fromJson(Map<String, dynamic> json) {
    return Airline(
      airlineCode: json['AirlineCode'],
      airlineName: json['AirlineName'],
      flightNumber: json['FlightNumber'],
      fareClass: json['FareClass'],
      operatingCarrier: json['OperatingCarrier'],
    );
  }
}

class SegmentLocation {
  final AirportDetail? airport;
  final String? time; // DepTime or ArrTime

  SegmentLocation({this.airport, this.time});

  factory SegmentLocation.fromJson(Map<String, dynamic> json) {
    return SegmentLocation(
      airport: json['Airport'] != null
          ? AirportDetail.fromJson(json['Airport'])
          : null,
      time: json['DepTime'] ?? json['ArrTime'],
    );
  }
}

class AirportDetail {
  final String? airportCode;
  final String? airportName;
  final String? terminal;
  final String? cityCode;
  final String? cityName;
  final String? countryCode;
  final String? countryName;

  AirportDetail({
    this.airportCode,
    this.airportName,
    this.terminal,
    this.cityCode,
    this.cityName,
    this.countryCode,
    this.countryName,
  });

  factory AirportDetail.fromJson(Map<String, dynamic> json) {
    return AirportDetail(
      airportCode: json['AirportCode'],
      airportName: json['AirportName'],
      terminal: json['Terminal'],
      cityCode: json['CityCode'],
      cityName: json['CityName'],
      countryCode: json['CountryCode'],
      countryName: json['CountryName'],
    );
  }
}

class FareClassification {
  final String? type;

  FareClassification({this.type});

  factory FareClassification.fromJson(Map<String, dynamic> json) {
    return FareClassification(type: json['Type']);
  }
}

class AirportMeta {
  final int? id;
  final String? airportCode;
  final String? airportName;
  final String? cityCode;
  final String? cityName;
  final String? countryName;
  final String? countryCode;
  final int? topCities;
  final String? createdAt;
  final String? updatedAt;

  AirportMeta({
    this.id,
    this.airportCode,
    this.airportName,
    this.cityCode,
    this.cityName,
    this.countryName,
    this.countryCode,
    this.topCities,
    this.createdAt,
    this.updatedAt,
  });

  factory AirportMeta.fromJson(Map<String, dynamic> json) {
    return AirportMeta(
      id: json['id'],
      airportCode: json['airport_code'],
      airportName: json['airport_name'],
      cityCode: json['city_code'],
      cityName: json['city_name'],
      countryName: json['country_name'],
      countryCode: json['country_code'],
      topCities: json['top_cities'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
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

  factory FareRule.fromJson(Map<String, dynamic> json) {
    return FareRule(
      origin: json['Origin'],
      destination: json['Destination'],
      airline: json['Airline'],
      fareBasisCode: json['FareBasisCode'],
      fareRuleDetail: json['FareRuleDetail'],
      fareRestriction: json['FareRestriction'],
      fareFamilyCode: json['FareFamilyCode'],
      fareRuleIndex: json['FareRuleIndex'],
    );
  }
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

  factory MiniFareRule.fromJson(Map<String, dynamic> json) {
    return MiniFareRule(
      journeyPoints: json['JourneyPoints'],
      type: json['Type'],
      from: json['From'],
      to: json['To'],
      unit: json['Unit'],
      details: json['Details'],
      onlineReissueAllowed: json['OnlineReissueAllowed'],
      onlineRefundAllowed: json['OnlineRefundAllowed'],
    );
  }
}

class BookingRequest {
  final String tokenId;
  final String endUserIp;
  final String? preferredCurrency;
  final String traceId;
  final String resultIndex;
  final List<Passenger> passengers;
  final bool isLCC;
  final String userEmail;
  final String userPhone;
  final String type;

  BookingRequest({
    required this.tokenId,
    required this.endUserIp,
    this.preferredCurrency,
    required this.traceId,
    required this.resultIndex,
    required this.passengers,
    required this.isLCC,
    required this.userEmail,
    required this.userPhone,
    required this.type,
  });

  factory BookingRequest.fromJson(Map<String, dynamic> json) => BookingRequest(
    tokenId: json['TokenId'],
    endUserIp: json['EndUserIp'],
    preferredCurrency: json['PreferredCurrency'],
    traceId: json['TraceId'],
    resultIndex: json['ResultIndex'],
    passengers: (json['Passengers'] as List<dynamic>)
        .map((e) => Passenger.fromJson(e))
        .toList(),
    isLCC: json['IsLCC'],
    userEmail: json['UserEmail'],
    userPhone: json['UserPhone'],
    type: json['Type'],
  );
}

class Passenger {
  final String title;
  final String firstName;
  final String lastName;
  final int paxType;
  final int gender;
  final String addressLine1;
  final Fare fare;
  final List<SeatDynamic> seatDynamic;
  final String countryName;
  final String countryCode;
  final String contactNo;
  final String email;
  final bool isLeadPax;

  Passenger({
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.paxType,
    required this.gender,
    required this.addressLine1,
    required this.fare,
    required this.seatDynamic,
    required this.countryName,
    required this.countryCode,
    required this.contactNo,
    required this.email,
    required this.isLeadPax,
  });

  factory Passenger.fromJson(Map<String, dynamic> json) => Passenger(
    title: json['Title'],
    firstName: json['FirstName'],
    lastName: json['LastName'],
    paxType: json['PaxType'],
    gender: json['Gender'],
    addressLine1: json['AddressLine1'],
    fare: Fare.fromJson(json['Fare']),
    seatDynamic: (json['SeatDynamic'] as List<dynamic>)
        .map((e) => SeatDynamic.fromJson(e))
        .toList(),
    countryName: json['CountryName'],
    countryCode: json['CountryCode'],
    contactNo: json['ContactNo'],
    email: json['Email'],
    isLeadPax: json['IsLeadPax'],
  );
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
  final String seatNo;
  final int seatType;
  final int seatWayType;
  final int compartment;
  final int deck;
  final String currency;
  final int price;

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
    required this.seatNo,
    required this.seatType,
    required this.seatWayType,
    required this.compartment,
    required this.deck,
    required this.currency,
    required this.price,
  });

  factory SeatDynamic.fromJson(Map<String, dynamic> json) => SeatDynamic(
    airlineCode: json['AirlineCode'],
    flightNumber: json['FlightNumber'],
    craftType: json['CraftType'],
    origin: json['Origin'],
    destination: json['Destination'],
    availablityType: json['AvailablityType'],
    description: json['Description'],
    code: json['Code'],
    rowNo: json['RowNo'],
    seatNo: json['SeatNo'],
    seatType: json['SeatType'],
    seatWayType: json['SeatWayType'],
    compartment: json['Compartment'],
    deck: json['Deck'],
    currency: json['Currency'],
    price: json['Price'],
  );
}

class PaymentDetail {
  final int id;
  final int bookingId;
  final double? onwardBaseFare;
  final double? inwardBaseFare;
  final double? serviceFee;
  final double? tax;
  final double? amount;
  final String? markupType;
  final double? markupOb;
  final double? markupIb;
  final double? agentMarkup;
  final double? adminMarkup;
  final double? finalBookingAmount;
  final int? couponId;
  final String? discountType;
  final double? discountAmount;
  final int? status;
  final String? createdAt;
  final String? updatedAt;
  final String? currencyAmount;
  final String? currencySymbol;
  final double? agentFare;
  final double? adminFare;
  final double? transactionAmtp;
  final double? finalAgentWalletPrice;
  final double? finalAdminWalletPrice;
  final int? oldBookingId;
  final String? transactionDisc;
  final double? orgAmount;
  final double? mealPrice;
  final double? bagPrice;
  final double? insAmount;
  final double? retAgentFare;
  final double? retAdminFare;
  final double? seatPrice;
  final double? retAmount;
  final double? returnBaseFare;
  final double? retTax;
  final double? retSeatPrice;
  final double? retMealPrice;
  final double? retBagPrice;
  final double? superAdminFare;
  final double? retSuperAdminFare;

  PaymentDetail({
    required this.id,
    required this.bookingId,
    this.onwardBaseFare,
    this.inwardBaseFare,
    this.serviceFee,
    this.tax,
    this.amount,
    this.markupType,
    this.markupOb,
    this.markupIb,
    this.agentMarkup,
    this.adminMarkup,
    this.finalBookingAmount,
    this.couponId,
    this.discountType,
    this.discountAmount,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.currencyAmount,
    this.currencySymbol,
    this.agentFare,
    this.adminFare,
    this.transactionAmtp,
    this.finalAgentWalletPrice,
    this.finalAdminWalletPrice,
    this.oldBookingId,
    this.transactionDisc,
    this.orgAmount,
    this.mealPrice,
    this.bagPrice,
    this.insAmount,
    this.retAgentFare,
    this.retAdminFare,
    this.seatPrice,
    this.retAmount,
    this.returnBaseFare,
    this.retTax,
    this.retSeatPrice,
    this.retMealPrice,
    this.retBagPrice,
    this.superAdminFare,
    this.retSuperAdminFare,
  });

  factory PaymentDetail.fromJson(Map<String, dynamic> json) => PaymentDetail(
    id: json['id'],
    bookingId: json['bookingid'],
    onwardBaseFare: (json['onward_base_fare'] as num?)?.toDouble(),
    inwardBaseFare: (json['inward_base_fare'] as num?)?.toDouble(),
    serviceFee: (json['service_fee'] as num?)?.toDouble(),
    tax: (json['tax'] as num?)?.toDouble(),
    amount: (json['amount'] as num?)?.toDouble(),
    markupType: json['markup_type'],
    markupOb: (json['markupob'] as num?)?.toDouble(),
    markupIb: (json['markupib'] as num?)?.toDouble(),
    agentMarkup: (json['agent_markup'] as num?)?.toDouble(),
    adminMarkup: (json['admin_markup'] as num?)?.toDouble(),
    finalBookingAmount: (json['finalbooingamount'] as num?)?.toDouble(),
    couponId: json['coupon_id'],
    discountType: json['discount_type'],
    discountAmount: (json['discount_amount'] as num?)?.toDouble(),
    status: json['status'],
    createdAt: json['created_at'],
    updatedAt: json['updated_at'],
    currencyAmount: json['currency_amount'],
    currencySymbol: json['currency_symbol'],
    agentFare: (json['agent_fare'] as num?)?.toDouble(),
    adminFare: (json['admin_fare'] as num?)?.toDouble(),
    transactionAmtp: (json['transaction_amtp'] as num?)?.toDouble(),
    finalAgentWalletPrice: (json['finalagentwalletprice'] as num?)?.toDouble(),
    finalAdminWalletPrice: (json['finaladminwalletprice'] as num?)?.toDouble(),
    oldBookingId: json['old_booking_id'],
    transactionDisc: json['transaction_disc'],
    orgAmount: (json['org_amount'] as num?)?.toDouble(),
    mealPrice: (json['mealprice'] as num?)?.toDouble(),
    bagPrice: (json['bagprice'] as num?)?.toDouble(),
    insAmount: (json['ins_amount'] as num?)?.toDouble(),
    retAgentFare: (json['ret_agent_fare'] as num?)?.toDouble(),
    retAdminFare: (json['ret_admin_fare'] as num?)?.toDouble(),
    seatPrice: (json['seatprice'] as num?)?.toDouble(),
    retAmount: (json['ret_amount'] as num?)?.toDouble(),
    returnBaseFare: (json['return_base_fare'] as num?)?.toDouble(),
    retTax: (json['ret_tax'] as num?)?.toDouble(),
    retSeatPrice: (json['ret_seatprice'] as num?)?.toDouble(),
    retMealPrice: (json['ret_mealprice'] as num?)?.toDouble(),
    retBagPrice: (json['ret_bagprice'] as num?)?.toDouble(),
    superAdminFare: (json['super_admin_fare'] as num?)?.toDouble(),
    retSuperAdminFare: (json['ret_super_admin_fare'] as num?)?.toDouble(),
  );
}



// class FareClassification {
//   final String? color;
//   final String? type;
//
//   FareClassification({this.color, this.type});
//
//   factory FareClassification.fromJson(Map<String, dynamic> json) {
//     return FareClassification(
//       color: json['Color'],
//       type: json['Type'],
//     );
//   }
// }


