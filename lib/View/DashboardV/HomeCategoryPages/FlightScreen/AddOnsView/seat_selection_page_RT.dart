import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/AddOnsView/seat_selection_page_on_return.dart';
import '../../../../../Model/FlightM/flight_SSR_round_model.dart';

class SeatSelectionPageRT extends StatefulWidget {
  final Data1? flightSsrRes1;
  final Data1? flightSsrRes2;
  final int adultCount;
  final int? childrenCount;
  final int? infantsCount;

  const SeatSelectionPageRT({
    super.key,
    this.flightSsrRes1,
    this.flightSsrRes2,
    required this.adultCount,
    this.childrenCount,
    this.infantsCount,
  });

  @override
  State<SeatSelectionPageRT> createState() => _SeatSelectionPageRTState();
}

class _SeatSelectionPageRTState extends State<SeatSelectionPageRT>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  final List<String> _tabTitles = ['Onboard', 'Return'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final selectedIndex = _tabController.index;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            //const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFFD1E9FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    color: const Color(0xFF1B499F),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                  tabs: _tabTitles.map((title) {
                    return Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.flight_takeoff, size: 16),
                          const SizedBox(width: 6),
                          Text(title),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  SeatSelectionPageOnReturn(
                    flightSsrRes: widget.flightSsrRes1,
                    adultCount: widget.adultCount,
                    childrenCount: widget.childrenCount,
                    infantsCount: widget.infantsCount,
                    isReturn: false,
                  ),
                  SeatSelectionPageOnReturn(
                    flightSsrRes: widget.flightSsrRes2,
                    adultCount: widget.adultCount,
                    childrenCount: widget.childrenCount,
                    infantsCount: widget.infantsCount,
                    isReturn: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
