import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BusStarFilterSheet extends StatefulWidget {
  const BusStarFilterSheet({super.key});

  @override
  State<BusStarFilterSheet> createState() => _BusStarFilterSheetState();
}

class _BusStarFilterSheetState extends State<BusStarFilterSheet> {
  static const Color themeBlue = Color(0xff1B499F);
  static const Color themeRed = Color(0xffF73130);

  final List<String> starRatings = [
    "Unrated",
    "1 Star",
    "2 Star",
    "3 Star",
    "4 Star",
    "5 Star",
  ];

  Set<String> selectedStars = {};

  void _resetAll() {
    setState(() {
      selectedStars.clear();
    });
  }

  void _applyFilters() {
    final result = {
      'starRatings': selectedStars,
    };
    Navigator.pop(context, result);
  }

  Widget _buildChip(String label, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 8, bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? themeBlue.withOpacity(0.1) : Colors.white,
          border: Border.all(color: selected ? themeBlue : Colors.grey.shade300),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: selected ? themeBlue : Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget _buildFilterWrap(String title, List<String> items, Set<String> selectedSet) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600)),
        const SizedBox(height: 10),
        Wrap(
          children: items.map((item) {
            final isSelected = selectedSet.contains(item);
            return _buildChip(item, isSelected, () {
              setState(() {
                isSelected ? selectedSet.remove(item) : selectedSet.add(item);
              });
            });
          }).toList(),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.4,
        minChildSize: 0.3,
        maxChildSize: 0.75,
        builder: (_, controller) => Container(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 10),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Container(
                height: 5,
                width: 50,
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade400,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Star Rating", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600)),
                  TextButton(
                    onPressed: _resetAll,
                    child: Text("Reset", style: GoogleFonts.poppins(color: themeBlue, fontWeight: FontWeight.w500, fontSize: 13)),
                  )
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: controller,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildFilterWrap("Select Star Rating", starRatings, selectedStars),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  onPressed: _applyFilters,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    padding: EdgeInsets.zero,
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      gradient: const LinearGradient(colors: [themeBlue, themeRed]),
                    ),
                    child: Center(
                      child: Text(
                        "Apply",
                        style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
