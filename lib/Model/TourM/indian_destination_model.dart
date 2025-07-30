class IndianDestination {
  final int id;
  final String name;
  final String slug;
  final String image;

  IndianDestination({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
  });

  factory IndianDestination.fromJson(Map<String, dynamic> json) {
    return IndianDestination(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      image: json['image'],
    );
  }
}