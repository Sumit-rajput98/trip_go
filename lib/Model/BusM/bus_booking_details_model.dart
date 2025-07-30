class BusBookingDetailsModel {
  final bool success;
  final String message;
  final BookingData? data;

  BusBookingDetailsModel({
    required this.success,
    required this.message,
    this.data,
  });

  factory BusBookingDetailsModel.fromJson(Map<String, dynamic> json) {
    return BusBookingDetailsModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? BookingData.fromJson(json['data']) : null,
    );
  }
}

class BookingData {
  final GetBookingDetailResult? result;

  BookingData({this.result});

  factory BookingData.fromJson(Map<String, dynamic> json) {
    return BookingData(
      result: json['GetBookingDetailResult'] != null
          ? GetBookingDetailResult.fromJson(json['GetBookingDetailResult'])
          : null,
    );
  }
}

class GetBookingDetailResult {
  final Itinerary? itinerary;
  final int responseStatus;
  final String traceId;

  GetBookingDetailResult({
    this.itinerary,
    required this.responseStatus,
    required this.traceId,
  });

  factory GetBookingDetailResult.fromJson(Map<String, dynamic> json) {
    return GetBookingDetailResult(
      itinerary: json['Itinerary'] != null
          ? Itinerary.fromJson(json['Itinerary'])
          : null,
      responseStatus: json['ResponseStatus'] ?? 0,
      traceId: json['TraceId'] ?? '',
    );
  }
}

class Itinerary {
  final String ticketNo;
  final String origin;
  final String destination;
  final String departureTime;
  final String arrivalTime;
  final String travelName;
  final String busType;
  final List<Passenger>? passengers;
  final BoardingPointDetails? boardingPointdetails;
  final List<CancelPolicy>? cancelPolicy;

  Itinerary({
    required this.ticketNo,
    required this.origin,
    required this.destination,
    required this.departureTime,
    required this.arrivalTime,
    required this.travelName,
    required this.busType,
    this.passengers,
    this.boardingPointdetails,
    this.cancelPolicy,
  });

  factory Itinerary.fromJson(Map<String, dynamic> json) {
    return Itinerary(
      ticketNo: json['TicketNo'] ?? '',
      origin: json['Origin'] ?? '',
      destination: json['Destination'] ?? '',
      departureTime: json['DepartureTime'] ?? '',
      arrivalTime: json['ArrivalTime'] ?? '',
      travelName: json['TravelName'] ?? '',
      busType: json['BusType'] ?? '',
      passengers: (json['Passenger'] as List<dynamic>?)
          ?.map((p) => Passenger.fromJson(p))
          .toList(),
      boardingPointdetails: json['BoardingPointdetails'] != null
          ? BoardingPointDetails.fromJson(json['BoardingPointdetails'])
          : null,
      cancelPolicy: (json['CancelPolicy'] as List<dynamic>?)
          ?.map((e) => CancelPolicy.fromJson(e))
          .toList(),
    );
  }
}

class Passenger {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNo;
  final int? age;
  final Seat? seat;

  Passenger({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNo,
    this.age,
    this.seat,
  });

  factory Passenger.fromJson(Map<String, dynamic> json) {
    return Passenger(
      firstName: json['FirstName'] ?? '',
      lastName: json['LastName'] ?? '',
      email: json['Email'] ?? '',
      phoneNo: json['Phoneno'] ?? '',
      age: json['Age'],
      seat: json['Seat'] != null ? Seat.fromJson(json['Seat']) : null,
    );
  }
}

class Seat {
  final String seatName;
  final int seatId;
  final Price? price;

  Seat({
    required this.seatName,
    required this.seatId,
    this.price,
  });

  factory Seat.fromJson(Map<String, dynamic> json) {
    return Seat(
      seatName: json['SeatName'] ?? '',
      seatId: json['SeatId'] ?? 0,
      price: json['Price'] != null ? Price.fromJson(json['Price']) : null,
    );
  }
}

class Price {
  final String currencyCode;
  final double basePrice;
  final double publishedPrice;
  final double offeredPrice;
  final double? offeredPriceRoundedOff;
  final GST? gst;

  Price({
    required this.currencyCode,
    required this.basePrice,
    required this.publishedPrice,
    required this.offeredPrice,
    this.offeredPriceRoundedOff,
    this.gst,
  });

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
      currencyCode: json['CurrencyCode'] ?? 'INR',
      basePrice: (json['BasePrice'] as num?)?.toDouble() ?? 0,
      publishedPrice: (json['PublishedPrice'] as num?)?.toDouble() ?? 0,
      offeredPrice: (json['OfferedPrice'] as num?)?.toDouble() ?? 0,
      offeredPriceRoundedOff:
      (json['OfferedPriceRoundedOff'] as num?)?.toDouble(),
      gst: json['GST'] != null ? GST.fromJson(json['GST']) : null,
    );
  }
}

class GST {
  final double igstRate;

  GST({
    required this.igstRate,
  });

  factory GST.fromJson(Map<String, dynamic> json) {
    return GST(
      igstRate: (json['IGSTRate'] as num?)?.toDouble() ?? 0,
    );
  }
}

class BoardingPointDetails {
  final String cityPointName;
  final String cityPointTime;
  final String cityPointLocation;

  BoardingPointDetails({
    required this.cityPointName,
    required this.cityPointTime,
    required this.cityPointLocation,
  });

  factory BoardingPointDetails.fromJson(Map<String, dynamic> json) {
    return BoardingPointDetails(
      cityPointName: json['CityPointName'] ?? '',
      cityPointTime: json['CityPointTime'] ?? '',
      cityPointLocation: json['CityPointLocation'] ?? '',
    );
  }
}

class CancelPolicy {
  final double cancellationCharge;
  final int cancellationChargeType;
  final String policyString;
  final String timeBeforeDept;
  final String fromDate;
  final String toDate;

  CancelPolicy({
    required this.cancellationCharge,
    required this.cancellationChargeType,
    required this.policyString,
    required this.timeBeforeDept,
    required this.fromDate,
    required this.toDate,
  });

  factory CancelPolicy.fromJson(Map<String, dynamic> json) {
    return CancelPolicy(
      cancellationCharge: (json['CancellationCharge'] as num?)?.toDouble() ?? 0,
      cancellationChargeType: json['CancellationChargeType'] ?? 0,
      policyString: json['PolicyString'] ?? '',
      timeBeforeDept: json['TimeBeforeDept'] ?? '',
      fromDate: json['FromDate'] ?? '',
      toDate: json['ToDate'] ?? '',
    );
  }
}
