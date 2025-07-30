class CabCreateOrderModel {
  final String orderId;
  final int amount;
  final String currency;
  final String key;

  CabCreateOrderModel({
    required this.orderId,
    required this.amount,
    required this.currency,
    required this.key,
  });

  factory CabCreateOrderModel.fromJson(Map<String, dynamic> json) {
    return CabCreateOrderModel(
      orderId: json['order_id'] ?? '',
      amount: json['amount'] ?? 0,
      currency: json['currency'] ?? 'INR',
      key: json['key'] ?? '',
    );
  }
}
