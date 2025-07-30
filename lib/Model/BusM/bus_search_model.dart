class BusSearchModel {
  final String destination;
  final String origin;
  final String traceId;
  final List<BusResult> busResults;

  BusSearchModel({
    required this.destination,
    required this.origin,
    required this.traceId,
    required this.busResults,
  });

  factory BusSearchModel.fromJson(Map<String, dynamic> json) {
    return BusSearchModel(
      destination: json['Destination'],
      origin: json['Origin'],
      traceId: json['TraceId'],
      busResults: (json['BusResults'] as List)
          .map((e) => BusResult.fromJson(e))
          .toList(),
    );
  }
}

int? toInt(dynamic value) {
  if (value == null) return null;
  try {
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value);
  } catch (_) {}
  return null;
}

double? toDouble(dynamic value) {
  if (value == null) return null;
  try {
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
  } catch (_) {}
  return null;
}


class BusResult {
  final int resultIndex;
  final String arrivalTime;
  final int availableSeats;
  final String departureTime;
  final String routeId;
  final String busType;
  final String serviceName;
  final String travelName;
  final bool mTicketEnabled;
  final bool idProofRequired;
  final bool isDropPointMandatory;
  final bool liveTrackingAvailable;
  final int maxSeatsPerTicket;
  final int operatorId;
  final bool partialCancellationAllowed;
  final List<CityPoint> boardingPoints;
  final List<CityPoint> droppingPoints;
  final BusPrice busPrice;
  final List<CancellationPolicy> cancellationPolicies;

  BusResult({
    required this.resultIndex,
    required this.arrivalTime,
    required this.availableSeats,
    required this.departureTime,
    required this.routeId,
    required this.busType,
    required this.serviceName,
    required this.travelName,
    required this.mTicketEnabled,
    required this.idProofRequired,
    required this.isDropPointMandatory,
    required this.liveTrackingAvailable,
    required this.maxSeatsPerTicket,
    required this.operatorId,
    required this.partialCancellationAllowed,
    required this.boardingPoints,
    required this.droppingPoints,
    required this.busPrice,
    required this.cancellationPolicies,
  });

  factory BusResult.fromJson(Map<String, dynamic> json) {
    return BusResult(
      resultIndex: json['ResultIndex'],
      arrivalTime: json['ArrivalTime'],
      availableSeats: json['AvailableSeats'],
      departureTime: json['DepartureTime'],
      routeId: json['RouteId'],
      busType: json['BusType'],
      serviceName: json['ServiceName'],
      travelName: json['TravelName'],
      mTicketEnabled: json['MTicketEnabled'],
      idProofRequired: json['IdProofRequired'],
      isDropPointMandatory: json['IsDropPointMandatory'],
      liveTrackingAvailable: json['LiveTrackingAvailable'],
      maxSeatsPerTicket: json['MaxSeatsPerTicket'],
      operatorId: json['OperatorId'],
      partialCancellationAllowed: json['PartialCancellationAllowed'],
      boardingPoints: (json['BoardingPointsDetails'] as List)
          .map((e) => CityPoint.fromJson(e))
          .toList(),
      droppingPoints: (json['DroppingPointsDetails'] as List)
          .map((e) => CityPoint.fromJson(e))
          .toList(),
      busPrice: BusPrice.fromJson(json['BusPrice']),
      cancellationPolicies: (json['CancellationPolicies'] as List)
          .map((e) => CancellationPolicy.fromJson(e))
          .toList(),
    );
  }
}

class CityPoint {
  final int? cityPointIndex;
  final String? cityPointLocation;
  final String? cityPointName;
  final String? cityPointTime;

  CityPoint({
    this.cityPointIndex,
    this.cityPointLocation,
    this.cityPointName,
    this.cityPointTime,
  });

  factory CityPoint.fromJson(Map<String, dynamic> json) {
    return CityPoint(
      cityPointIndex: toInt(json['CityPointIndex']),
      cityPointLocation: json['CityPointLocation'],
      cityPointName: json['CityPointName'],
      cityPointTime: json['CityPointTime'],
    );
  }
}

class BusPrice {
  final String? currencyCode;
  final double? basePrice;
  final double? tax;
  final double? otherCharges;
  final double? discount;
  final double? publishedPrice;
  final int? publishedPriceRoundedOff;
  final double? offeredPrice;
  final int? offeredPriceRoundedOff;
  final double? agentCommission;
  final double? agentMarkUp;
  final double? tds;
  final GST? gst;

  BusPrice({
    this.currencyCode,
    this.basePrice,
    this.tax,
    this.otherCharges,
    this.discount,
    this.publishedPrice,
    this.publishedPriceRoundedOff,
    this.offeredPrice,
    this.offeredPriceRoundedOff,
    this.agentCommission,
    this.agentMarkUp,
    this.tds,
    this.gst,
  });

  factory BusPrice.fromJson(Map<String, dynamic> json) {
    return BusPrice(
      currencyCode: json['CurrencyCode'],
      basePrice: toDouble(json['BasePrice']),
      tax: toDouble(json['Tax']),
      otherCharges: toDouble(json['OtherCharges']),
      discount: toDouble(json['Discount']),
      publishedPrice: toDouble(json['PublishedPrice']),
      publishedPriceRoundedOff: toInt(json['PublishedPriceRoundedOff']),
      offeredPrice: toDouble(json['OfferedPrice']),
      offeredPriceRoundedOff: toInt(json['OfferedPriceRoundedOff']),
      agentCommission: toDouble(json['AgentCommission']),
      agentMarkUp: toDouble(json['AgentMarkUp']),
      tds: toDouble(json['TDS']),
      gst: json['GST'] != null ? GST.fromJson(json['GST']) : null,
    );
  }
}

class GST {
  final double? cgstAmount;
  final double? cgstRate;
  final double? cessAmount;
  final double? cessRate;
  final double? igstAmount;
  final double? igstRate;
  final double? sgstAmount;
  final double? sgstRate;
  final double? taxableAmount;

  GST({
    this.cgstAmount,
    this.cgstRate,
    this.cessAmount,
    this.cessRate,
    this.igstAmount,
    this.igstRate,
    this.sgstAmount,
    this.sgstRate,
    this.taxableAmount,
  });

  factory GST.fromJson(Map<String, dynamic> json) {
    return GST(
      cgstAmount: toDouble(json['CGSTAmount']),
      cgstRate: toDouble(json['CGSTRate']),
      cessAmount: toDouble(json['CessAmount']),
      cessRate: toDouble(json['CessRate']),
      igstAmount: toDouble(json['IGSTAmount']),
      igstRate: toDouble(json['IGSTRate']),
      sgstAmount: toDouble(json['SGSTAmount']),
      sgstRate: toDouble(json['SGSTRate']),
      taxableAmount: toDouble(json['TaxableAmount']),
    );
  }
}

class CancellationPolicy {
  final double? cancellationCharge;
  final int? cancellationChargeType;
  final String? policyString;
  final String? timeBeforeDept;
  final String? fromDate;
  final String? toDate;

  CancellationPolicy({
    this.cancellationCharge,
    this.cancellationChargeType,
    this.policyString,
    this.timeBeforeDept,
    this.fromDate,
    this.toDate,
  });

  factory CancellationPolicy.fromJson(Map<String, dynamic> json) {
    return CancellationPolicy(
      cancellationCharge: toDouble(json['CancellationCharge']),
      cancellationChargeType: toInt(json['CancellationChargeType']),
      policyString: json['PolicyString'],
      timeBeforeDept: json['TimeBeforeDept'],
      fromDate: json['FromDate'],
      toDate: json['ToDate'],
    );
  }
}

