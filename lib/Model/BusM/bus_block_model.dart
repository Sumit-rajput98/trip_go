class BusBlockResponse {
  final bool success;
  final String message;
  final BlockResult data;

  BusBlockResponse({required this.success, required this.message, required this.data});

  factory BusBlockResponse.fromJson(Map<String, dynamic> json) {
    return BusBlockResponse(
      success: json['success'],
      message: json['message'],
      data: BlockResult.fromJson(json['data']['BlockResult']),
    );
  }
}

class BlockResult {
  final String travelName;
  final String busType;
  final String departureTime;
  final String arrivalTime;
  final String serviceName;
  final bool isPriceChanged;
  final List<dynamic> passenger;
  final List<dynamic> cancelPolicy;

  BlockResult({
    required this.travelName,
    required this.busType,
    required this.departureTime,
    required this.arrivalTime,
    required this.serviceName,
    required this.isPriceChanged,
    required this.passenger,
    required this.cancelPolicy,
  });

  factory BlockResult.fromJson(Map<String, dynamic> json) {
    return BlockResult(
      travelName: json['TravelName'] ?? '',
      busType: json['BusType'] ?? '',
      departureTime: json['DepartureTime'] ?? '',
      arrivalTime: json['ArrivalTime'] ?? '',
      serviceName: json['ServiceName'] ?? '',
      isPriceChanged: json['IsPriceChanged'] ?? false,
      passenger: json['Passenger'] ?? [],
      cancelPolicy: json['CancelPolicy'] ?? [],
    );
  }
}
