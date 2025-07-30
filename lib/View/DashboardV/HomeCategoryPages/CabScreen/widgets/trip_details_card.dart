import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trip_go/constants.dart';

class TripDetailsCard extends StatelessWidget {
  final TextEditingController pickupController;
  final TextEditingController dropController;

  const TripDetailsCard({
    super.key,
    required this.pickupController,
    required this.dropController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            "Trip Details",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          const Divider(),

          // Pick-Up Section
          const SizedBox(height: 12),
          Text(
            "Pick-Up Address",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 6),
          _inputField("Enter Pickup Address", pickupController, "NEW DELHI"),

          // Drop-Off Section
          const SizedBox(height: 16),
          Text(
            "Drop-Off Address",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 6),
          _inputField("Enter Dropping Address", dropController, "Noida, Uttar Pradesh, India"),
        ],
      ),
    );
  }

  Widget _inputField(String hintText, TextEditingController controller, String hintText2) {
    return SizedBox(
      height: 75,
      child: Stack(
        children: [
          // Yellow container behind
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 35,
            child: Container(
              padding: const EdgeInsets.only(left: 10, top: 14),
              decoration: BoxDecoration(
                color: constants.ultraLightThemeColor1,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                hintText2,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          // Input field on top
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: GoogleFonts.poppins(
                  color: Colors.grey,
                  fontSize: 13,
                ),
                filled: true,
                fillColor: const Color(0xFFF9FAFB),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
