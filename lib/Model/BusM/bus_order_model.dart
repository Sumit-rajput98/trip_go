class BusOrderResponse {
  final bool success;
  final String message;
  final BusOrderData data;

  BusOrderResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory BusOrderResponse.fromJson(Map<String, dynamic> json) {
    return BusOrderResponse(
      success: json['success'],
      message: json['message'],
      data: BusOrderData.fromJson(json['data']),
    );
  }
}

class BusOrderData {
  final String orderId;
  final int amount;
  final String currency;
  final String key;

  BusOrderData({
    required this.orderId,
    required this.amount,
    required this.currency,
    required this.key,
  });

  factory BusOrderData.fromJson(Map<String, dynamic> json) {
    return BusOrderData(
      orderId: json['order_id'],
      amount: json['amount'],
      currency: json['currency'],
      key: json['key'],
    );
  }
}
