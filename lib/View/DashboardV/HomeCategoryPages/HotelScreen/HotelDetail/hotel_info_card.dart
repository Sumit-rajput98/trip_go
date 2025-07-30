import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trip_go/constants.dart';

import '../../../../../Model/HotelM/hotel_detail_data.dart';
import 'hotel_meta_section.dart';
import 'hotel_title_section.dart';
import 'hotel_detail_page.dart'; // for themeColor1

class HotelInfoCard extends StatelessWidget {
  final int selectedTab;
  final List<String> tabs;
  final Function(int) onTabChange;
  final Hotel1 hotel;
  final List<RoomDetail> rooms;
  final String city;
  final String cin;
  final String cout;
  final String room;
  final String pax;
  final int totalGuests;
  final GlobalKey? mapKey;

  const HotelInfoCard({
    super.key,
    required this.selectedTab,
    required this.onTabChange,
    required this.tabs,
    required this.hotel,
    required this.rooms,required this.city, required this.cin, required this.cout, required this.room, required this.pax, required this.totalGuests, required this.mapKey
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HotelTitleSection(hotel: hotel), // ✅ Pass hotel
            const SizedBox(height: 20),
            HotelMetaSection(hotel: hotel, city: city, cin: cin, cout: cout, room: room, pax: pax, totalGuests: totalGuests,onMapTap:  () {
  Scrollable.ensureVisible(
    mapKey!.currentContext!,
    duration: Duration(milliseconds: 400),
    curve: Curves.easeInOut,
  );
},), // ✅ Pass hotel
            const SizedBox(height: 24),
            // _buildTabs(),
            // const SizedBox(height: 16),
            // _buildTabContent(), // you’ll update this too
          ],
        ),
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      height: 46,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: constants.themeColor1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(tabs.length, (index) {
          final isSelected = index == selectedTab;
          return GestureDetector(
            onTap: () => onTabChange(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ?  constants.themeColor1 : Colors.transparent,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Text(
                tabs[index],
                style: GoogleFonts.poppins(
                  color: isSelected ? Colors.white :  constants.themeColor1,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // Widget _buildTabContent() {
  //   if (selectedTab == 0) {
  //     return const Text("Rooms content goes here...",
  //         style: TextStyle(fontSize: 16));
  //   } else if (selectedTab == 1) {
  //     return const Text("Overview content goes here...",
  //         style: TextStyle(fontSize: 16));
  //   } else {
  //     return const Text("Details content goes here...",
  //         style: TextStyle(fontSize: 16));
  //   }
  // }
}
