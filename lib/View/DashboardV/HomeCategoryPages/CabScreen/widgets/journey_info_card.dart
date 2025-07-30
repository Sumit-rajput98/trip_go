import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../HotelScreen/HotelDetail/hotel_detail_page.dart';


Widget buildJourneyInfoCard({
  required Animation<Offset> slideAnimation,
  required BuildContext context,
  required String pickupState,
  required String pickup,
  required String dropState,
  required String drop,
}) {
  return SliverToBoxAdapter(
    child: AnimatedBuilder(
      animation: slideAnimation,
      builder: (context, child) => SlideTransition(
        position: slideAnimation,
        child: Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [
              BoxShadow(
                color: themeColor1.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    _buildJourneyPoint(pickupState, pickup, true),
                    _buildJourneyLine(),
                    _buildJourneyPoint(dropState, drop, false),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Column(
                children: [
                  _buildInfoBadge('26 km', Icons.route, themeColor1),
                  const SizedBox(height: 8),
                  _buildInfoBadge('45 min', Icons.access_time, Colors.orange.shade600),
                  const SizedBox(height: 8),
                  _buildInfoBadge('₹879+', Icons.currency_rupee, Colors.green.shade600),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _buildJourneyPoint(String city, String area, bool isStart) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: 12,
        height: 12,
        margin: const EdgeInsets.only(top: 4),
        decoration: BoxDecoration(
          color: isStart ? Colors.green.shade600 : themeColor2,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: (isStart ? Colors.green.shade600 : themeColor2).withOpacity(0.3),
              blurRadius: 6,
              spreadRadius: 1,
            ),
          ],
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              city,
              style: GoogleFonts.poppins(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              area,
              style: GoogleFonts.poppins(
                color: Colors.grey.shade600,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _buildJourneyLine() => Padding(
  padding: const EdgeInsets.symmetric(vertical: 12),
  child: Container(width: 2, height: 24, color: Colors.grey.shade300),
);

Widget _buildInfoBadge(String text, IconData icon, Color color) {
  return Row(
    children: [
      Icon(icon, color: color, size: 16),
      const SizedBox(width: 4),
      Text(
        text,
        style: GoogleFonts.poppins(fontSize: 12, color: Colors.black87),
      ),
    ],
  );
}
