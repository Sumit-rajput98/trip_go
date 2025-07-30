import 'bus_seat_model.dart';

class SelectedSeatModel {
  final String seatName;
  final String seatIndex;
  final String rowNo;
  final String columnNo;
  final bool isLadiesSeat;
  final bool isMalesSeat;
  final bool isUpper;
  final int seatType;
  final int height;
  final int width;
  final bool seatStatus;
  final Price price;

  SelectedSeatModel({
    required this.seatName,
    required this.seatIndex,
    required this.rowNo,
    required this.columnNo,
    required this.isLadiesSeat,
    required this.isMalesSeat,
    required this.isUpper,
    required this.seatType,
    required this.height,
    required this.width,
    required this.seatStatus,
    required this.price,
  });

  factory SelectedSeatModel.fromJson(Map<String, dynamic> json) {
    return SelectedSeatModel(
      seatName: json['SeatName'] ?? '',
      seatIndex: json['SeatIndex'].toString(),
      rowNo: json['RowNo'] ?? '',
      columnNo: json['ColumnNo'] ?? '',
      isLadiesSeat: json['IsLadiesSeat'] ?? false,
      isMalesSeat: json['IsMalesSeat'] ?? false,
      isUpper: json['IsUpper'] ?? false,
      seatType: json['SeatType'] ?? 0,
      height: json['Height'] ?? 1,
      width: json['Width'] ?? 1,
      seatStatus: json['SeatStatus'] ?? true,
      price: Price.fromJson(json['Price'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
    "SeatName": seatName,
    "SeatIndex": seatIndex,
    "RowNo": rowNo,
    "ColumnNo": columnNo,
    "IsLadiesSeat": isLadiesSeat,
    "IsMalesSeat": isMalesSeat,
    "IsUpper": isUpper,
    "SeatType": seatType,
    "Height": height,
    "Width": width,
    "SeatStatus": seatStatus,
    "Price": price.toJson(),
  };
}
