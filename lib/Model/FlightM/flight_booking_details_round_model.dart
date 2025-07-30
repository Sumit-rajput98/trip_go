class FlightBookingDetailsRoundModel {
  final bool success;
  final String message;
  final FlightBookingData data;

  FlightBookingDetailsRoundModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory FlightBookingDetailsRoundModel.fromJson(Map<String, dynamic> json) {
    return FlightBookingDetailsRoundModel(
      success: json['success'],
      message: json['message'],
      data: FlightBookingData.fromJson(json['data']),
    );
  }
}

class FlightBookingData {
  final int responseStatus;
  final String traceId;
  final FlightItinerary itinerary;
  final FlightItinerary? inboundItinerary;

  FlightBookingData({
    required this.responseStatus,
    required this.traceId,
    required this.itinerary,
    this.inboundItinerary,
  });

  factory FlightBookingData.fromJson(Map<String, dynamic> json) {
    return FlightBookingData(
      responseStatus: json['ResponseStatus'],
      traceId: json['TraceId'],
      itinerary: FlightItinerary.fromJson(json['FlightItinerary']),
      inboundItinerary: json['Inbound'] != null
          ? FlightItinerary.fromJson(json['Inbound']['FlightItinerary'])
          : null,
    );
  }
}

class FlightItinerary {
  final int bookingId;
  final String pnr;
  final String origin;
  final String destination;
  final String airlineCode;
  final String validatingAirlineCode;
  final String airlineTollFreeNo;
  final bool isDomestic;
  final Fare fare;
  final List<Passenger> passengers;
  final List<Segment> segments;

  FlightItinerary({
    required this.bookingId,
    required this.pnr,
    required this.origin,
    required this.destination,
    required this.airlineCode,
    required this.validatingAirlineCode,
    required this.airlineTollFreeNo,
    required this.isDomestic,
    required this.fare,
    required this.passengers,
    required this.segments
  });

  factory FlightItinerary.fromJson(Map<String, dynamic> json) {
    var passengerList = (json['Passenger'] as List?)?.map((p) => Passenger.fromJson(p)).toList() ?? [];
    var segmentList = (json['Segments'] as List?)?.map((p) => Segment.fromJson(p)).toList() ?? [];

    return FlightItinerary(
      bookingId: json['BookingId'] ?? 0,
      pnr: json['PNR'] ?? '',
      origin: json['Origin'] ?? '',
      destination: json['Destination'] ?? '',
      airlineCode: json['AirlineCode'] ?? '',
      validatingAirlineCode: json['ValidatingAirlineCode'] ?? '',
      airlineTollFreeNo: json['AirlineTollFreeNo'] ?? '',
      isDomestic: json['IsDomestic'] ?? true,
      fare: json['Fare'] != null ? Fare.fromJson(json['Fare']) : Fare.empty(),
      passengers: passengerList,
      segments: segmentList,
    );
  }
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

  factory Fare.fromJson(Map<String, dynamic> json) {
    var taxList = (json['TaxBreakup'] as List?)?.map((t) => TaxBreakup.fromJson(t)).toList() ?? [];
    var chargeList = (json['ChargeBU'] as List?)?.map((c) => ChargeBU.fromJson(c)).toList() ?? [];

    return Fare(
      currency: json['Currency'] ?? '',
      baseFare: (json['BaseFare'] as num?)?.toDouble() ?? 0.0,
      tax: (json['Tax'] as num?)?.toDouble() ?? 0.0,
      taxBreakup: taxList,
      yqTax: (json['YQTax'] as num?)?.toDouble() ?? 0.0,
      additionalTxnFeeOfrd: (json['AdditionalTxnFeeOfrd'] as num?)?.toDouble() ?? 0.0,
      additionalTxnFeePub: (json['AdditionalTxnFeePub'] as num?)?.toDouble() ?? 0.0,
      pgCharge: (json['PGCharge'] as num?)?.toDouble() ?? 0.0,
      otherCharges: (json['OtherCharges'] as num?)?.toDouble() ?? 0.0,
      chargeBU: chargeList,
      discount: (json['Discount'] as num?)?.toDouble() ?? 0.0,
      publishedFare: (json['PublishedFare'] as num?)?.toDouble() ?? 0.0,
      commissionEarned: (json['CommissionEarned'] as num?)?.toDouble() ?? 0.0,
      plbEarned: (json['PLBEarned'] as num?)?.toDouble() ?? 0.0,
      incentiveEarned: (json['IncentiveEarned'] as num?)?.toDouble() ?? 0.0,
      offeredFare: (json['OfferedFare'] as num?)?.toDouble() ?? 0.0,
      tdsOnCommission: (json['TdsOnCommission'] as num?)?.toDouble() ?? 0.0,
      tdsOnPLB: (json['TdsOnPLB'] as num?)?.toDouble() ?? 0.0,
      tdsOnIncentive: (json['TdsOnIncentive'] as num?)?.toDouble() ?? 0.0,
      serviceFee: (json['ServiceFee'] as num?)?.toDouble() ?? 0.0,
      totalBaggageCharges: (json['TotalBaggageCharges'] as num?)?.toDouble() ?? 0.0,
      totalMealCharges: (json['TotalMealCharges'] as num?)?.toDouble() ?? 0.0,
      totalSeatCharges: (json['TotalSeatCharges'] as num?)?.toDouble() ?? 0.0,
      totalSpecialServiceCharges: (json['TotalSpecialServiceCharges'] as num?)?.toDouble() ?? 0.0,
    );
  }

  factory Fare.empty() {
    return Fare(
      currency: '',
      baseFare: 0.0,
      tax: 0.0,
      taxBreakup: [],
      yqTax: 0.0,
      additionalTxnFeeOfrd: 0.0,
      additionalTxnFeePub: 0.0,
      pgCharge: 0.0,
      otherCharges: 0.0,
      chargeBU: [],
      discount: 0.0,
      publishedFare: 0.0,
      commissionEarned: 0.0,
      plbEarned: 0.0,
      incentiveEarned: 0.0,
      offeredFare: 0.0,
      tdsOnCommission: 0.0,
      tdsOnPLB: 0.0,
      tdsOnIncentive: 0.0,
      serviceFee: 0.0,
      totalBaggageCharges: 0.0,
      totalMealCharges: 0.0,
      totalSeatCharges: 0.0,
      totalSpecialServiceCharges: 0.0,
    );
  }
}

class TaxBreakup {
  final String key;
  final double value;

  TaxBreakup({
    required this.key,
    required this.value,
  });

  factory TaxBreakup.fromJson(Map<String, dynamic> json) {
    return TaxBreakup(
      key: json['key'] ?? '',
      value: (json['value'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

class ChargeBU {
  final String key;
  final double value;

  ChargeBU({required this.key, required this.value});

  factory ChargeBU.fromJson(Map<String, dynamic> json) {
    return ChargeBU(
      key: json['key'] ?? '',
      value: (json['value'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

class Passenger {
  final int paxId;
  final String title;
  final String firstName;
  final String lastName;
  final int paxType;
  final String dateOfBirth;
  final int gender;
  final String passportNo;
  final String addressLine1;
  final Fare fare;
  final String city;
  final String countryCode;
  final String nationality;
  final String contactNo;
  final String email;
  final bool isLeadPax;
  final Barcode barcodeDetails;
  final Ticket ticket;

  Passenger({
    required this.paxId,
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.paxType,
    required this.dateOfBirth,
    required this.gender,
    required this.passportNo,
    required this.addressLine1,
    required this.fare,
    required this.city,
    required this.countryCode,
    required this.nationality,
    required this.contactNo,
    required this.email,
    required this.isLeadPax,
    required this.barcodeDetails,
    required this.ticket,
  });

  factory Passenger.fromJson(Map<String, dynamic> json) {
    return Passenger(
      paxId: json['PaxId'] ?? 0,
      title: json['Title'] ?? '',
      firstName: json['FirstName'] ?? '',
      lastName: json['LastName'] ?? '',
      paxType: json['PaxType'] ?? 0,
      dateOfBirth: json['DateOfBirth'] ?? '',
      gender: json['Gender'] ?? 0,
      passportNo: json['PassportNo'] ?? '',
      addressLine1: json['AddressLine1'] ?? '',
      fare: json['Fare'] != null ? Fare.fromJson(json['Fare']) : Fare.empty(),
      city: json['City'] ?? '',
      countryCode: json['CountryCode'] ?? '',
      nationality: json['Nationality'] ?? '',
      contactNo: json['ContactNo'] ?? '',
      email: json['Email'] ?? '',
      isLeadPax: json['IsLeadPax'] ?? false,
      barcodeDetails: json['BarcodeDetails'] != null
          ? Barcode.fromJson(json['BarcodeDetails'])
          : Barcode.empty(),
      ticket: json['Ticket'] != null ? Ticket.fromJson(json['Ticket']) : Ticket.empty(),
    );
  }
}

class Ticket {
  final int ticketId;
  final String ticketNumber;
  final DateTime issueDate;
  final String validatingAirline;
  final String remarks;
  final String serviceFeeDisplayType;
  final String status;
  final String conjunctionNumber;
  final String ticketType;

  Ticket({
    required this.ticketId,
    required this.ticketNumber,
    required this.issueDate,
    required this.validatingAirline,
    required this.remarks,
    required this.serviceFeeDisplayType,
    required this.status,
    required this.conjunctionNumber,
    required this.ticketType,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      ticketId: json['TicketId'] ?? 0,
      ticketNumber: json['TicketNumber'] ?? '',
      issueDate: DateTime.tryParse(json['IssueDate'] ?? '') ?? DateTime(1970),
      validatingAirline: json['ValidatingAirline'] ?? '',
      remarks: json['Remarks'] ?? '',
      serviceFeeDisplayType: json['ServiceFeeDisplayType'] ?? '',
      status: json['Status'] ?? '',
      conjunctionNumber: json['ConjunctionNumber'] ?? '',
      ticketType: json['TicketType'] ?? '',
    );
  }

  factory Ticket.empty() {
    return Ticket(
      ticketId: 0,
      ticketNumber: '',
      issueDate: DateTime(1970),
      validatingAirline: '',
      remarks: '',
      serviceFeeDisplayType: '',
      status: '',
      conjunctionNumber: '',
      ticketType: '',
    );
  }
}

class Barcode {
  final int index;
  final String format;
  final String content;
  final String? barCodeInBase64;
  final int journeyWayType;

  Barcode({
    required this.index,
    required this.format,
    required this.content,
    required this.barCodeInBase64,
    required this.journeyWayType,
  });

  factory Barcode.fromJson(Map<String, dynamic> json) {
    return Barcode(
      index: json['Index'] ?? 0,
      format: json['Format'] ?? '',
      content: json['Content'] ?? '',
      barCodeInBase64: json['BarCodeInBase64'],
      journeyWayType: json['JourneyWayType'] ?? 0,
    );
  }

  factory Barcode.empty() {
    return Barcode(
      index: 0,
      format: '',
      content: '',
      barCodeInBase64: null,
      journeyWayType: 0,
    );
  }
}

class BarcodeDetails {
  final int id;
  final List<Barcode> barcode;

  BarcodeDetails({
    required this.id,
    required this.barcode,
  });

  factory BarcodeDetails.fromJson(Map<String, dynamic> json) {
    var barcodeList = json['Barcode'] as List;
    List<Barcode> barcodeItems =
    barcodeList.map((item) => Barcode.fromJson(item)).toList();

    return BarcodeDetails(
      id: json['Id'],
      barcode: barcodeItems,
    );
  }
}

class Segment {
  final String? baggage;
  final String? cabinBaggage;
  final int cabinClass;
  final String? supplierFareClass;
  final int tripIndicator;
  final int segmentIndicator;

  final String airlineCode;
  final String airlineName;
  final String flightNumber;
  final String fareClass;
  final String operatingCarrier;

  final String airlinePNR;

  final String originAirportCode;
  final String originAirportName;
  final String originTerminal;
  final String originCityCode;
  final String originCityName;
  final String originCountryCode;
  final String originCountryName;
  final String depTime;

  final String destinationAirportCode;
  final String destinationAirportName;
  final String destinationTerminal;
  final String destinationCityCode;
  final String destinationCityName;
  final String destinationCountryCode;
  final String destinationCountryName;
  final String arrTime;

  final int duration;
  final int groundTime;
  final int mile;
  final bool stopOver;
  final String flightInfoIndex;
  final String stopPoint;
  final String? stopPointArrivalTime;
  final String? stopPointDepartureTime;
  final String craft;
  final String? remark;
  final bool isETicketEligible;
  final String flightStatus;
  final String status;
  final String? fareClassification;

  Segment({
    this.baggage,
    this.cabinBaggage,
    required this.cabinClass,
    this.supplierFareClass,
    required this.tripIndicator,
    required this.segmentIndicator,
    required this.airlineCode,
    required this.airlineName,
    required this.flightNumber,
    required this.fareClass,
    required this.operatingCarrier,
    required this.airlinePNR,
    required this.originAirportCode,
    required this.originAirportName,
    required this.originTerminal,
    required this.originCityCode,
    required this.originCityName,
    required this.originCountryCode,
    required this.originCountryName,
    required this.depTime,
    required this.destinationAirportCode,
    required this.destinationAirportName,
    required this.destinationTerminal,
    required this.destinationCityCode,
    required this.destinationCityName,
    required this.destinationCountryCode,
    required this.destinationCountryName,
    required this.arrTime,
    required this.duration,
    required this.groundTime,
    required this.mile,
    required this.stopOver,
    required this.flightInfoIndex,
    required this.stopPoint,
    this.stopPointArrivalTime,
    this.stopPointDepartureTime,
    required this.craft,
    this.remark,
    required this.isETicketEligible,
    required this.flightStatus,
    required this.status,
    this.fareClassification,
  });

  factory Segment.fromJson(Map<String, dynamic> json) {
    final airline = json['Airline'] ?? {};
    final originAirport = (json['Origin']?['Airport'] ?? {}) as Map<String, dynamic>;
    final destinationAirport = (json['Destination']?['Airport'] ?? {}) as Map<String, dynamic>;

    return Segment(
      baggage: json['Baggage'],
      cabinBaggage: json['CabinBaggage'],
      cabinClass: json['CabinClass'] ?? 0,
      supplierFareClass: json['SupplierFareClass'],
      tripIndicator: json['TripIndicator'] ?? 0,
      segmentIndicator: json['SegmentIndicator'] ?? 0,
      airlineCode: airline['AirlineCode'] ?? '',
      airlineName: airline['AirlineName'] ?? '',
      flightNumber: airline['FlightNumber'] ?? '',
      fareClass: airline['FareClass'] ?? '',
      operatingCarrier: airline['OperatingCarrier'] ?? '',
      airlinePNR: json['AirlinePNR'] ?? '',
      originAirportCode: originAirport['AirportCode'] ?? '',
      originAirportName: originAirport['AirportName'] ?? '',
      originTerminal: originAirport['Terminal'] ?? '',
      originCityCode: originAirport['CityCode'] ?? '',
      originCityName: originAirport['CityName'] ?? '',
      originCountryCode: originAirport['CountryCode'] ?? '',
      originCountryName: originAirport['CountryName'] ?? '',
      depTime: json['Origin']?['DepTime'] ?? '',
      destinationAirportCode: destinationAirport['AirportCode'] ?? '',
      destinationAirportName: destinationAirport['AirportName'] ?? '',
      destinationTerminal: destinationAirport['Terminal'] ?? '',
      destinationCityCode: destinationAirport['CityCode'] ?? '',
      destinationCityName: destinationAirport['CityName'] ?? '',
      destinationCountryCode: destinationAirport['CountryCode'] ?? '',
      destinationCountryName: destinationAirport['CountryName'] ?? '',
      arrTime: json['Destination']?['ArrTime'] ?? '',
      duration: (json['Duration'] is int)
          ? json['Duration']
          : (json['Duration'] as num).toInt(),
      groundTime: (json['GroundTime'] is int)
          ? json['GroundTime']
          : (json['GroundTime'] as num).toInt(),
      mile: (json['Mile'] is int)
          ? json['Mile']
          : (json['Mile'] as num).toInt(),
      stopOver: json['StopOver'] ?? false,
      flightInfoIndex: json['FlightInfoIndex'] ?? '',
      stopPoint: json['StopPoint'] ?? '',
      stopPointArrivalTime: json['StopPointArrivalTime'],
      stopPointDepartureTime: json['StopPointDepartureTime'],
      craft: json['Craft'] ?? '',
      remark: json['Remark'],
      isETicketEligible: json['IsETicketEligible'] ?? false,
      flightStatus: json['FlightStatus'] ?? '',
      status: json['Status'] ?? '',
      fareClassification: json['FareClassification'],
    );
  }
}

class FareRule {
  final String origin;
  final String destination;
  final String fareBasisCode;
  final String fareRuleDetail;

  FareRule({
    required this.origin,
    required this.destination,
    required this.fareBasisCode,
    required this.fareRuleDetail,
  });

  factory FareRule.fromJson(Map<String, dynamic> json) {
    return FareRule(
      origin: json['Origin'] ?? '',
      destination: json['Destination'] ?? '',
      fareBasisCode: json['FareBasisCode'] ?? '',
      fareRuleDetail: json['FareRuleDetail'] ?? '',
    );
  }
}

class MiniFareRule {
  final String journeyPoints;
  final String type;
  final String from;
  final String to;
  final String unit;
  final String details;

  MiniFareRule({
    required this.journeyPoints,
    required this.type,
    required this.from,
    required this.to,
    required this.unit,
    required this.details,
  });

  factory MiniFareRule.fromJson(Map<String, dynamic> json) {
    return MiniFareRule(
      journeyPoints: json['JourneyPoints'] ?? '',
      type: json['Type'] ?? '',
      from: json['From'] ?? '',
      to: json['To'] ?? '',
      unit: json['Unit'] ?? '',
      details: json['Details'] ?? '',
    );
  }
}

class PenaltyCharge {
  final String type;
  final String amount;

  PenaltyCharge({
    required this.type,
    required this.amount,
  });

  factory PenaltyCharge.fromJson(Map<String, dynamic> json) {
    return PenaltyCharge(
      type: json['Type'] ?? '',
      amount: json['Amount'] ?? '',
    );
  }
}

class Invoice {
  final String invoiceNumber;
  final String issueDate;
  final double amount;

  Invoice({
    required this.invoiceNumber,
    required this.issueDate,
    required this.amount,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      invoiceNumber: json['InvoiceNumber'] ?? '',
      issueDate: json['IssueDate'] ?? '',
      amount: (json['Amount'] != null)
          ? (json['Amount'] is double ? json['Amount'] : (json['Amount'] as num).toDouble())
          : 0.0,
    );
  }
}
