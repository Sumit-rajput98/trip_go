import 'package:flutter/material.dart';
import 'package:trip_go/constants.dart'; // assumes you use kPrimaryColor etc.
import 'package:google_fonts/google_fonts.dart';

class WhyBookWithUsSection extends StatelessWidget {
  const WhyBookWithUsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Heading
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Text(
            "Why book with us?",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),

        /// Top Cards Row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            children: [
              _buildInfoCard(
                icon: Icons.receipt_long_outlined,
                title: "Lowest Ticket Charges",
                subtitle: "Grab huge discounts and\ncashbacks on your bus\nbooking with TripGo.",
              ),
              const SizedBox(width: 12),
              _buildInfoCard(
                icon: Icons.directions_bus_filled_outlined,
                title: "3999+ Bus Operators with us",
                subtitle: "Leverage our partnership\nwith over 3999+ operators\nfor a hassle-free ride.",
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        /// Trustpilot Logo + Stars
        Center(
          child: Column(
            children: [
              const Icon(Icons.star, color: Colors.green, size: 26),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (_) {
                  return const Icon(Icons.star, color: Colors.green, size: 18);
                })..add(const Icon(Icons.star_border, color: Colors.green, size: 18)),
              ),
              const SizedBox(height: 8),
              Text(
                "TrustScore 4.1  |  13,688 reviews",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        /// Review Card Slider (static for now)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.green.shade50,
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: List.generate(5, (_) {
                    return const Icon(Icons.star, color: Colors.green, size: 16);
                  }),
                ),
                const SizedBox(height: 8),
                Text(
                  "I have awesome experience with...",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "I have awesome experience with TripGo. The are really professional.",
                  style: GoogleFonts.poppins(fontSize: 13),
                ),
                const SizedBox(height: 12),
                Text(
                  "Radhey Shyam Sharma, 15 hours ago",
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildInfoCard({required IconData icon, required String title, required String subtitle}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: constants.themeColor1, size: 30),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 11,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
