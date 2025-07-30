class HotelVerifyPaymentResponse {
  final bool success;
  final String message;
  final HotelVerifyPaymentData? data;

  HotelVerifyPaymentResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory HotelVerifyPaymentResponse.fromJson(Map<String, dynamic> json) {
    return HotelVerifyPaymentResponse(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? HotelVerifyPaymentData.fromJson(json['data']) : null,
    );
  }
}

class HotelVerifyPaymentData {
  final String? paymentId;
  final HotelOrderDetails orderDetails;

  HotelVerifyPaymentData({
    this.paymentId,
    required this.orderDetails,
  });

  factory HotelVerifyPaymentData.fromJson(Map<String, dynamic> json) {
    return HotelVerifyPaymentData(
      paymentId: json['PaymentId'],
      orderDetails: HotelOrderDetails.fromJson(json['order_details']),
    );
  }
}

class HotelOrderDetails {
  final String orderId;
  final String? paymentId;
  final int amount;
  final String currency;
  final int status;
  final String type;
  final String service;
  final String createdAtRazorpay;
  final String updatedAt;
  final String createdAt;
  final int id;

  HotelOrderDetails({
    required this.orderId,
    this.paymentId,
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

  factory HotelOrderDetails.fromJson(Map<String, dynamic> json) {
    return HotelOrderDetails(
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
