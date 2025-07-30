class BusVerifyPaymentResponse {
  final bool success;
  final String message;
  final PaymentData data;

  BusVerifyPaymentResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory BusVerifyPaymentResponse.fromJson(Map<String, dynamic> json) {
    return BusVerifyPaymentResponse(
      success: json['success'],
      message: json['message'],
      data: PaymentData.fromJson(json['data']),
    );
  }
}

class PaymentData {
  final String paymentId;
  final OrderDetails orderDetails;

  PaymentData({
    required this.paymentId,
    required this.orderDetails,
  });

  factory PaymentData.fromJson(Map<String, dynamic> json) {
    return PaymentData(
      paymentId: json['PaymentId'],
      orderDetails: OrderDetails.fromJson(json['order_details']),
    );
  }
}

class OrderDetails {
  final String orderId;
  final String paymentId;
  final int amount;
  final String currency;
  final int status;
  final String type;
  final String service;
  final String createdAtRazorpay;
  final String updatedAt;
  final String createdAt;
  final int id;

  OrderDetails({
    required this.orderId,
    required this.paymentId,
    required this.amount,
    required this.currency,
    required this.status,
    required this.type,
    required this.service,
    required this.createdAtRazorpay,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory OrderDetails.fromJson(Map<String, dynamic> json) {
    return OrderDetails(
      orderId: json['order_id'],
      paymentId: json['payment_id'],
      amount: json['amount'],
      currency: json['currency'],
      status: json['status'],
      type: json['type'],
      service: json['service'],
      createdAtRazorpay: json['created_at_razorpay'],
      updatedAt: json['updated_at'],
      createdAt: json['created_at'],
      id: json['id'],
    );
  }
}
