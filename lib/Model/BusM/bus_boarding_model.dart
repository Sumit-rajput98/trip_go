class BusBoardingModel {
  final bool success;
  final String message;
  final GetBusRouteDetailResult data;

  BusBoardingModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory BusBoardingModel.fromJson(Map<String, dynamic> json) {
    return BusBoardingModel(
      success: json['success'],
      message: json['message'],
      data: GetBusRouteDetailResult.fromJson(json['data']['GetBusRouteDetailResult']),
    );
  }
}

class GetBusRouteDetailResult {
  final int responseStatus;
  final ErrorModel error;
  final String traceId;
  final List<CityPointDetail> boardingPointsDetails;
  final List<CityPointDetail> droppingPointsDetails;

  GetBusRouteDetailResult({
    required this.responseStatus,
    required this.error,
    required this.traceId,
    required this.boardingPointsDetails,
    required this.droppingPointsDetails,
  });

  factory GetBusRouteDetailResult.fromJson(Map<String, dynamic> json) {
    return GetBusRouteDetailResult(
      responseStatus: json['ResponseStatus'],
      error: ErrorModel.fromJson(json['Error']),
      traceId: json['TraceId'],
      boardingPointsDetails: (json['BoardingPointsDetails'] as List)
          .map((e) => CityPointDetail.fromJson(e))
          .toList(),
      droppingPointsDetails: (json['DroppingPointsDetails'] as List)
          .map((e) => CityPointDetail.fromJson(e))
          .toList(),
    );
  }
}

class ErrorModel {
  final int errorCode;
  final String errorMessage;

  ErrorModel({
    required this.errorCode,
    required this.errorMessage,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      errorCode: json['ErrorCode'],
      errorMessage: json['ErrorMessage'],
    );
  }
}

class CityPointDetail {
  final int cityPointIndex;
  final String cityPointName;
  final String cityPointLocation;
  final String? cityPointAddress;
  final String? cityPointContactNumber;
  final String? cityPointLandmark;
  final String cityPointTime;

  CityPointDetail({
    required this.cityPointIndex,
    required this.cityPointName,
    required this.cityPointLocation,
    this.cityPointAddress,
    this.cityPointContactNumber,
    this.cityPointLandmark,
    required this.cityPointTime,
  });

  factory CityPointDetail.fromJson(Map<String, dynamic> json) {
    return CityPointDetail(
      cityPointIndex: json['CityPointIndex'],
      cityPointName: json['CityPointName'],
      cityPointLocation: json['CityPointLocation'],
      cityPointAddress: json['CityPointAddress'],
      cityPointContactNumber: json['CityPointContactNumber'],
      cityPointLandmark: json['CityPointLandmark'],
      cityPointTime: json['CityPointTime'],
    );
  }
}
