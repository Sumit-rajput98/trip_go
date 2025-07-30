import 'package:flutter/material.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/HotelScreen/HotelSection/benefits_section_for_hotels.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/HotelScreen/HotelSection/trip_planner_section.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/HotelScreen/Widget/hotel_search_card.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/HotelScreen/Widget/hotel_search_card2.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/HotelScreen/Widget/hotel_search_section.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/HotelScreen/Widget/view_more_button.dart';
import 'package:trip_go/View/DashboardV/HomeWidgets/benifits_section.dart';

import 'HotelSection/popular_hotel_destination.dart';

class HotelScreen extends StatefulWidget {
  const HotelScreen({super.key});

  @override
  State<HotelScreen> createState() => _HotelScreenState();
}

class _HotelScreenState extends State<HotelScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: const [
            HotelSearchCard2(), // ✅ Child section without Scaffold
            SizedBox(height: 20,),
            PopularHotelDestinations(),
            SizedBox(height: 10,),
            ViewMoreButton(),
            SizedBox(height: 60,),
            TripPlannerScreen(),
            SizedBox(height: 40,),
            BenefitsSection(),
          ],
        ),
      ),
    );
  }
}
