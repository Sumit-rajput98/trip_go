import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trip_go/Model/FlightM/flight_SSR_round_model.dart';
import 'meal_addon_round.dart';

class MealSelectionPageRT extends StatefulWidget {
  final Data1? flightSsrRes1;
  final Data1? flightSsrRes2;
  final int? adultCount;

  const MealSelectionPageRT({
    super.key,
    this.flightSsrRes1,
    this.flightSsrRes2,
    this.adultCount
  });

  @override
  State<MealSelectionPageRT> createState() => _MealSelectionPageRTState();
}

class _MealSelectionPageRTState extends State<MealSelectionPageRT>
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Tabs
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
                          const Icon(Icons.fastfood, size: 16),
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
            // Tab Views
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  MealsAddOnsRoundPage(flightSsrRes: widget.flightSsrRes1, isReturn: false,),
                  MealsAddOnsRoundPage(flightSsrRes: widget.flightSsrRes2, isReturn: true,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
