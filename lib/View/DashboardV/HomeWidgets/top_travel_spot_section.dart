import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/TourScreen/tour_category_view.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/TourScreen/tour_subcategory_view.dart';

 // Import the navigation target

class TopTravelSpotsSection extends StatelessWidget {
   TopTravelSpotsSection({super.key});

  final List<TravelSpot> travelSpots =  [
    TravelSpot(
      title: 'Uttarakhand',
      imageUrl:
          'https://admin.tripgoonline.com/public/img/media_gallery/Utrkhand_O56drukKJ3_UE9FDwRNma.jpg',
      slug: 'uttarakhand',
    ),
    TravelSpot(
      title: 'Goa',
      imageUrl:
          'https://admin.tripgoonline.com/public/img/media_gallery/GOA1)d1FajaEdR5_nz9CTWLzMO_V58anJrV4i.jpg',
      slug: 'goa',
    ),
    TravelSpot(
      title: 'Kerala',
      imageUrl:
          'https://admin.tripgoonline.com/public/img/media_gallery/KERALA(1)_uCPzm2JWkY_XZqMftYHlI_7tjHfW91a6.jpg',
      slug: 'kerala',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Uncover India's TopTravel Spots",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "TripGo Marketplace is a platform designed to connect fans with\nexclusive experiences related to a specific tour",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: travelSpots
                .map((spot) => TravelCard(
                      title: spot.title,
                      imageUrl: spot.imageUrl,
                      slug: spot.slug,
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class TravelCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String slug;

  const TravelCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.slug,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => TourCategoryView(name: title, slug: slug),
            ),
          );
        },
        child: Container(
          height: 160,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.6),
                      Colors.transparent,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.center,
                  ),
                ),
              ),
              Positioned(
                left: 12,
                bottom: 12,
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
class TravelSpot {
  final String title;
  final String imageUrl;
  final String slug;

  TravelSpot({
    required this.title,
    required this.imageUrl,
    required this.slug,
  });
}
