import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WhyTripGoSection extends StatelessWidget {
  const WhyTripGoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final themeColor = Colors.redAccent;
    final features = [
      {
        "icon": Icons.taxi_alert,
        "title": "Extensive Options",
        "desc": "Wide range of quality safe and licensed vehicles."
      },
      {
        "icon": Icons.handshake,
        "title": "Convenient",
        "desc": "Enjoy high-quality cab experience at surprisingly low prices."
      },
      {
        "icon": Icons.thumb_up_alt,
        "title": "Easy and Flexible",
        "desc": "Quick booking & free cancellations up to 24 hours."
      },
      {
        "icon": Icons.support_agent,
        "title": "24/7 Support",
        "desc": "We’re here to help you anytime, any day."
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Why TripGo for Cab Booking?",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ...features.map((item) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: themeColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    item["icon"] as IconData,
                    color: themeColor,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item["title"].toString(),
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item["desc"].toString(),
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }
}

class BookingProcessSection extends StatelessWidget {
  const BookingProcessSection({super.key});

  @override
  Widget build(BuildContext context) {
    final steps = [
      {
        "title": "Login to TripGo",
        "desc": "Access our app or site and sign in or register."
      },
      {
        "title": "Navigate to Cabs",
        "desc": "Explore our wide range of cab options."
      },
      {
        "title": "Choose Your Purpose",
        "desc": "Local, outstation or airport ride? We’ve got you."
      },
      {
        "title": "Fill in Details",
        "desc": "Add pickup, drop, date, time and preferences."
      },
      {
        "title": "Book in Clicks",
        "desc": "Confirm your booking and you’re ready to go!"
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 28),
        Text(
          "Simplified Cab Booking Process",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ...steps.map((step) {
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade50,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  step["title"]!,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  step["desc"]!,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}