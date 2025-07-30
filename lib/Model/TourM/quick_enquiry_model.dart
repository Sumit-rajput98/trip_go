class QuickEnquiryModel {
  final String name;
  final String email;
  final String phone;
  final String destination;
  final String message;

  QuickEnquiryModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.destination,
    required this.message,
  });

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "phone": phone,
    "destination": destination,
    "message": message,
  };
}
