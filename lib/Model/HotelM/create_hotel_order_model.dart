class CreateHotelOrderResponse {
  final bool success;
  final String message;
  final HotelOrderData? data;

  CreateHotelOrderResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory CreateHotelOrderResponse.fromJson(Map<String, dynamic> json) {
    return CreateHotelOrderResponse(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? HotelOrderData.fromJson(json['data']) : null,
    );
  }
}

class HotelOrderData {
  final String orderId;
  final int amount;
  final String currency;
  final String key;

  HotelOrderData({
    required this.orderId,
    required this.amount,
    required this.currency,
    required this.key,
  });

  factory HotelOrderData.fromJson(Map<String, dynamic> json) {
    return HotelOrderData(
      orderId: json['order_id'],
      amount: json['amount'],
      currency: json['currency'],
      key: json['key'],
    );
  }
}
