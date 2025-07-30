import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RatingFilterBottomSheet extends StatefulWidget {
  const RatingFilterBottomSheet({super.key});

  @override
  State<RatingFilterBottomSheet> createState() => _RatingFilterBottomSheetState();
}

class _RatingFilterBottomSheetState extends State<RatingFilterBottomSheet> {
  final List<Map<String, dynamic>> ratings = [
    {"label": "Unrated", "value": 0},
    {"label": "1 Star", "value": 1},
    {"label": "2 Star", "value": 2},
    {"label": "3 Star", "value": 3},
    {"label": "4 Star", "value": 4},
    {"label": "5 Star", "value": 5},
  ];

  int? selectedValue;

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
                    selectedValue = null;
                  });
                },
                child: Text("Reset", style: GoogleFonts.poppins(color: themeBlue, fontWeight: FontWeight.w500, fontSize: 13)),
              ),
            ],
          ),

          const SizedBox(height: 20),

          /// Rating Label
          Text(
            "Star Rating",
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 14),

          /// Rating Chips
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: ratings.map((rating) {
              final isSelected = selectedValue == rating['value'];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedValue = rating['value'];
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected ? themeBlue.withOpacity(0.1) : Colors.white,
                    border: Border.all(
                      color: isSelected ? themeBlue : Colors.grey.shade300,
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.star, size: 16, color: themeBlue),
                      const SizedBox(width: 6),
                      Text(
                        rating['label'],
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: isSelected ? themeBlue : Colors.black87,
                        ),
                      ),
                    ],
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
                  Navigator.pop(context, selectedValue); // <- returns selected numeric value (0–5)
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
