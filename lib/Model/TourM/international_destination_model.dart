class InternationalDestinationModel {
  final int id;
  final String name;
  final String slug;
  final String image;

  InternationalDestinationModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
  });

  factory InternationalDestinationModel.fromJson(Map<String, dynamic> json) {
    return InternationalDestinationModel(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      image: json['image'],
    );
  }
}