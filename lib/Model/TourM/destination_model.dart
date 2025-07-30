class DestinationModel {
  final int id;
  final String name;
  final String slug;
  final String image;
  final String destUrl;

  DestinationModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
    required this.destUrl,
  });

  factory DestinationModel.fromJson(Map<String, dynamic> json) {
    return DestinationModel(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      image: json['image'],
      destUrl: json['dest_url'],
    );
  }
}