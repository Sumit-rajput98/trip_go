import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trip_go/constants.dart';

class BenefitsSection extends StatelessWidget {
  const BenefitsSection({super.key});

  final List<Map<String, String>> benefitItems = const [
    {
      'icon': 'https://tripgoonline.com/Images/Icons/esy-flights.svg',
      'title': 'Easy Booking',
      'subtitle': 'Book Flights Easily and Grab Exciting Offers!',
    },
    {
      'icon': 'https://tripgoonline.com/Images/Icons/down-arrows.svg',
      'title': 'Lowest Price',
      'subtitle': 'Guaranteed Low Rates on Hotels, Holiday Packages, and Flights!',
    },
    {
      'icon': 'https://tripgoonline.com/Images/Icons/return-boxs.svg',
      'title': 'Instant Refund',
      'subtitle': 'Get Quick and Easy Refunds on All Your Travel Bookings!',
    },
    {
      'icon': 'https://tripgoonline.com/Images/Icons/24-hoursa.svg',
      'title': '24/7 Support',
      'subtitle': '24/7 Support for All Your Travel Queries — We’re Here to Help!',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 10),
          RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Poppins',
                color: Colors.black,
              ),
              children: [
                TextSpan(text: 'Our '),
                TextSpan(
                  text: 'Benefits',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                ),
                TextSpan(text: ' & Key Advantages'),
              ],
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'TripGo, a tour operator specializing in dream destinations, offers a variety of benefits for travelers.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              fontFamily: 'Poppins',
              color: Colors.black87,
            ),
          ),
          // const SizedBox(height: 10),

          // Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: benefitItems.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 2 : 4,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 3 / 2.9,
            ),
            itemBuilder: (context, index) {
              final item = benefitItems[index];
              return Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 4,
                      offset: const Offset(1, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.network(
                      item['icon']!,
                      height: 28, // Smaller icon
                      width: 28,
                      placeholderBuilder: (_) => const SizedBox(
                        height: 28,
                        width: 28,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item['title']!,
                      style: const TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item['subtitle']!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 11.5,
                        fontFamily: 'Poppins',
                        color: Colors.black87,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
