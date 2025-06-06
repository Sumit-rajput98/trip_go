import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../promo_provider.dart';
class PromoBottomSheet extends StatelessWidget {
  const PromoBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<PromoProvider>(context);

    final List<Map<String, String>> coupons = [
      {"code": "EMTSUMXXX", "desc": "Get up to Rs.5000 OFF via ICICI Bank."},
      {"code": "EMTUPI", "desc": "Get Rs.250 OFF on your flight booking."},
      {"code": "HSBCXXX", "desc": "Get up to Rs.5000 OFF via HSBC EMI only."},
      {"code": "DELIGHT", "desc": "Hotel + Flight combo discount."},
    ];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text("Apply Promo Code",
                  style: GoogleFonts.poppins(
                      fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
                color: Colors.grey.shade100,
              ),
              padding: const EdgeInsets.symmetric(
                  horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Enter Promo Code",
                        hintStyle: GoogleFonts.poppins(),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.applyCoupon("BOOKNOW");
                      Navigator.pop(context);
                    },
                    child: Text("Apply",
                        style: GoogleFonts.poppins(
                            color: Colors.blue)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8,),
            ...coupons.map((coupon) {
              final selected = controller.selectedCoupon == coupon["code"];
              return GestureDetector(
                onTap: () {
                  controller.applyCoupon(coupon["code"]!);
                  Navigator.pop(context);
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        selected
                            ? Icons.check_circle
                            : Icons.radio_button_off,
                        color: selected ? Colors.blue : Colors.grey,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(coupon["code"]!,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text(coupon["desc"]!,
                                style: GoogleFonts.poppins(fontSize: 13)),
                          ],
                        ),
                      ),
                      Text("T&C Apply",
                          style: GoogleFonts.poppins(
                              fontSize: 12, color: Colors.blue)),
                    ],
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}