class BusSeatLayoutResponse {
  final bool success;
  final String message;
  final GetBusSeatLayoutResult? result;

  BusSeatLayoutResponse({
    required this.success,
    required this.message,
    this.result,
  });

  factory BusSeatLayoutResponse.fromJson(Map<String, dynamic> json) {
    return BusSeatLayoutResponse(
      success: json['success'],
      message: json['message'],
      result: json['data'] != null
          ? GetBusSeatLayoutResult.fromJson(json['data']['GetBusSeatLayOutResult'])
          : null,
    );
  }
}

class GetBusSeatLayoutResult {
  final int responseStatus;
  final String traceId;
  final SeatLayoutDetails seatLayoutDetails;

  GetBusSeatLayoutResult({
    required this.responseStatus,
    required this.traceId,
    required this.seatLayoutDetails,
  });

  factory GetBusSeatLayoutResult.fromJson(Map<String, dynamic> json) {
    return GetBusSeatLayoutResult(
      responseStatus: json['ResponseStatus'],
      traceId: json['TraceId'],
      seatLayoutDetails: SeatLayoutDetails.fromJson(json['SeatLayoutDetails']),
    );
  }
}

class SeatLayoutDetails {
  final String availableSeats;
  final String htmlLayout;
  final SeatLayoutModel seatLayout;

  SeatLayoutDetails({
    required this.availableSeats,
    required this.htmlLayout,
    required this.seatLayout,
  });

  factory SeatLayoutDetails.fromJson(Map<String, dynamic> json) {
    return SeatLayoutDetails(
      availableSeats: json['AvailableSeats'],
      htmlLayout: json['HTMLLayout'],
      seatLayout: SeatLayoutModel.fromJson(json['SeatLayout']),
    );
  }
}

class SeatLayoutModel {
  final int noOfColumns;
  final int noOfRows;
  final List<List<SeatDetail>> seatDetails;

  SeatLayoutModel({
    required this.noOfColumns,
    required this.noOfRows,
    required this.seatDetails,
  });

  factory SeatLayoutModel.fromJson(Map<String, dynamic> json) {
    return SeatLayoutModel(
      noOfColumns: json['NoOfColumns'],
      noOfRows: json['NoOfRows'],
      seatDetails: (json['SeatDetails'] as List)
          .map<List<SeatDetail>>((row) => (row as List)
          .map<SeatDetail>((seat) => SeatDetail.fromJson(seat))
          .toList())
          .toList(),
    );
  }
}

class SeatDetail {
  final String columnNo;
  final int height;
  final bool isLadiesSeat;
  final bool isMalesSeat;
  final bool isUpper;
  final String rowNo;
  final double seatFare;
  final int seatIndex;
  final String seatName;
  final bool seatStatus;
  final int seatType;
  final int width;
  final Price price;

  SeatDetail({
    required this.columnNo,
    required this.height,
    required this.isLadiesSeat,
    required this.isMalesSeat,
    required this.isUpper,
    required this.rowNo,
    required this.seatFare,
    required this.seatIndex,
    required this.seatName,
    required this.seatStatus,
    required this.seatType,
    required this.width,
    required this.price,
  });

  factory SeatDetail.fromJson(Map<String, dynamic> json) {
    return SeatDetail(
      columnNo: json['ColumnNo'],
      height: json['Height'],
      isLadiesSeat: json['IsLadiesSeat'],
      isMalesSeat: json['IsMalesSeat'],
      isUpper: json['IsUpper'],
      rowNo: json['RowNo'],
      seatFare: json['SeatFare'].toDouble(),
      seatIndex: json['SeatIndex'],
      seatName: json['SeatName'],
      seatStatus: json['SeatStatus'],
      seatType: json['SeatType'],
      width: json['Width'],
      price: Price.fromJson(json['Price']),
    );
  }
}

class Price {
  final String currencyCode;
  final double basePrice;
  final double tax;
  final double otherCharges;
  final double discount;
  final double publishedPrice;
  final double publishedPriceRoundedOff;
  final double offeredPrice;
  final double offeredPriceRoundedOff;
  final double agentCommission;
  final double agentMarkUp;
  final double tds;
  final GST gst;

  Price({
    required this.currencyCode,
    required this.basePrice,
    required this.tax,
    required this.otherCharges,
    required this.discount,
    required this.publishedPrice,
    required this.publishedPriceRoundedOff,
    required this.offeredPrice,
    required this.offeredPriceRoundedOff,
    required this.agentCommission,
    required this.agentMarkUp,
    required this.tds,
    required this.gst,
  });

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
      currencyCode: json['CurrencyCode'] ?? 'INR',
      basePrice: (json['BasePrice'] ?? 0).toDouble(),
      tax: (json['Tax'] ?? 0).toDouble(),
      otherCharges: (json['OtherCharges'] ?? 0).toDouble(),
      discount: (json['Discount'] ?? 0).toDouble(),
      publishedPrice: (json['PublishedPrice'] ?? 0).toDouble(),
      publishedPriceRoundedOff: (json['PublishedPriceRoundedOff'] ?? 0).toDouble(),
      offeredPrice: (json['OfferedPrice'] ?? 0).toDouble(),
      offeredPriceRoundedOff: (json['OfferedPriceRoundedOff'] ?? 0).toDouble(),
      agentCommission: (json['AgentCommission'] ?? 0).toDouble(),
      agentMarkUp: (json['AgentMarkUp'] ?? 0).toDouble(),
      tds: (json['TDS'] ?? 0).toDouble(),
      gst: GST.fromJson(json['GST'] ?? {}),
    );
  }
  Map<String, dynamic> toJson() => {
    'CurrencyCode': currencyCode,
    'BasePrice': basePrice,
    'Tax': tax,
    'OtherCharges': otherCharges,
    'Discount': discount,
    'PublishedPrice': publishedPrice,
    'PublishedPriceRoundedOff': publishedPriceRoundedOff,
    'OfferedPrice': offeredPrice,
    'OfferedPriceRoundedOff': offeredPriceRoundedOff,
    'AgentCommission': agentCommission,
    'AgentMarkUp': agentMarkUp,
    'TDS': tds,
    'GST': gst.toJson(),
  };
}

class GST {
  final double cgstAmount;
  final double cgstRate;
  final double cessAmount;
  final double cessRate;
  final double igstAmount;
  final double igstRate;
  final double sgstAmount;
  final double sgstRate;
  final double taxableAmount;

  GST({
    required this.cgstAmount,
    required this.cgstRate,
    required this.cessAmount,
    required this.cessRate,
    required this.igstAmount,
    required this.igstRate,
    required this.sgstAmount,
    required this.sgstRate,
    required this.taxableAmount,
  });

  factory GST.fromJson(Map<String, dynamic> json) {
    return GST(
      cgstAmount: (json['CGSTAmount'] ?? 0).toDouble(),
      cgstRate: (json['CGSTRate'] ?? 0).toDouble(),
      cessAmount: (json['CessAmount'] ?? 0).toDouble(),
      cessRate: (json['CessRate'] ?? 0).toDouble(),
      igstAmount: (json['IGSTAmount'] ?? 0).toDouble(),
      igstRate: (json['IGSTRate'] ?? 0).toDouble(),
      sgstAmount: (json['SGSTAmount'] ?? 0).toDouble(),
      sgstRate: (json['SGSTRate'] ?? 0).toDouble(),
      taxableAmount: (json['TaxableAmount'] ?? 0).toDouble(),
    );
  }
  Map<String, dynamic> toJson() => {
    'CGSTAmount': cgstAmount,
    'CGSTRate': cgstRate,
    'CessAmount': cessAmount,
    'CessRate': cessRate,
    'IGSTAmount': igstAmount,
    'IGSTRate': igstRate,
    'SGSTAmount': sgstAmount,
    'SGSTRate': sgstRate,
    'TaxableAmount': taxableAmount,
  };
}
