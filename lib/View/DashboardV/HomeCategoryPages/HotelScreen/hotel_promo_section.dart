import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HotelPromoSection extends StatelessWidget {
  const HotelPromoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HotelPromoProvider>(
      builder: (context, controller, _) {
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade300)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.deepPurple.shade200, Colors.red.shade100],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.local_offer_outlined),
                    const SizedBox(width: 8),
                    Text(
                      "Offers and Promo Codes",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                    ),
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
                                    style:
                                        GoogleFonts.poppins(color: Colors.blue)),
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
                              controller.applyCoupon("EMTHOTEL");
                            },
                            child: Text("Apply",
                                style:
                                    GoogleFonts.poppins(color: Colors.blue)),
                          ),
                        ],
                      ),
                    ),
              const SizedBox(height: 12),
              buildPromoCard("TGO", controller,
                  "Get Rs.721 OFF on booking."),
              const SizedBox(height: 10),
              buildPromoCard("PNBTGO", controller,
                  "Get Rs.1201 OFF via PNB TGO Credit Cards."),
              const SizedBox(height: 10),
              buildPromoCard("HSBCEMI", controller,
                  "Interest-free booking on HSBC Credit EMI."),
              const SizedBox(height: 10),
              Center(
                child: GestureDetector(
                  onTap: () => showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    builder: (_) => const HotelPromoBottomSheet(),
                  ),
                  child: Text("View More Coupons",
                      style: GoogleFonts.poppins(color: Colors.blue)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildPromoCard(
      String code, HotelPromoProvider controller, String description) {
    bool isSelected = controller.selectedCoupon == code;

    return GestureDetector(
      onTap: () => controller.applyCoupon(code),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.red.shade50 : Colors.grey.shade100,
          border: Border.all(
              color: isSelected ? Colors.deepOrange : Colors.transparent),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.check_circle : Icons.radio_button_off,
              color: isSelected ? Colors.deepOrange : Colors.grey,
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
                  Text(description, style: GoogleFonts.poppins(fontSize: 13)),
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
}


class HotelPromoProvider with ChangeNotifier {
  bool isCouponApplied = false;
  String selectedCoupon = '';

  void applyCoupon(String code) {
    selectedCoupon = code;
    isCouponApplied = true;
    notifyListeners();
  }

  void removeCoupon() {
    selectedCoupon = '';
    isCouponApplied = false;
    notifyListeners();
  }
}




class HotelPromoBottomSheet extends StatelessWidget {
  const HotelPromoBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<HotelPromoProvider>(context);

    final List<Map<String, String>> coupons = [
      {"code": "TGOHOTEL", "desc": "Get Rs.721 OFF on hotel booking."},
      {"code": "PNBEMT", "desc": "Flat Rs.1201 OFF via PNB EMT Credit Card."},
      {"code": "HSBCEMI", "desc": "Interest-free booking via HSBC EMI."},
      {"code": "GRAB20", "desc": "Get up to 20% instant OFF."},
      {"code": "DELUXESTAY", "desc": "Extra 10% OFF on deluxe room bookings."},
    ];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Apply Promo Code",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
                color: Colors.grey.shade100,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                      controller.applyCoupon("TGOHOTEL");
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Apply",
                      style: GoogleFonts.poppins(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
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
                    color: selected ? Colors.orange.shade50 : Colors.grey.shade100,
                    border: Border.all(
                      color: selected ? Colors.deepOrange : Colors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        selected ? Icons.check_circle : Icons.radio_button_off,
                        color: selected ? Colors.deepOrange : Colors.grey,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              coupon["code"]!,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              coupon["desc"]!,
                              style: GoogleFonts.poppins(fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "T&C Apply",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.blue,
                        ),
                      ),
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
