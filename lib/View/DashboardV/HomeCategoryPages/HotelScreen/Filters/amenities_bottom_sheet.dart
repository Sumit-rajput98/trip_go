import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AmenitiesBottomSheet extends StatefulWidget {
  const AmenitiesBottomSheet({super.key});

  @override
  State<AmenitiesBottomSheet> createState() => _AmenitiesBottomSheetState();
}

class _AmenitiesBottomSheetState extends State<AmenitiesBottomSheet> {
  static const Color themeBlue = Color(0xff1B499F);
  static const Color themeRed = Color(0xffF73130);

  final List<String> amenities = [
    "Free Wi-Fi",
    "Swimming Pool",
    "Gym",
    "Spa",
    "Parking",
    "Airport Shuttle",
    "Restaurant",
    "Bar",
    "Pet-Friendly",
    "Business Center",
    "Laundry",
    "AC Rooms",
    "24x7 Room Service",
    "Wheelchair Access",
  ];

  Set<String> selectedAmenities = {};

  void _applyAmenities() {
    Navigator.pop(context, selectedAmenities);
  }

  void _resetAmenities() {
    setState(() {
      selectedAmenities.clear();
    });
  }

  Widget _buildChip(String label, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected ? selectedAmenities.remove(label) : selectedAmenities.add(label);
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8, bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? themeBlue.withOpacity(0.1) : Colors.white,
          border: Border.all(color: isSelected ? themeBlue : Colors.grey.shade300),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: isSelected ? themeBlue : Colors.black87,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.75,
      maxChildSize: 0.95,
      minChildSize: 0.5,
      builder: (context, controller) {
        return Container(
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
                  Text("Amenities",
                      style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600)),
                  TextButton(
                    onPressed: _resetAmenities,
                    child: Text("Reset", style: GoogleFonts.poppins(color: themeBlue,fontWeight: FontWeight.w500,fontSize: 13)),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  controller: controller,
                  child: Wrap(
                    children: amenities
                        .map((item) => _buildChip(item, selectedAmenities.contains(item)))
                        .toList(),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  onPressed: _applyAmenities,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    padding: EdgeInsets.zero,
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [themeBlue, themeRed]),
                      borderRadius: BorderRadius.circular(25),
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
            ],
          ),
        );
      },
    );
  }
}
