import 'package:flutter/material.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/HotelScreen/Widget/hotel_carousel.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/HotelScreen/Widget/hotel_search_card.dart';

class HotelSearchSection extends StatefulWidget {
  const HotelSearchSection({super.key});

  @override
  State<HotelSearchSection> createState() => _HotelSearchSectionState();
}

class _HotelSearchSectionState extends State<HotelSearchSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 690, // Adjust as needed
          child: Stack(
            children: [
              // Background Image
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 320,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    HotelCarousel(),
                  ],
                ),
              ),

              // Search Card
              Positioned(
                top: 250,
                left: 15,
                right: 15,
                child: SizedBox(
                  height: 490,
                  child: HotelSearchCard(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
