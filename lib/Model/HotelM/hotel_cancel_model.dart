class HotelCancelModel {
  final bool success;
  final String message;
  final HotelCancelData? data;

  HotelCancelModel({
    required this.success,
    required this.message,
    this.data,
  });

  factory HotelCancelModel.fromJson(Map<String, dynamic> json) {
    return HotelCancelModel(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? HotelCancelData.fromJson(json['data']) : null,
    );
  }
}

class HotelCancelData {
  final GetChangeRequestStatus? getChangeRequestStatus;
  final GetChangeRequestStatusResponse? getChangeRequestStatusResponse;

  HotelCancelData({
    this.getChangeRequestStatus,
    this.getChangeRequestStatusResponse,
  });

  factory HotelCancelData.fromJson(Map<String, dynamic> json) {
    return HotelCancelData(
      getChangeRequestStatus: json['GetChangeRequestStatus'] != null
          ? GetChangeRequestStatus.fromJson(json['GetChangeRequestStatus'])
          : null,
      getChangeRequestStatusResponse: json['GetChangeRequestStatusResponse'] != null
          ? GetChangeRequestStatusResponse.fromJson(json['GetChangeRequestStatusResponse'])
          : null,
    );
  }
}

class GetChangeRequestStatus {
  final int bookingMode;
  final int changeRequestId;
  final String endUserIp;
  final String tokenId;

  GetChangeRequestStatus({
    required this.bookingMode,
    required this.changeRequestId,
    required this.endUserIp,
    required this.tokenId,
  });

  factory GetChangeRequestStatus.fromJson(Map<String, dynamic> json) {
    return GetChangeRequestStatus(
      bookingMode: json['BookingMode'],
      changeRequestId: json['ChangeRequestId'],
      endUserIp: json['EndUserIp'],
      tokenId: json['TokenId'],
    );
  }
}

class GetChangeRequestStatusResponse {
  final HotelChangeRequestStatusResult hotelChangeRequestStatusResult;

  GetChangeRequestStatusResponse({
    required this.hotelChangeRequestStatusResult,
  });

  factory GetChangeRequestStatusResponse.fromJson(Map<String, dynamic> json) {
    return GetChangeRequestStatusResponse(
      hotelChangeRequestStatusResult: HotelChangeRequestStatusResult.fromJson(
        json['HotelChangeRequestStatusResult'],
      ),
    );
  }
}

class HotelChangeRequestStatusResult {
  final int responseStatus;
  final HotelCancelError error;
  final String traceId;
  final int changeRequestId;
  final double refundedAmount;
  final double cancellationCharge;
  final int changeRequestStatus;

  HotelChangeRequestStatusResult({
    required this.responseStatus,
    required this.error,
    required this.traceId,
    required this.changeRequestId,
    required this.refundedAmount,
    required this.cancellationCharge,
    required this.changeRequestStatus,
  });

  factory HotelChangeRequestStatusResult.fromJson(Map<String, dynamic> json) {
    return HotelChangeRequestStatusResult(
      responseStatus: json['ResponseStatus'],
      error: HotelCancelError.fromJson(json['Error']),
      traceId: json['TraceId'],
      changeRequestId: json['ChangeRequestId'],
      refundedAmount: json['RefundedAmount'].toDouble(),
      cancellationCharge: json['CancellationCharge'].toDouble(),
      changeRequestStatus: json['ChangeRequestStatus'],
    );
  }
}

class HotelCancelError {
  final int errorCode;
  final String errorMessage;

  HotelCancelError({
    required this.errorCode,
    required this.errorMessage,
  });

  factory HotelCancelError.fromJson(Map<String, dynamic> json) {
    return HotelCancelError(
      errorCode: json['ErrorCode'],
      errorMessage: json['ErrorMessage'],
    );
  }
}
