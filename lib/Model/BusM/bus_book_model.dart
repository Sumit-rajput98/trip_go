class BusBookResponse {
  final bool success;
  final String message;
  final BookResult data;

  BusBookResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory BusBookResponse.fromJson(Map<String, dynamic> json) {
    return BusBookResponse(
      success: json['success'],
      message: json['message'],
      data: BookResult.fromJson(json['data']['BookResult']),
    );
  }
}

class BookResult {
  final int responseStatus;
  final BookError error;
  final String traceId;
  final String busBookingStatus;
  final double invoiceAmount;
  final String invoiceNumber;
  final int busId;
  final String ticketNo;
  final String travelOperatorPNR;

  BookResult({
    required this.responseStatus,
    required this.error,
    required this.traceId,
    required this.busBookingStatus,
    required this.invoiceAmount,
    required this.invoiceNumber,
    required this.busId,
    required this.ticketNo,
    required this.travelOperatorPNR,
  });

  factory BookResult.fromJson(Map<String, dynamic> json) {
    return BookResult(
      responseStatus: json['ResponseStatus'],
      error: BookError.fromJson(json['Error']),
      traceId: json['TraceId'],
      busBookingStatus: json['BusBookingStatus'],
      invoiceAmount: (json['InvoiceAmount'] as num).toDouble(),
      invoiceNumber: json['InvoiceNumber'],
      busId: json['BusId'],
      ticketNo: json['TicketNo'],
      travelOperatorPNR: json['TravelOperatorPNR'],
    );
  }
}

class BookError {
  final int errorCode;
  final String errorMessage;

  BookError({
    required this.errorCode,
    required this.errorMessage,
  });

  factory BookError.fromJson(Map<String, dynamic> json) {
    return BookError(
      errorCode: json['ErrorCode'],
      errorMessage: json['ErrorMessage'],
    );
  }
}
