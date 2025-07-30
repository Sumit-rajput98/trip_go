class TrendingPackage {
  final int id;
  final String name;
  final String slug;
  final int noOfNights;
  final String offerPrice;
  final String destination;
  final String image;
  final String bookUrl;

  TrendingPackage({
    required this.id,
    required this.name,
    required this.slug,
    required this.noOfNights,
    required this.offerPrice,
    required this.destination,
    required this.image,
    required this.bookUrl,
  });

  factory TrendingPackage.fromJson(Map<String, dynamic> json) {
    return TrendingPackage(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      noOfNights: json['no_of_nights'],
      offerPrice: json['offer_price'],
      destination: json['destination'],
      image: json['image'],
      bookUrl: json['book_url'],
    );
  }
}
