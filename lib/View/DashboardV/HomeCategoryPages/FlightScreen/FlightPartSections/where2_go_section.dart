import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Where2GoSection extends StatelessWidget {
  final List<Map<String, String>> destinations = [
    {
      'title': 'Relax on the beach',
      'subtitle': 'Explore Destinations',
      'image': 'https://promos.makemytrip.com/Growth/Images/B2C/xhdpi/PWA_TPI_Beach.jpg?crop=122:201&downsize=122:201',
    },
    {
      'title': 'Getaways to the Mountains',
      'subtitle': 'Themed Recommendation',
      'image': 'https://promos.makemytrip.com/Growth/Images/B2C/xhdpi/PWA_TPI_Mountains.jpg?crop=122:201&downsize=122:201',
    },
    {
      'title': 'Honeymoon Hotspots',
      'subtitle': 'Discover by Interest',
      'image': 'https://promos.makemytrip.com/Growth/Images/B2C/xhdpi/PWA_TPI_HMoon.jpg?crop=122:201&downsize=122:201',
    },
    {
      'title': 'Post travel photos and videos',
      'subtitle': 'Share your Travel Story',
      'image': 'https://hblimg.mmtcdn.com/content/hubble/img/images/mmt/activities/m_Trip_Idea_July_Orange_4x_l_341_452.jpg?crop=122:201&downsize=122:201',
    },
  ];

   Where2GoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "WHERE2GO",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Row(
                  children: [
                    Text(
                      "View All",
                      style: GoogleFonts.poppins(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.arrow_forward, size: 16, color: Colors.blue),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.2,
            ),
            itemCount: destinations.length,
            itemBuilder: (context, index) {
              final destination = destinations[index];
              return Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      destination['image']!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(Icons.image, color: Colors.grey.shade600, size: 40),
                        );
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
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
                    bottom: 12,
                    left: 12,
                    right: 12,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          destination['subtitle']!,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          destination['title']!,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
