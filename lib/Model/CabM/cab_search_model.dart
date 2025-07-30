class CabSearchModel {
  final bool success;
  final String message;
  final List<CabModel> cabs;

  CabSearchModel({
    required this.success,
    required this.message,
    required this.cabs,
  });

  factory CabSearchModel.fromJson(Map<String, dynamic> json) {
    final cabsJson = json['data']['data']['cabs'] as List;
    return CabSearchModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      cabs: cabsJson.map((e) => CabModel.fromJson(e)).toList(),
    );
  }
}

class CabModel {
  final int id;
  final String name;
  final String description;
  final String toll;
  final String tax;
  final String driverAllowance;
  final String nightCharges;
  final String parking;
  final int extraPerKm;
  final int distance;
  final int mrp;
  final int price;
  final String discount;
  final int totalSeats;
  final String cancellation;
  final String image;

  CabModel({
    required this.id,
    required this.name,
    required this.description,
    required this.toll,
    required this.tax,
    required this.driverAllowance,
    required this.nightCharges,
    required this.parking,
    required this.extraPerKm,
    required this.distance,
    required this.mrp,
    required this.price,
    required this.discount,
    required this.totalSeats,
    required this.cancellation,
    required this.image,
  });

  factory CabModel.fromJson(Map<String, dynamic> json) {
    return CabModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      toll: json['toll'] ?? '',
      tax: json['tax'] ?? '',
      driverAllowance: json['driver_allowance'] ?? '',
      nightCharges: json['night_charges'] ?? '',
      parking: json['parking'] ?? '',
      extraPerKm: json['extra_per_km'] ?? 0,
      distance: json['distance'] ?? 0,
      mrp: json['mrp'] ?? 0,
      price: json['price'] ?? 0,
      discount: json['discount'] ?? '',
      totalSeats: json['total_seats'] ?? 0,
      cancellation: json['cancellation'] ?? '',
      image: json['image'] ?? '',
    );
  }
}
