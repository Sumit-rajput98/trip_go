class BusCity {
  final int id;
  final String cityId;
  final String cityName;

  BusCity({
    required this.id,
    required this.cityId,
    required this.cityName,
  });

  factory BusCity.fromJson(Map<String, dynamic> json) {
    return BusCity(
      id: json['Id'] ?? 0,
      cityId: json['CityId'] ?? '',
      cityName: json['CityName'] ?? '',
    );
  }
}
