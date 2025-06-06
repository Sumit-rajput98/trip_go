class FlightSearchRequest {
  final String? origin;
  final String? destination;
  final String departureDate;
  final int adult;
  final int child;
  final int infant;
  final int type;
  final int cabin;
  final String tboToken;
  final String partocrsSession;

  FlightSearchRequest({
    required this.origin,
    required this.destination,
    required this.departureDate,
    required this.adult,
    required this.child,
    required this.infant,
    required this.type,
    required this.cabin,
    required this.tboToken,
    required this.partocrsSession,
  });

  Map<String, dynamic> toJson() {
    return {
      "origin": origin,
      "destination": destination,
      "departureDate": departureDate,
      "adult": adult,
      "child": child,
      "infant": infant,
      "type": type,
      "cabin": cabin,
      "tboToken": tboToken,
      "partocrsSession": partocrsSession,
    };
  }
}

class FlightSearchResponse {
  final String? traceId;
  final String origin;
  final String destination;
  final List<List<FlightResult>> results;

  FlightSearchResponse({
    required this.traceId,
    required this.origin,
    required this.destination,
    required this.results,
  });

  factory FlightSearchResponse.fromJson(Map<String, dynamic> json) {
    return FlightSearchResponse(
      traceId: json['TraceId'],
      origin: json['Origin'],
      destination: json['Destination'],
      results: (json['Results'] as List)
          .map<List<FlightResult>>(
            (inner) => (inner as List)
            .map<FlightResult>((item) => FlightResult.fromJson(item))
            .toList(),
      )
          .toList(),
    );
  }

  // toJson method to serialize the object into a JSON map
  Map<String, dynamic> toJson() {
    return {
      'TraceId': traceId,
      'Origin': origin,
      'Destination': destination,
      'Results': results.map((resultList) => resultList.map((result) => result.toJson()).toList()).toList(),
    };
  }
}

class FlightResult {
  final String resultIndex;
  final bool isRefundable;
  final String airlineRemark;
  final Fare fare;
  final List<List<Segment>> segments;

  FlightResult({
    required this.resultIndex,
    required this.isRefundable,
    required this.airlineRemark,
    required this.fare,
    required this.segments,
  });

  factory FlightResult.fromJson(Map<String, dynamic> json) {
    return FlightResult(
      resultIndex: json['ResultIndex'],
      isRefundable: json['IsRefundable'],
      airlineRemark: json['AirlineRemark'] ?? "",
      fare: Fare.fromJson(json['Fare']),
      segments: (json['Segments'] as List)
          .map<List<Segment>>((segList) =>
          (segList as List).map<Segment>((s) => Segment.fromJson(s)).toList())
          .toList(),
    );
  }

  // toJson method to serialize the FlightResult object into a JSON map
  Map<String, dynamic> toJson() {
    return {
      'ResultIndex': resultIndex,
      'IsRefundable': isRefundable,
      'AirlineRemark': airlineRemark,
      'Fare': fare.toJson(),
      'Segments': segments.map((segList) =>
          segList.map((seg) => seg.toJson()).toList()
      ).toList(),
    };
  }
}

class Fare {
  final String currency;
  final double baseFare;
  final double tax;
  final double publishedFare;

  Fare({
    required this.currency,
    required this.baseFare,
    required this.tax,
    required this.publishedFare,
  });

  factory Fare.fromJson(Map<String, dynamic> json) {
    return Fare(
      currency: json['Currency'],
      baseFare: (json['BaseFare'] as num).toDouble(),
      tax: (json['Tax'] as num).toDouble(),
      publishedFare: (json['PublishedFare'] as num).toDouble(),
    );
  }

  // toJson method to serialize the Fare object into a JSON map
  Map<String, dynamic> toJson() {
    return {
      'Currency': currency,
      'BaseFare': baseFare,
      'Tax': tax,
      'PublishedFare': publishedFare,
    };
  }
}

class Airline {
  final String airlineCode;
  final String airlineName;
  final String flightNumber;
  final String fareClass;
  final String operatingCarrier;

  Airline({
    required this.airlineCode,
    required this.airlineName,
    required this.flightNumber,
    required this.fareClass,
    required this.operatingCarrier,
  });

  factory Airline.fromJson(Map<String, dynamic> json) {
    return Airline(
      airlineCode: json['AirlineCode'] ?? '',
      airlineName: json['AirlineName'] ?? '',
      flightNumber: json['FlightNumber'] ?? '',
      fareClass: json['FareClass'] ?? '',
      operatingCarrier: json['OperatingCarrier'] ?? '',
    );
  }
}

class Segment {
  final String baggage;
  final String cabinBaggage;
  final int cabinClass;
  final String supplierFareClass;
  final int tripIndicator;
  final int segmentIndicator;
  final Airline airline;
  final int noOfSeatAvailable;
  final String departureTime;
  final String arrivalTime;
  final int duration;
  final String originAirportCode;
  final String originAirportName;
  final String originCityName;
  final String originTerminal;
  final String destinationAirportCode;
  final String destinationAirportName;
  final String destinationCityName;
  final String destinationCountryCode;
  final String originCountryCode;
  final String destinationTerminal;

  Segment({
    required this.baggage,
    required this.cabinBaggage,
    required this.cabinClass,
    required this.supplierFareClass,
    required this.tripIndicator,
    required this.segmentIndicator,
    required this.airline,
    required this.noOfSeatAvailable,
    required this.departureTime,
    required this.arrivalTime,
    required this.duration,
    required this.originAirportCode,
    required this.originAirportName,
    required this.originCityName,
    required this.originTerminal,
    required this.originCountryCode,
    required this.destinationAirportCode,
    required this.destinationAirportName,
    required this.destinationCityName,
    required this.destinationTerminal,
    required this.destinationCountryCode,
  });

  factory Segment.fromJson(Map<String, dynamic> json) {
    final originAirport = json['Origin']['Airport'];
    final destinationAirport = json['Destination']['Airport'];
    return Segment(
      baggage: json['Baggage'] ?? '',
      cabinBaggage: json['CabinBaggage'] ?? '',
      cabinClass: json['CabinClass'] ?? 0,
      supplierFareClass: json['SupplierFareClass'] ?? '',
      tripIndicator: json['TripIndicator'] ?? 0,
      segmentIndicator: json['SegmentIndicator'] ?? 0,
      airline: Airline.fromJson(json['Airline']),
      noOfSeatAvailable: json['NoOfSeatAvailable'] ?? 0,
      departureTime: json['Origin']['DepTime'],
      arrivalTime: json['Destination']['ArrTime'],
      duration: json['Duration'] ?? 0,
      originAirportCode: originAirport['AirportCode'] ?? '',
      originAirportName: originAirport['AirportName'] ?? '',
      originTerminal: originAirport['Terminal'] ?? '',
      originCityName: originAirport['CityName'] ?? '',
      originCountryCode: originAirport['CountryCode'] ?? '',
      destinationAirportCode: destinationAirport['AirportCode'] ?? '',
      destinationAirportName: destinationAirport['AirportName'] ?? '',
      destinationCityName: destinationAirport['CityName'] ?? '',
      destinationCountryCode: destinationAirport['CountryCode'] ?? '',
      destinationTerminal: destinationAirport['Terminal'] ?? '',
    );

  }

  // toJson method to serialize the Segment object into a JSON map
  Map<String, dynamic> toJson() {
    return {
      'Baggage': baggage,
      'CabinBaggage': cabinBaggage,
      'Airline': airline,
      'DepartureTime': departureTime,
      'ArrivalTime': arrivalTime,
    };
  }
}


