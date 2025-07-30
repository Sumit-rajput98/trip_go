class TourPackage {
  final int id;
  final String name;
  final String slug;
  final String image;
  final int noOfNights;
  final int noOfDays;
  final String detailsDayNight;
  final String publishPrice;
  final String offerPrice;
  final List<TopInclusion> topInclusions;
  final List<String> packageThemes;

  TourPackage({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
    required this.noOfNights,
    required this.noOfDays,
    required this.detailsDayNight,
    required this.publishPrice,
    required this.offerPrice,
    required this.topInclusions,
    required this.packageThemes,
  });

  factory TourPackage.fromJson(Map<String, dynamic> json) {
    return TourPackage(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      image: json['image'] ?? '',
      noOfNights: json['no_of_nights'] ?? 0,
      noOfDays: json['no_of_days'] ?? 0,
      detailsDayNight: json['details_day_night'] ?? '',
      publishPrice: json['publish_price']?.toString() ?? '',
      offerPrice: json['offer_price']?.toString() ?? '',
      topInclusions: (json['top_inclusion'] is List)
          ? (json['top_inclusion'] as List)
          .whereType<Map<String, dynamic>>()
          .map((i) => TopInclusion.fromJson(i))
          .toList()
          : [],
      packageThemes: (json['package_theme'] is List)
          ? List<String>.from(json['package_theme'].whereType<String>())
          : [],
    );
  }
}

class TopInclusion {
  final int id;
  final String name;
  final String image;

  TopInclusion({
    required this.id,
    required this.name,
    required this.image,
  });

  factory TopInclusion.fromJson(Map<String, dynamic> json) {
    return TopInclusion(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      image: json['image'] ?? '',
    );
  }
}

