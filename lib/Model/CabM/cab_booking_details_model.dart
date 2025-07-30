class CabBookingDetailsModel {
  final bool success;
  final String message;
  final CabBookingData data;

  CabBookingDetailsModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory CabBookingDetailsModel.fromJson(Map<String, dynamic> json) {
    return CabBookingDetailsModel(
      success: json['success'],
      message: json['message'],
      data: CabBookingData.fromJson(json['data']),
    );
  }
}

class CabBookingData {
  final String message;
  final CabOrder order;

  CabBookingData({
    required this.message,
    required this.order,
  });

  factory CabBookingData.fromJson(Map<String, dynamic> json) {
    return CabBookingData(
      message: json['message'],
      order: CabOrder.fromJson(json['data']['order']),
    );
  }
}

class CabOrder {
  final int id;
  final String orderNo;
  final String invoiceNo;
  final String name;
  final String phone;
  final String email;
  final String type;
  final String pickup;
  final double plat;
  final double plng;
  final List<DropLocation> drop;
  final String startDate;
  final String startTime;
  final String productName;
  final String termsAndConditions;
  final String image;
  final String status;
  final int total;
  final int dueAmount;

  CabOrder({
    required this.id,
    required this.orderNo,
    required this.invoiceNo,
    required this.name,
    required this.phone,
    required this.email,
    required this.type,
    required this.pickup,
    required this.plat,
    required this.plng,
    required this.drop,
    required this.startDate,
    required this.startTime,
    required this.productName,
    required this.termsAndConditions,
    required this.image,
    required this.status,
    required this.total,
    required this.dueAmount,
  });

  factory CabOrder.fromJson(Map<String, dynamic> json) {
    return CabOrder(
      id: json['id'],
      orderNo: json['order_no'],
      invoiceNo: json['invoice_no'] ?? '',
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      type: json['type'],
      pickup: json['pickup'],
      plat: json['plat'].toDouble(),
      plng: json['plng'].toDouble(),
      drop: (json['drop'] as List)
          .map((e) => DropLocation.fromJson(e))
          .toList(),
      startDate: json['start_date'],
      startTime: json['start_time'],
      productName: json['product_name'],
      termsAndConditions: json['terms_and_conditions'],
      image: json['image'],
      status: json['status'],
      total: json['total'],
      dueAmount: json['due_amount'],
    );
  }
}

class DropLocation {
  final String drop;
  final String dlat;
  final String dlng;

  DropLocation({
    required this.drop,
    required this.dlat,
    required this.dlng,
  });

  factory DropLocation.fromJson(Map<String, dynamic> json) {
    return DropLocation(
      drop: json['drop'],
      dlat: json['dlat'],
      dlng: json['dlng'],
    );
  }
}
