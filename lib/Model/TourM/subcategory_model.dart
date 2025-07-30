class SubCategoryModel {
  final String destinationName;
  final String packageName;
  final int offerPrice;
  final int publishPrice;
  final int nights;
  final int days;
  final int id;
  final String detailsDayNight;
  final String overview;
  final List<String> inclusions;
  final List<String> exclusions;
  final List<String> tourPolicy;
  final List<String> cancellationPolicy;
  final List<String> paymentPolicy;
  final List<GalleryImage> gallery;
  final List<Itinerary> itinerary;
  final List<SimilarPackage>? similarPackages;

  SubCategoryModel({
    required this.destinationName,
    required this.packageName,
    required this.offerPrice,
    required this.publishPrice,
    required this.nights,
    required this.days,
    required this.id,
    required this.detailsDayNight,
    required this.overview,
    required this.inclusions,
    required this.exclusions,
    required this.tourPolicy,
    required this.cancellationPolicy,
    required this.paymentPolicy,
    required this.gallery,
    required this.itinerary,
    required this.similarPackages,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    final data = json['data']['packagedetail'];

    return SubCategoryModel(
      destinationName: json['data']['destination_name'],
      packageName: data['name'],
      offerPrice: data['offer_price'],
      publishPrice: data['publish_price'],
      nights: data['nights'],
      days: data['days'],
      id: data['id'],
      detailsDayNight: data['details_day_night'],
      overview: data['package_overview'],
      inclusions: List<String>.from(data['package_inclusions']),
      exclusions: List<String>.from(data['package_exclusions']),
      tourPolicy: List<String>.from(json['data']['tour_policy']),
      cancellationPolicy: List<String>.from(json['data']['cancelation_policy']),
      paymentPolicy: List<String>.from(json['data']['payment_policy']),
      gallery: (json['package_gallery'] as List<dynamic>?)
          ?.map((item) => GalleryImage.fromJson(item))
          .toList() ?? [],
      itinerary: List<Itinerary>.from(data['package_itinerary'].map((e) => Itinerary.fromJson(e))),
      similarPackages: (json['data']['similar_packages'] as List?)?.map((e) => SimilarPackage.fromJson(e)).toList(),
    );
  }
}

class Itinerary {
  final String title;
  final String details;

  Itinerary({required this.title, required this.details});

  factory Itinerary.fromJson(Map<String, dynamic> json) {
    return Itinerary(
      title: json['title'],
      details: json['details'],
    );
  }
}


class SimilarPackage {
  final int id;
  final String name;
  final String image;
  final int price;
  final String detailsDayNight;
  final int day;
  final int night;
  final String slug;

  SimilarPackage({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.detailsDayNight,
    required this.day,
    required this.night,
    required this.slug,
  });

  factory SimilarPackage.fromJson(Map<String, dynamic> json) {
    return SimilarPackage(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      price: json['price'],
      detailsDayNight: json['details_day_night'],
      day: json['day'],
      night: json['night'],
      slug: json['slug'],
    );
  }
}

class GalleryImage {
  final int id;
  final String image;
  final String imageAlt;

  GalleryImage({
    required this.id,
    required this.image,
    required this.imageAlt,
  });

  factory GalleryImage.fromJson(Map<String, dynamic> json) {
    return GalleryImage(
      id: json['id'] ?? 0,
      image: json['image'] ?? '',
      imageAlt: json['image_alt'] ?? '',
    );
  }
}
