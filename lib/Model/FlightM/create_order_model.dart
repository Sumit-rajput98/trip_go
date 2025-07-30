class CreateOrderResponse {
  final bool success;
  final String message;
  final OrderData data;

  CreateOrderResponse({required this.success, required this.message, required this.data});

  factory CreateOrderResponse.fromJson(Map<String, dynamic> json) {
    return CreateOrderResponse(
      success: json['success'],
      message: json['message'],
      data: OrderData.fromJson(json['data']),
    );
  }
}

class OrderData {
  final String orderId;
  final int amount;
  final String currency;
  final String key;

  OrderData({required this.orderId, required this.amount, required this.currency, required this.key});

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      orderId: json['order_id'],
      amount: json['amount'],
      currency: json['currency'],
      key: json['key'],
    );
  }
}
