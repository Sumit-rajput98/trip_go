import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/FlightReviewScreen/flight_review_screen.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/FlightReviewScreen/promo_section/promo_section.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/FlightReviewScreen/promo_section/round_trip_travellers_details.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/FlightReviewScreen/traveller_details.dart';

import '../common_widget/bottom_bar.dart';

class MultiTripFlighReviewScreen extends StatefulWidget {
  const MultiTripFlighReviewScreen({super.key});

  @override
  State<MultiTripFlighReviewScreen> createState() => _MultiTripFlighReviewScreenState();
}

class _MultiTripFlighReviewScreenState extends State<MultiTripFlighReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 130,
              decoration: const BoxDecoration(
                color: Color(0xFF341f97),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(28),
                  bottomRight: Radius.circular(28),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 36),
              alignment: Alignment.topLeft,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  const SizedBox(width: 16),
                  Text("Flight Review",
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 90, 20, 0),
              child: Column(
                children: [
                  buildFlightReviewDepartCard(),
                  const SizedBox(height: 8),
                  buildFlightReviewCard(),
                  const SizedBox(height: 16),
                  PromoSection(),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: buildBottomBar(context,(){}),
    );
  }
}

Widget buildFlightReviewDepartCard(){
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: Colors.white,
      boxShadow: [BoxShadow(color: Colors.black12, offset: Offset(0, 3), blurRadius: 8)],
    ),child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Delhi-Mumbai", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
      const SizedBox(height: 4),
      Row(
        children: [
          Text("Tue–29Apr2025", style: GoogleFonts.poppins(color: Colors.grey)),
          const SizedBox(width: 5),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text("Depart", style: GoogleFonts.poppins(color: Color(0xff006DFF))),
          ),
        ],
      ),
      const Divider(),
      buildFlightTile("SpiceJet | SG 124", "Spice Saver", "DEL", "15:00", "BOM", "16:05", "1D", "1D", "01h 05m"),
    ],

  ),
  );
}
Widget buildFlightReviewCard() {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: Colors.white,
      boxShadow: [BoxShadow(color: Colors.black12, offset: Offset(0, 3), blurRadius: 8)],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Mumbai-Lucknow", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Row(
          children: [
            Text("Tue–29Apr2025", style: GoogleFonts.poppins(color: Colors.grey)),
            const SizedBox(width: 5),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text("Depart", style: GoogleFonts.poppins(color: Color(0xff006DFF))),
            ),
          ],
        ),
        const Divider(),
        buildFlightTile("SpiceJet | SG 124", "Spice Saver", "BOM", "15:00", "AMD", "16:05", "1D", "1D", "01h 05m"),
        buildLayover("2h:50m Layover in Ahemdabad (AMD)"),
        buildFlightTile("SpiceJet | SG 510", "Spice Saver", "AMD", "18:55", "LKO", "21:25", "1D", "1D", "02h 30m"),
      ],
    ),
  );
}

Widget buildFlightTile(String flight, String fare, String from, String depTime, String to, String arrTime, String depTerm, String arrTerm, String duration) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          CircleAvatar(
            radius: 15,
            backgroundImage: NetworkImage('https://flight.easemytrip.com/Content/AirlineLogon/SG.png'),
          ),
          const SizedBox(width: 6),
          Text(flight, style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text("Refundable", style: GoogleFonts.poppins(color: Colors.green)),
          ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 8, 4),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text("Spice Saver", style: GoogleFonts.poppins(color: Color(0xff000000), fontWeight: FontWeight.w500, fontSize: 10)),
        ),
      ),
      const SizedBox(height: 4),
      Container(
        margin: const EdgeInsets.only(top: 4),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey.shade50,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildFlightTime(from, depTime, "Delhi", depTerm),
            buildDuration(duration),
            buildFlightTime(to, arrTime, to == "BOM" ? "Mumbai" "DED": "Dehradun", arrTerm),
          ],
        ),
      ),
      const SizedBox(height: 8),
    ],
  );
}

Widget buildLayover(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.amber),
        borderRadius: BorderRadius.circular(8),
        color: Colors.amber.shade50,
      ),
      padding: const EdgeInsets.symmetric(vertical: 6),
      alignment: Alignment.center,
      child: Text(text, style: GoogleFonts.poppins(color: Colors.orange, fontWeight: FontWeight.w500)),
    ),
  );
}

Widget buildFlightTime(String code, String time, String city, String terminal) {
  return Column(
    children: [
      Text("Tue–29Apr2025", style: GoogleFonts.poppins(fontSize: 10)),
      Text("$code $time", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16)),
      Text(city, style: GoogleFonts.poppins()),
      Text("Terminal - $terminal", style: GoogleFonts.poppins(fontSize: 10)),
    ],
  );
}

Widget buildDuration(String duration) {
  return Column(
    children: [
      const Icon(Icons.more_horiz, size: 16),
      Text(duration, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 12, color: Colors.grey)),
      const Icon(Icons.more_horiz, size: 16),
    ],
  );
}
