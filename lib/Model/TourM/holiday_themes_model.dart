class HolidayTheme {
  final int id;
  final String name;
  final String slug;
  final String image;

  HolidayTheme({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
  });

  factory HolidayTheme.fromJson(Map<String, dynamic> json) {
    return HolidayTheme(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      image: json['image'],
    );
  }
}
