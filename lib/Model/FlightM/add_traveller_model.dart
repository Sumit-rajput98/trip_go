class Traveller {
  String? title;       // Mr, Mrs, Ms, etc.
  String firstName;
  String lastName;
  String? email;
  String? dateOfBirth; // in yyyy-MM-dd format
  bool isSelected;

  Traveller({
    this.title,
    required this.firstName,
    required this.lastName,
    this.email,
    this.dateOfBirth,
    this.isSelected = false,
  });

  // Optional: Helper to get full name
  String get name => '$title $firstName $lastName'.trim();
}
