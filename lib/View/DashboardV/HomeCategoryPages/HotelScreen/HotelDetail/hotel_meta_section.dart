import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart'; // For date formatting
import '../../../../../Model/HotelM/hotel_detail_data.dart';

const themeColor1 = Color(0xff1B499F);

class HotelMetaSection extends StatelessWidget {
  final Hotel1 hotel;
  final String city;
  final String cin;
  final String cout;
  final String room;
  final String pax;
  final int totalGuests;
  final VoidCallback onMapTap;

  const HotelMetaSection({
    super.key,
    required this.hotel,
    required this.city,
    required this.cin,
    required this.cout,
    required this.room,
    required this.pax,
    required this.totalGuests,
    required this.onMapTap,
  });

  String _formatDate(String dateStr) {
  try {
    final date = DateFormat("yyyy-MM-dd").parse(dateStr);
    return DateFormat("dd MMMM yyyy").format(date); // 11 July 2025
  } catch (_) {
    return dateStr; // fallback
  }
}


  @override
  Widget build(BuildContext context) {
    print(cin);
    print(cout);
    final formattedCin = _formatDate(cin);
    final formattedCout = _formatDate(cout);
    print(formattedCin);
    print(formattedCout);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.location_on_outlined, size: 16, color: Colors.grey),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                hotel.address ?? "",
                style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[700]),
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: onMapTap,
              child: Text(
                "View Map",
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: themeColor1,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Text(
              "Very Good",
              style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text("4.0", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(width: 8),
            Text("1282 reviews", style: GoogleFonts.poppins(fontSize: 12, fontStyle: FontStyle.italic, color: Colors.grey))
          ],
        ),
        const SizedBox(height: 20),
        _infoCard(icon: Icons.calendar_today_outlined, title: 'Dates', value: '$formattedCin - $formattedCout'),
        const SizedBox(height: 12),
        _infoCard(icon: Icons.group_outlined, title: 'Guests & Rooms', value: '$totalGuests Guests, $room Room'),
      ],
    );
  }

  Widget _infoCard({required IconData icon, required String title, required String value}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(14),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: themeColor1.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: themeColor1, size: 20),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: GoogleFonts.poppins(fontSize: 12, color: Colors.black54, fontWeight: FontWeight.bold)),
              Text(value, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600)),
            ],
          )
        ],
      ),
    );
  }
}
