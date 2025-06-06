import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchDestinationsSection extends StatelessWidget {
  final List<Map<String, String>> destinations = [
    {
      'title': 'Turkey',
      'image': 'https://dreamstour.dreamstechnologies.com/html/assets/img/destination/destination-01.jpg',
    },
    {
      'title': 'Thailand',
      'image': 'https://dreamstour.dreamstechnologies.com/html/assets/img/destination/destination-02.jpg',
    },
    {
      'title': 'Australia',
      'image': 'https://dreamstour.dreamstechnologies.com/html/assets/img/destination/destination-03.jpg',
    },
    {
      'title': 'Brazil',
      'image': 'https://dreamstour.dreamstechnologies.com/html/assets/img/destination/destination-04.jpg',
    },
    {
      'title': 'Canada',
      'image': 'https://dreamstour.dreamstechnologies.com/html/assets/img/destination/destination-05.jpg',
    },
    // You can add more countries here
  ];

   SearchDestinationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Heading
          Text(
            "Search by Destinations Around the World",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xff212529)
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "TripGo Marketplace is a platform designed to connect fans with exclusive experiences related to a specific tour",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: Color(0xff212529),
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 36),
          // Horizontal ListView
          SizedBox(
            height: 140,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: destinations.length,
              separatorBuilder: (context, index) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final destination = destinations[index];
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    children: [
                      Image.network(
                        destination['image']!,
                        width: 110,
                        height: 140,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 110,
                            height: 140,
                            color: Colors.grey.shade300,
                            child: Icon(Icons.image, color: Colors.grey.shade600),
                          );
                        },
                      ),
                      Container(
                        width: 110,
                        height: 140,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withOpacity(0.6),
                              Colors.transparent,
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 8,
                        left: 8,
                        right: 8,
                        child: Text(
                          destination['title']!,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
