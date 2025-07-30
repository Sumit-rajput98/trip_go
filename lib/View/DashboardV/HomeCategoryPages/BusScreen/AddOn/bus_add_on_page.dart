import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/BusScreen/AddOn/chart_tab.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/BusScreen/bus_boarding_page.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/common_widget/bottom_bar.dart';
import 'package:trip_go/constants.dart';
import '../../../../../AppManager/Api/api_service/BusService/bus_seat_service.dart';
import '../../../../../Model/BusM/bus_search_model.dart';
import '../../../../../Model/BusM/bus_seat_model.dart';
import '../BusScreen/bus_seat_provider.dart';

class BusAddOnPage extends StatefulWidget {
  final origin;
  final destination;
  final arrival;
  final String traceId;
  final String travelName;
  final String resultIndex;
  final bool isDropPointMandatory;
  final List<BusResult> busResults;

  const BusAddOnPage({
    super.key,
    required this.travelName,
    required this.destination,
    required this.origin,
    required this.traceId,
    required this.arrival,
    required this.resultIndex,
    required this.isDropPointMandatory,
    required this.busResults,
  });

  static const Color themeColor1 = Color(0xff1B499F);
  static const Color themeColor2 = Color(0xffF73130);
  static const Color lightBlue = Color(0xffE3EAF6); // lighter theme color
  static const Color lightRed = Color(0xffFFE5E4);
  static const Color greyBox = Color(0xffF1F1F1);

  @override
  State<BusAddOnPage> createState() => _BusAddOnPageState();
}

class _BusAddOnPageState extends State<BusAddOnPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> tabTitles = ['Chart', 'Covid Safe', 'Policies'];

  late Future<BusSeatLayoutResponse> seatFuture;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabTitles.length, vsync: this);
    seatFuture = BusSeatService().fetchBusSeatLayout(
      traceId: widget.traceId,
      resultIndex: widget.resultIndex,
    ).then((res) => BusSeatLayoutResponse.fromJson(res));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final seatProvider = Provider.of<BusSeatProvider>(context);
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Colors.white,
          bottomNavigationBar: seatProvider.selectedSeats.isNotEmpty
              ? buildBottomBar(
            context,
                () {
              final selectedSeats = seatProvider.selectedSeatList;
              print("Total Seats Selected: ${selectedSeats.length}"); // ✅ NEW

              for (final seat in selectedSeats) {
                print("Selected Seat: ${seat.seatName}");
                print("Price JSON: ${jsonEncode(seat.price.toJson())}");
              }

              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => BoardingPointSelectionPage(
                    paymentPrice: seatProvider.totalPrice.toInt(),
                    traceId: widget.traceId,
                  resultIndex: widget.resultIndex,
                  isDropPointMandatory: widget.isDropPointMandatory, selectedSeats: selectedSeats.length, busResults: widget.busResults, origin: widget.origin,destination: widget.destination,
                )),
              );
            },
            price: seatProvider.totalPrice.toInt(),
          )
              : const SizedBox.shrink(),

        body: Column(
          children: [
            _buildCustomAppBar(),
            const SizedBox(height: 10),
            _buildStyledTabBar(),
            const SizedBox(height: 10),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  FutureBuilder<BusSeatLayoutResponse>(
                    future: seatFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data?.result == null) {
                        return const Center(child: Text('No seat layout available.'));
                      }

                      final seatLayout = snapshot.data!.result!.seatLayoutDetails.seatLayout;

                      return ChartTab(seatLayout: seatLayout,  htmlLayout: snapshot.data!.result!.seatLayoutDetails.htmlLayout );
                    },
                  ),
                  const CovidSafeTab(),
                  const PolicyTab(),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
  Widget _buildStyledTabBar() {
  final screenWidth = MediaQuery.of(context).size.width;

  // Calculate responsive dimensions
  final double tabBarHeight = screenWidth < 360 ? 54 : 48;
  final double indicatorPadding = screenWidth < 360 ? 0 : 0;
  final double fontSize = screenWidth < 360 ? 13 : 14;

  return Container(
    height: tabBarHeight,
    margin: EdgeInsets.symmetric(
      horizontal: screenWidth < 360 ? 12 : 16,
    ),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: TabBar(
      dividerHeight: 0,
      controller: _tabController,
      indicator: BoxDecoration(
        color: constants.themeColor1.withOpacity(0.1),
        border: Border.all(color: constants.themeColor1),
        borderRadius: BorderRadius.circular(10),
      ),
      indicatorPadding: EdgeInsets.fromLTRB(0, 3, 0, 3),
      padding: EdgeInsets.zero,
      labelColor: Colors.black,
      unselectedLabelColor: Colors.black54,
      labelStyle: GoogleFonts.poppins(
        fontWeight: FontWeight.w600,
        fontSize: fontSize,
      ),
      unselectedLabelStyle: GoogleFonts.poppins(
        fontWeight: FontWeight.w500,
        fontSize: fontSize,
      ),
      tabs: tabTitles
          .map(
            (title) => Tab(
              child: Container(
                alignment: Alignment.center,
                child: Text(title),
              ),
            ),
          )
          .toList(),
    ),
  );
}
  Widget _buildCustomAppBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 40, 16, 16),
      color: Colors.white,
      child: Row(
        children: [
          GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
              child: Icon(Icons.arrow_back, color: Colors.black)),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${widget.origin} To ${widget.destination}", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
              const SizedBox(height: 2),
              Text(widget.travelName, style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600])),
              Text(widget.arrival, style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600])),
            ],
          ),
        ],
      ),
    );
  }
}
class CovidSafeTab extends StatelessWidget {
  const CovidSafeTab({super.key});

  Widget buildCard(String title, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(width: 12),
          Expanded(child: Text(title, style: GoogleFonts.poppins(fontSize: 14))),
        ],
      ),
    );
  }

  Widget buildNormsBox() {
    final norms = [
      "Mask - Use mask throughout the journey.",
      "Sanitizer - Carry hand sanitizer and use during your journey.",
      "Avoid touching your face, use gloves if required.",
      "Avoid travel if feeling unwell.",
      "Passenger must go thermal screening.",
      "Maintain social distancing during boarding and travel.",
      "Register on Aarogya Setu app.",
      "Carry your own blanket if required.",
    ];

    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Traveller Should Follow These Travel Norms:",
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 15),
          ),
          const SizedBox(height: 10),
          ...norms.map((e) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("• ", style: TextStyle(fontSize: 16)),
                    Expanded(child: Text(e, style: GoogleFonts.poppins(fontSize: 14))),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Steps our bus operators take",
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 15),
          ),
          const SizedBox(height: 12),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 3.5,
            children: [
              buildCard("Passenger Screening", Icons.thermostat, BusAddOnPage.themeColor2),
              buildCard("Staff with Masks", Icons.masks, BusAddOnPage.themeColor1),
              buildCard("Sanitized Bus", Icons.cleaning_services, BusAddOnPage.themeColor2),
              buildCard("Hand Sanitizers", Icons.sanitizer, BusAddOnPage.themeColor1),
            ],
          ),
          buildNormsBox(),
        ],
      ),
    );
  }
}

class PolicyTab extends StatelessWidget {
  const PolicyTab({super.key});

  TableRow buildTableRow(String time, String charge, {bool isHeader = false}) {
    final style = GoogleFonts.poppins(fontSize: 13, fontWeight: isHeader ? FontWeight.w600 : FontWeight.normal);
    return TableRow(children: [
      Padding(padding: const EdgeInsets.all(8), child: Text(time, style: style)),
      Padding(padding: const EdgeInsets.all(8), child: Text(charge, style: style)),
    ]);
  }

  Widget buildPolicyNoteBox() {
    final notes = [
      "Cancellation Charges are calculated per passenger.",
      "Charges are based on fare of Rs. 1200.",
      "Calculated from origin date & time.",
      "No cancellation allowed after bus departure.",
      "Policy subject to change by bus operator.",
      "Partial cancellation not allowed.",
    ];

    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: notes
            .map((e) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("• ", style: TextStyle(fontSize: 14)),
                      Expanded(child: Text(e, style: GoogleFonts.poppins(fontSize: 13))),
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Bus Cancellation Policy", style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 15)),
          const SizedBox(height: 10),
          Table(
            border: TableBorder.all(color: Colors.grey.shade300),
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(1),
            },
            children: [
              buildTableRow("Time of Cancellation", "Charges", isHeader: true),
              buildTableRow("After 04 Jul 10:45 – Before 04 Jul 13:45", "Rs 1200 (100%)"),
              buildTableRow("After 04 Jul 04:45 – Before 04 Jul 10:45", "Rs 240 (20%)"),
              buildTableRow("After 03 Jul 16:45 – Before 04 Jul 04:45", "Rs 120 (10%)"),
              buildTableRow("After 04 Jun 16:45 – Before 03 Jul 16:45", "Rs 120 (10%)"),
            ],
          ),
          buildPolicyNoteBox(),
        ],
      ),
    );
  }
}