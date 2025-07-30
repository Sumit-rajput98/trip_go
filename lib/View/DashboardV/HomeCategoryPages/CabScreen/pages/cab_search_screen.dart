import 'package:flutter/material.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/CabScreen/pages/why_trip_go_section.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/CabScreen/widgets/cab_search_card.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/HotelScreen/HotelDetail/hotel_detail_page.dart' as constants;
class CabSearchScreen extends StatefulWidget {
  const CabSearchScreen({super.key});

  @override
  State<CabSearchScreen> createState() => _CabSearchScreenState();
}

class _CabSearchScreenState extends State<CabSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child:Column(
           children: [
             CabSearchCard(),
             SizedBox(height: 20),
             Padding(
               padding: const EdgeInsets.all(16.0),
               child: Column(
                 children: [
                   WhyTripGoSection(),
                   SizedBox(height: 20),
                   BookingProcessSection(),
                 ],
               ),
             )

           ],
                  )
        ),
      ),
    );
  }
}

