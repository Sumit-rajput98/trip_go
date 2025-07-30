class CabCancelModel {
  final bool success;
  final String message;
  final CabCancelData? data;

  CabCancelModel({
    required this.success,
    required this.message,
    this.data,
  });

  factory CabCancelModel.fromJson(Map<String, dynamic> json) {
    return CabCancelModel(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? CabCancelData.fromJson(json['data']) : null,
    );
  }
}

class CabCancelData {
  final String message;
  final bool success;
  final String? reason;

  CabCancelData({
    required this.message,
    required this.success,
    this.reason,
  });

  factory CabCancelData.fromJson(Map<String, dynamic> json) {
    return CabCancelData(
      message: json['message'],
      success: json['success'],
      reason: json['reason'],
    );
  }
}