class CabBookingResponse {
  final bool success;
  final String message;
  final CabBookingData? data;

  CabBookingResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory CabBookingResponse.fromJson(Map<String, dynamic> json) {
    return CabBookingResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? CabBookingData.fromJson(json['data']) : null,
    );
  }
}

class CabBookingData {
  final String message;
  final CabBooking booking;

  CabBookingData({
    required this.message,
    required this.booking,
  });

  factory CabBookingData.fromJson(Map<String, dynamic> json) {
    return CabBookingData(
      message: json['message'] ?? '',
      booking: CabBooking.fromJson(json['data']['booking']),
    );
  }
}

class CabBooking {
  final String orderNo;
  final String invoiceNo;
  final String name;
  final String email;
  final int phoneCode;
  final int phone;
  final String type;
  final String pickup;
  final List<dynamic> drop;
  final String startDate;
  final String startTime;
  final String endDate;
  final String endTime;
  final int totalDays;
  final String? productName;
  final String? termsAndConditions;
  final String? toll;
  final String? tax;
  final String? driverAllowance;
  final String? nightCharges;
  final String? parking;
  final int? extraPerKm;
  final int? distance;
  final int subtotal;
  final int total;
  final int paidAmount;
  final int dueAmount;
  final int totalSeats;
  final String cancellation;
  final String image;
  final int userId;
  final int creatorId;
  final int productId;
  final String status;
  final String? paymentMode;
  final String? paymentConfirmed;
  final String? postedFrom;
  final String createdAt;
  final String updatedAt;
  final int discount;
  final String? trip;
  final int? canComplete;
  final int? canCancel;

  CabBooking({
    required this.orderNo,
    required this.invoiceNo,
    required this.name,
    required this.email,
    required this.phoneCode,
    required this.phone,
    required this.type,
    required this.pickup,
    required this.drop,
    required this.startDate,
    required this.startTime,
    required this.endDate,
    required this.endTime,
    required this.totalDays,
    required this.productName,
    required this.termsAndConditions,
    required this.toll,
    required this.tax,
    required this.driverAllowance,
    required this.nightCharges,
    required this.parking,
    required this.extraPerKm,
    required this.distance,
    required this.subtotal,
    required this.total,
    required this.paidAmount,
    required this.dueAmount,
    required this.totalSeats,
    required this.cancellation,
    required this.image,
    required this.userId,
    required this.creatorId,
    required this.productId,
    required this.status,
    required this.paymentMode,
    required this.paymentConfirmed,
    required this.postedFrom,
    required this.createdAt,
    required this.updatedAt,
    required this.discount,
    required this.trip,
    required this.canComplete,
    required this.canCancel,
  });

  factory CabBooking.fromJson(Map<String, dynamic> json) {
    return CabBooking(
      orderNo: json['order_no'] ?? '',
      invoiceNo: json['invoice_no'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phoneCode: json['phone_code'] ?? 91,
      phone: int.tryParse(json['phone'].toString()) ?? 0,
      type: json['type'] ?? '',
      pickup: json['pickup'] ?? '',
      drop: json['drop'] ?? [],
      startDate: json['start_date'] ?? '',
      startTime: json['start_time'] ?? '',
      endDate: json['end_date'] ?? '',
      endTime: json['end_time'] ?? '',
      totalDays: json['total_days'] ?? 1,
      productName: json['product_name'],
      termsAndConditions: json['terms_and_conditions'],
      toll: json['toll'],
      tax: json['tax'],
      driverAllowance: json['driver_allowance'],
      nightCharges: json['night_charges'],
      parking: json['parking'],
      extraPerKm: json['extra_per_km'],
      distance: json['distance'],
      subtotal: json['subtotal'] ?? 0,
      total: json['total'] ?? 0,
      paidAmount: json['paid_amount'] ?? 0,
      dueAmount: json['due_amount'] ?? 0,
      totalSeats: json['total_seats'] ?? 0,
      cancellation: json['cancellation'] ?? '',
      image: json['image'] ?? '',
      userId: json['user_id'] ?? 0,
      creatorId: json['creator_id'] ?? 0,
      productId: json['product_id'] ?? 0,
      status: json['status'] ?? '',
      paymentMode: json['payment_mode'],
      paymentConfirmed: json['payment_confirmed'],
      postedFrom: json['posted_from'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      discount: int.tryParse(
          json['discount'].toString().replaceAll(RegExp(r'[^0-9]'), '')
      ) ?? 0,
      trip: json['trip']?.toString(),
      canComplete: json['can_complete'],
      canCancel: json['can_cancel'],
    );
  }
}
