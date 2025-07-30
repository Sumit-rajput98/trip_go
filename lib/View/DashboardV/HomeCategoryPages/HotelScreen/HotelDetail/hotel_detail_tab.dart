import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HotelDetailsScreen extends StatelessWidget {
  static const Color themeBlue = Color(0xff1B499F);

  final String name;
  final String address;
  final String phone;
  final String amenities;

  const HotelDetailsScreen({
    super.key,
    required this.name,
    required this.address,
    required this.phone,
    required this.amenities,
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle sectionTitle = GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600);
    final TextStyle contentText = GoogleFonts.poppins(fontSize: 13, color: Colors.black87);
    final TextStyle bulletText = GoogleFonts.poppins(fontSize: 13);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Property Rules & Info
          Text("Property Rules & Information", style: sectionTitle),
          const SizedBox(height: 4),
          Text("Check-In: 03:00 PM | Check-Out: 12:00 PM", style: contentText),
          const SizedBox(height: 14),

          /// General Information Box
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.green.shade200),
              color: Colors.green.shade50.withOpacity(0.3),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("General Information", style: sectionTitle),
                const SizedBox(height: 10),
                _buildBullet("Smoking within the premises is not allowed"),
                _buildBullet("Guests are requested not to invite outside visitors in the room during their stay."),
                const SizedBox(height: 10),
                Text("Food Policy", style: sectionTitle),
                const SizedBox(height: 6),
                _buildBullet("Outside food is not allowed"),
                const SizedBox(height: 10),
                Text("Accepted Identification Documents", style: sectionTitle),
                const SizedBox(height: 6),
                _buildBullet("Passport and Aadhar are accepted as ID proof(s)"),
              ],
            ),
          ),

          const SizedBox(height: 24),

          /// Facilities Highlights
          _buildHighlightCard(
            icon: "https://cdn-icons-png.flaticon.com/128/6019/6019276.png",
            title: "Hygiene Plus",
            subtitle: "This property has self-selected and self-certified",
          ),
          const SizedBox(height: 12),
          _buildHighlightCard(
            icon: "https://cdn-icons-png.flaticon.com/128/10249/10249941.png",
            title: "Check-in/out",
            subtitle: "Hassle-free check in",
          ),
          const SizedBox(height: 12),
          _buildHighlightCard(
            icon: "https://cdn-icons-png.flaticon.com/128/1670/1670381.png",
            title: "Medical & Doctor Support",
            subtitle: "Free consultation & medicines",
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildBullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• ", style: TextStyle(fontSize: 14)),
          Expanded(child: Text(text, style: GoogleFonts.poppins(fontSize: 13))),
        ],
      ),
    );
  }

  Widget _buildHighlightCard({required String icon, required String title, required String subtitle}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.03),
            blurRadius: 4,
            offset: const Offset(0, 1),
          )
        ],
      ),
      child: Row(
        children: [
          Image.network(icon, width: 36, height: 36),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13)),
                const SizedBox(height: 4),
                Text(subtitle, style: GoogleFonts.poppins(fontSize: 12, color: Colors.black87)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
