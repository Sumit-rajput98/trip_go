class VerifyPaymentResponse {
  final bool success;
  final String message;

  VerifyPaymentResponse({required this.success, required this.message});

  factory VerifyPaymentResponse.fromJson(Map<String, dynamic> json) {
    return VerifyPaymentResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
    );
  }
}