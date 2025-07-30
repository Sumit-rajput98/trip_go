import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HotelMainFilterSheet extends StatefulWidget {
  const HotelMainFilterSheet({super.key});

  @override
  State<HotelMainFilterSheet> createState() => _HotelMainFilterSheetState();
}

class _HotelMainFilterSheetState extends State<HotelMainFilterSheet> {
  static const Color themeBlue = Color(0xff1B499F);
  static const Color themeRed = Color(0xffF73130);

  final List<String> priceRanges = [
    "₹ 1 – ₹ 2,000",
    "₹ 2,001 – ₹ 4,000",
    "₹ 4,001 – ₹ 8,000",
    "₹ 8,001 – ₹ 20,000",
    "₹ 20,001 – ₹ 30,000",
    "Above ₹ 30,000",
  ];

  final List<String> propertyTags = [
    "Last Minute Deals",
    "Free Cancellation",
    "Free Breakfast"
  ];

  final List<String> popularLocations = [
    "Indira Gandhi International Airport",
    "Hindon Airport",
    "TILAK BRIDGE - TKJ",
    "SHIVAJI BRIDGE - CSB",
    "NEW DELHI - NDLS",
    "H NIZAMUDDIN - NZM",
    "ASWANI HALT - AWS",
    "RAJGHAT - RGT",
    "DARIYAGANJ - DAYG",
    "SEWA NAGAR - SWNR",
  ];

  final List<String> nearbyLocations = [
    "New Maharashtra Sadan",
    "Andhra Bhavan Canteen",
    "Andhra Pradesh Bhavan",
    "CSOI",
    "NOMA Kota House",
    "Bharatiya Vidya Bhavan",
    "National Museum, New Delhi",
    "Jiwan Service Station",
    "Junior Modern School",
  ];

  final List<String> starRatings = [
    "Unrated",
    "1 Star",
    "2 Star",
    "3 Star",
    "4 Star",
    "5 Star",
  ];
  final List<String> userRatings = ["Excellent 4+", "Very Good 3+", "Good 2+"];
  final List<String> propertyTypes = ["Hotel", "Apartment", "Villa", "Hostel"];
  final List<String> areaAttractions = ["India Gate", "Connaught Place", "Red Fort", "Qutub Minar"];
  final List<String> amenities = ["Wi-Fi", "Pool", "Gym", "Spa", "Parking", "Pet-Friendly"];
  final List<String> chainHotels = ["Taj Hotels", "OYO", "ITC", "Lemon Tree", "FabHotels"];
  final List<String> landmarks = ["Railway Station", "Metro", "Airport", "City Center"];

  String? selectedPrice;
  Set<String> selectedTags = {};
  Set<String> selectedPopular = {};
  Set<String> selectedNearby = {};
  Set<String> selectedStars = {};
  Set<String> selectedUserRatings = {};
  Set<String> selectedPropertyTypes = {};
  Set<String> selectedAreaAttractions = {};
  Set<String> selectedAmenities = {};
  Set<String> selectedChainHotels = {};
  Set<String> selectedLandmarks = {};

  void _resetAll() {
    setState(() {
      selectedPrice = null;
      selectedTags.clear();
      selectedPopular.clear();
      selectedNearby.clear();
      selectedStars.clear();
      selectedUserRatings.clear();
      selectedPropertyTypes.clear();
      selectedAreaAttractions.clear();
      selectedAmenities.clear();
      selectedChainHotels.clear();
      selectedLandmarks.clear();
    });
  }

  void _applyFilters() {
    final result = {
      'price': selectedPrice,
      'tags': selectedTags,
      'popularLocations': selectedPopular,
      'nearbyLocations': selectedNearby,
      'starRatings': selectedStars,
      'userRatings': selectedUserRatings,
      'propertyTypes': selectedPropertyTypes,
      'areaAttractions': selectedAreaAttractions,
      'amenities': selectedAmenities,
      'chainHotels': selectedChainHotels,
      'landmarks': selectedLandmarks,
    };
    Navigator.pop(context, result);
  }

  Widget _buildSectionTitle(String title, {VoidCallback? onMore}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600)),
        if (onMore != null)
          GestureDetector(
            onTap: onMore,
            child: Text("+ more", style: GoogleFonts.poppins(color: themeBlue, fontSize: 13)),
          )
      ],
    );
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

  Widget _buildFilterWrap(String title, List<String> items, Set<String> selectedSet, {bool allowSingleSelect = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(title),
        const SizedBox(height: 10),
        Wrap(
          children: items.map((item) {
            final isSelected = allowSingleSelect ? selectedPrice == item : selectedSet.contains(item);
            return _buildChip(item, isSelected, () {
              setState(() {
                if (allowSingleSelect) {
                  selectedPrice = selectedPrice == item ? null : item;
                } else {
                  isSelected ? selectedSet.remove(item) : selectedSet.add(item);
                }
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
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.75,
      minChildSize: 0.5,
      maxChildSize: 0.95,
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
              decoration: BoxDecoration(color: Colors.deepPurple.shade400, borderRadius: BorderRadius.circular(20)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Filters", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600)),
                TextButton(onPressed: _resetAll, child: Text("Reset", style: GoogleFonts.poppins(color: themeBlue,fontWeight: FontWeight.w500,fontSize: 13)))
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: controller,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFilterWrap("Show Properties With", propertyTags, selectedTags),
                    _buildFilterWrap("Price Range", priceRanges, {}, allowSingleSelect: true),
                    _buildFilterWrap("Star Rating", starRatings, selectedStars),
                    _buildFilterWrap("User Rating", userRatings, selectedUserRatings),
                    _buildFilterWrap("Property Type", propertyTypes, selectedPropertyTypes),
                    _buildFilterWrap("Popular Location", popularLocations, selectedPopular),
                    _buildFilterWrap("Near By Location", nearbyLocations, selectedNearby),
                    _buildFilterWrap("Area & Attraction", areaAttractions, selectedAreaAttractions),
                    _buildFilterWrap("Amenities", amenities, selectedAmenities),
                    _buildFilterWrap("Chain Hotels", chainHotels, selectedChainHotels),
                    _buildFilterWrap("Location & Landmarks", landmarks, selectedLandmarks),
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
    );
  }
}
