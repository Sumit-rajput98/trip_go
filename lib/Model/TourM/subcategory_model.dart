class SubCategoryModel {
  final String destinationName;
  final String packageName;
  final int offerPrice;
  final int publishPrice;
  final int nights;
  final int days;
  final String detailsDayNight;
  final String overview;
  final List<String> inclusions;
  final List<String> exclusions;
  final List<String> tourPolicy;
  final List<String> cancellationPolicy;
  final List<String> paymentPolicy;
  final List<String> gallery;
  final List<Itinerary> itinerary;

  SubCategoryModel({
    required this.destinationName,
    required this.packageName,
    required this.offerPrice,
    required this.publishPrice,
    required this.nights,
    required this.days,
    required this.detailsDayNight,
    required this.overview,
    required this.inclusions,
    required this.exclusions,
    required this.tourPolicy,
    required this.cancellationPolicy,
    required this.paymentPolicy,
    required this.gallery,
    required this.itinerary,
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
      detailsDayNight: data['details_day_night'],
      overview: data['package_overview'],
      inclusions: List<String>.from(data['package_inclusions']),
      exclusions: List<String>.from(data['package_exclusions']),
      tourPolicy: List<String>.from(json['data']['tour_policy']),
      cancellationPolicy: List<String>.from(json['data']['cancelation_policy']),
      paymentPolicy: List<String>.from(json['data']['payment_policy']),
      gallery: List<String>.from(data['package_gallery'].map((g) => g['image'])),
      itinerary: List<Itinerary>.from(data['package_itinerary'].map((e) => Itinerary.fromJson(e))),
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
