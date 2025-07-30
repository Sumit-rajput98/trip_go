class PackageInquiryModel {
  final String name;
  final String email;
  final String phone;
  final int adult;
  final int children;
  final int infant;
  final int packageId;
  final String city;
  final String travelDate;

  PackageInquiryModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.adult,
    required this.children,
    this.infant = 0,
    required this.packageId,
    required this.city,
    required this.travelDate,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "phone": phone,
      "adult": adult,
      "children": children,
      "infant": infant,
      "package_id": packageId,
      "city": city,
      "traveldate": travelDate,
    };
  }
}