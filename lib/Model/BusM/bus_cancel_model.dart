class BusCancelModel {
  final bool success;
  final String message;
  final BusCancelData? data;

  BusCancelModel({
    required this.success,
    required this.message,
    this.data,
  });

  factory BusCancelModel.fromJson(Map<String, dynamic> json) {
    return BusCancelModel(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? BusCancelData.fromJson(json['data']) : null,
    );
  }
}

class BusCancelData {
  final ChangeRequestResult? result;

  BusCancelData({this.result});

  factory BusCancelData.fromJson(Map<String, dynamic> json) {
    return BusCancelData(
      result: json['GetChangeRequestStatusResult'] != null
          ? ChangeRequestResult.fromJson(json['GetChangeRequestStatusResult'])
          : null,
    );
  }
}

class ChangeRequestResult {
  final int responseStatus;
  final ErrorModel error;
  final String traceId;
  final List<BusCRInfo> busCRInfo;

  ChangeRequestResult({
    required this.responseStatus,
    required this.error,
    required this.traceId,
    required this.busCRInfo,
  });

  factory ChangeRequestResult.fromJson(Map<String, dynamic> json) {
    return ChangeRequestResult(
      responseStatus: json['ResponseStatus'],
      error: ErrorModel.fromJson(json['Error']),
      traceId: json['TraceId'],
      busCRInfo: List<BusCRInfo>.from(
        json['BusCRInfo'].map((x) => BusCRInfo.fromJson(x)),
      ),
    );
  }
}

class ErrorModel {
  final int errorCode;
  final String errorMessage;

  ErrorModel({required this.errorCode, required this.errorMessage});

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      errorCode: json['ErrorCode'],
      errorMessage: json['ErrorMessage'],
    );
  }
}

class BusCRInfo {
  final CancellationChargeBreakUp cancellationChargeBreakUp;
  final int changeRequestId;
  final String creditNoteNo;
  final String creditNoteCreatedOn;
  final double totalPrice;
  final double refundedAmount;
  final double cancellationCharge;
  final double totalServiceCharge;
  final double totalGSTAmount;
  final GST gst;

  BusCRInfo({
    required this.cancellationChargeBreakUp,
    required this.changeRequestId,
    required this.creditNoteNo,
    required this.creditNoteCreatedOn,
    required this.totalPrice,
    required this.refundedAmount,
    required this.cancellationCharge,
    required this.totalServiceCharge,
    required this.totalGSTAmount,
    required this.gst,
  });

  factory BusCRInfo.fromJson(Map<String, dynamic> json) {
    return BusCRInfo(
      cancellationChargeBreakUp:
      CancellationChargeBreakUp.fromJson(json['CancellationChargeBreakUp']),
      changeRequestId: json['ChangeRequestId'],
      creditNoteNo: json['CreditNoteNo'],
      creditNoteCreatedOn: json['CreditNoteCreatedOn'],
      totalPrice: json['TotalPrice'].toDouble(),
      refundedAmount: json['RefundedAmount'].toDouble(),
      cancellationCharge: json['CancellationCharge'].toDouble(),
      totalServiceCharge: json['TotalServiceCharge'].toDouble(),
      totalGSTAmount: json['TotalGSTAmount'].toDouble(),
      gst: GST.fromJson(json['GST']),
    );
  }
}

class CancellationChargeBreakUp {
  final double cancellationFees;
  final double cancellationServiceCharge;

  CancellationChargeBreakUp({
    required this.cancellationFees,
    required this.cancellationServiceCharge,
  });

  factory CancellationChargeBreakUp.fromJson(Map<String, dynamic> json) {
    return CancellationChargeBreakUp(
      cancellationFees: json['CancellationFees'].toDouble(),
      cancellationServiceCharge: json['CancellationServiceCharge'].toDouble(),
    );
  }
}

class GST {
  final double cgstAmount;
  final double cgstRate;
  final double cessAmount;
  final double cessRate;
  final double igstAmount;
  final double igstRate;
  final double sgstAmount;
  final double sgstRate;
  final double taxableAmount;

  GST({
    required this.cgstAmount,
    required this.cgstRate,
    required this.cessAmount,
    required this.cessRate,
    required this.igstAmount,
    required this.igstRate,
    required this.sgstAmount,
    required this.sgstRate,
    required this.taxableAmount,
  });

  factory GST.fromJson(Map<String, dynamic> json) {
    return GST(
      cgstAmount: json['CGSTAmount'].toDouble(),
      cgstRate: json['CGSTRate'].toDouble(),
      cessAmount: json['CessAmount'].toDouble(),
      cessRate: json['CessRate'].toDouble(),
      igstAmount: json['IGSTAmount'].toDouble(),
      igstRate: json['IGSTRate'].toDouble(),
      sgstAmount: json['SGSTAmount'].toDouble(),
      sgstRate: json['SGSTRate'].toDouble(),
      taxableAmount: json['TaxableAmount'].toDouble(),
    );
  }
}
