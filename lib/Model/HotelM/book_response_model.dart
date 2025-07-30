// To parse this JSON data, do
//
//     final bookResponseModel = bookResponseModelFromJson(jsonString);

import 'dart:convert';

BookResponseModel bookResponseModelFromJson(String str) => BookResponseModel.fromJson(json.decode(str));

String bookResponseModelToJson(BookResponseModel data) => json.encode(data.toJson());

class BookResponseModel {
    final bool? success;
    final String? message;
    final Data? data;

    BookResponseModel({
        this.success,
        this.message,
        this.data,
    });

    factory BookResponseModel.fromJson(Map<String, dynamic> json) => BookResponseModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
    final BookResult? bookResult;

    Data({
        this.bookResult,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        bookResult: json["BookResult"] == null ? null : BookResult.fromJson(json["BookResult"]),
    );

    Map<String, dynamic> toJson() => {
        "BookResult": bookResult?.toJson(),
    };
}

class BookResult {
    final bool? voucherStatus;
    final int? responseStatus;
    final Error? error;
    final String? traceId;
    final int? status;
    final String? hotelBookingStatus;
    final String? invoiceNumber;
    final String? confirmationNo;
    final dynamic bookingRefNo;
    final int? bookingId;
    final bool? isPriceChanged;
    final bool? isCancellationPolicyChanged;

    BookResult({
        this.voucherStatus,
        this.responseStatus,
        this.error,
        this.traceId,
        this.status,
        this.hotelBookingStatus,
        this.invoiceNumber,
        this.confirmationNo,
        this.bookingRefNo,
        this.bookingId,
        this.isPriceChanged,
        this.isCancellationPolicyChanged,
    });

    factory BookResult.fromJson(Map<String, dynamic> json) => BookResult(
        voucherStatus: json["VoucherStatus"],
        responseStatus: json["ResponseStatus"],
        error: json["Error"] == null ? null : Error.fromJson(json["Error"]),
        traceId: json["TraceId"],
        status: json["Status"],
        hotelBookingStatus: json["HotelBookingStatus"],
        invoiceNumber: json["InvoiceNumber"],
        confirmationNo: json["ConfirmationNo"],
        bookingRefNo: json["BookingRefNo"],
        bookingId: json["BookingId"],
        isPriceChanged: json["IsPriceChanged"],
        isCancellationPolicyChanged: json["IsCancellationPolicyChanged"],
    );

    Map<String, dynamic> toJson() => {
        "VoucherStatus": voucherStatus,
        "ResponseStatus": responseStatus,
        "Error": error?.toJson(),
        "TraceId": traceId,
        "Status": status,
        "HotelBookingStatus": hotelBookingStatus,
        "InvoiceNumber": invoiceNumber,
        "ConfirmationNo": confirmationNo,
        "BookingRefNo": bookingRefNo,
        "BookingId": bookingId,
        "IsPriceChanged": isPriceChanged,
        "IsCancellationPolicyChanged": isCancellationPolicyChanged,
    };
}

class Error {
    final int? errorCode;
    final String? errorMessage;

    Error({
        this.errorCode,
        this.errorMessage,
    });

    factory Error.fromJson(Map<String, dynamic> json) => Error(
        errorCode: json["ErrorCode"],
        errorMessage: json["ErrorMessage"],
    );

    Map<String, dynamic> toJson() => {
        "ErrorCode": errorCode,
        "ErrorMessage": errorMessage,
    };
}
