class Traveller {
  String? title;
  String firstName;
  String lastName;
  String? email;
  String? dateOfBirth;
  int paxType; // ✅ Make it nullable
  bool isSelected;

  Traveller({
    this.title,
    required this.firstName,
    required this.lastName,
    this.email,
    this.dateOfBirth,
    required this.paxType,
    this.isSelected = false,
  });

  String get name => '$title $firstName $lastName'.trim();
}