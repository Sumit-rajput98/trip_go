import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import "../promo_provider.dart";

Widget buildPromoCard(
    String code, PromoProvider controller, String description) {
  bool isSelected = controller.selectedCoupon == code;

  return GestureDetector(
    onTap: () => controller.applyCoupon(code),
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue.shade50 : Colors.grey.shade100,
        border: Border.all(
            color: isSelected ? Colors.blue : Colors.transparent),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(
            isSelected ? Icons.check_circle : Icons.radio_button_off,
            color: isSelected ? Colors.blue : Colors.grey,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(code,
                    style:
                    GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                const SizedBox(height: 2),
                Text(description,
                    style: GoogleFonts.poppins(fontSize: 13)),
              ],
            ),
          ),
          Text("T&C Apply",
              style:
              GoogleFonts.poppins(fontSize: 12, color: Colors.blue)),
        ],
      ),
    ),
  );
}