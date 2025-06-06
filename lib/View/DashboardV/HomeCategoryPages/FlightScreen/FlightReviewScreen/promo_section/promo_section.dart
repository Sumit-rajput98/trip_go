import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/FlightReviewScreen/promo_section/promo_provider.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/FlightReviewScreen/promo_section/widgets/promo_bottom_sheet.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/FlightReviewScreen/promo_section/widgets/promo_card.dart';



class PromoSection extends StatelessWidget {
  const PromoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PromoProvider>(
      builder: (context, controller, _) {
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade200, Colors.pink.shade100],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.local_offer_outlined),
                    const SizedBox(width: 8),
                    Text("Offers and Promo Codes",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold)),
                    const Spacer(),
                    const Icon(Icons.arrow_forward_ios, size: 16),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              controller.isCouponApplied
                  ? Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.green.shade50,
                ),
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(controller.selectedCoupon,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold)),
                        const Spacer(),
                        GestureDetector(
                          onTap: controller.removeCoupon,
                          child: Text("Remove",
                              style: GoogleFonts.poppins(
                                  color: Colors.blue)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Congratulations! Instant Discount has been applied successfully.",
                      style: GoogleFonts.poppins(color: Colors.green),
                    ),
                  ],
                ),
              )
                  : Container(
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
                      },
                      child: Text("Apply",
                          style: GoogleFonts.poppins(
                              color: Colors.blue)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              buildPromoCard("BOOKNOW", controller,
                  "Get Rs.350 OFF on your flight booking."),
              const SizedBox(height: 10),
              buildPromoCard("EMTSUMXXX", controller,
                  "Use this coupon and get up to Rs.5000 OFF for ICICI Bank Credit/Debit Cards."),
              const SizedBox(height: 10),
              Center(
                child: GestureDetector(
                  onTap: () => showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    builder: (_) => const PromoBottomSheet(),
                  ),
                  child: Text("View More Coupons",
                      style:
                      GoogleFonts.poppins(color: Colors.blue)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

 /* Widget buildPromoCard(
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
  }*/
}

/*
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
}*/
