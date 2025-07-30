class CabVerifyPaymentModel {
  final bool success;
  final String message;
  final CabOrderDetails? orderDetails;

  CabVerifyPaymentModel({
    required this.success,
    required this.message,
    this.orderDetails,
  });

  factory CabVerifyPaymentModel.fromJson(Map<String, dynamic> json) {
    return CabVerifyPaymentModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      orderDetails: json['data'] != null && json['data']['order_details'] != null
          ? CabOrderDetails.fromJson(json['data']['order_details'])
          : null,
    );
  }
}

class CabOrderDetails {
  final String orderId;
  final String? paymentId;
  final int amount;
  final String currency;
  final int status;
  final String type;
  final String service;
  final String createdAt;
  final String updatedAt;
  final int id;

  CabOrderDetails({
    required this.orderId,
    required this.paymentId,
    required this.amount,
    required this.currency,
    required this.status,
    required this.type,
    required this.service,
    required this.createdAt,
    required this.updatedAt,
    required this.id,
  });

  factory CabOrderDetails.fromJson(Map<String, dynamic> json) {
    return CabOrderDetails(
      orderId: json['order_id'] ?? '',
      paymentId: json['payment_id'],
      amount: json['amount'] ?? 0,
      currency: json['currency'] ?? '',
      status: json['status'] ?? 0,
      type: json['type'] ?? '',
      service: json['service'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      id: json['id'] ?? 0,
    );
  }
}
