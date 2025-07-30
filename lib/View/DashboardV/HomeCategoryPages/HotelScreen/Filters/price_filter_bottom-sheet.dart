import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PriceFilterBottomSheet extends StatefulWidget {
  const PriceFilterBottomSheet({super.key});

  @override
  State<PriceFilterBottomSheet> createState() => _PriceFilterBottomSheetState();
}

class _PriceFilterBottomSheetState extends State<PriceFilterBottomSheet> {
  final List<String> priceRanges = [
    "₹ 1 – ₹ 2,000",
    "₹ 2,001 – ₹ 4,000",
    "₹ 4,001 – ₹ 8,000",
    "₹ 8,001 – ₹ 20,000",
    "₹ 20,001 – ₹ 30,000",
    "Above ₹ 30,000",
  ];

  String? selected;

  static const Color themeBlue = Color(0xff1B499F);
  static const Color themeRed = Color(0xffF73130);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 25),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Drag Handle
          Center(
            child: Container(
              height: 5,
              width: 50,
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade400,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),

          /// Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Filters",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selected = null;
                  });
                },
                child:  Text("Reset", style: GoogleFonts.poppins(color: themeBlue,fontWeight: FontWeight.w500,fontSize: 13))
              ),
            ],
          ),

          const SizedBox(height: 20),

          /// Price Range Label
          Text(
            "Price Range",
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 14),

          /// Price Options
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: priceRanges.map((price) {
              final isSelected = price == selected;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selected = price;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? themeBlue.withOpacity(0.1) : Colors.white,
                    border: Border.all(
                      color: isSelected ? themeBlue : Colors.grey.shade300,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    price,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: isSelected ? themeBlue : Colors.black87,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 30),

          /// Apply Button
          Center(
            child: SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, selected);
                },
                style: ElevatedButton.styleFrom(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: EdgeInsets.zero,
                  backgroundColor: Colors.transparent,
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    gradient: const LinearGradient(
                      colors: [themeBlue, themeRed],
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Apply",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
