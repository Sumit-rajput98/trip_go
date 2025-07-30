import 'package:flutter/material.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/BusScreen/BusScreen/popular_bus_destinatoins.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/BusScreen/BusScreen/why_book_with_us_section.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/HotelScreen/Widget/view_more_button.dart';
import 'bus_search_card.dart';

class BusScreenView extends StatefulWidget {
  const BusScreenView({super.key});

  @override
  State<BusScreenView> createState() => _BusScreenViewState();
}

class _BusScreenViewState extends State<BusScreenView> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
             BusSearchCard2(),
             const SizedBox(height: 20,),
             const PopularBusDestinatoins(),
             const SizedBox(height: 10,),
            const ViewMoreButton(),
            const SizedBox(height: 10,),
            const WhyBookWithUsSection(),
            SizedBox(height: 30,),
          ],
        ),
      ),
    );
 
  }
}