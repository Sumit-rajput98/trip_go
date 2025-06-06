import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'FlightWidgets/responsive_app_bar.dart';

class FlightLoadingScreen extends StatelessWidget {
  final String fromCity;
  final String toCity;
  final DateTime departureDate;
  final int adultCount;

  const FlightLoadingScreen({
    super.key,
    required this.fromCity,
    required this.toCity,
    required this.departureDate,
    required this.adultCount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: ResponsiveAppBar(
          title: "$fromCity to $toCity",
          subtitle:
          "${DateFormat('EEE dd MMM').format(departureDate)} | $adultCount Adult",
          onFilter: () {},
          onMore: () {},
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/loading.png',
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 16),
              const Text(
                "Fetching Flight Search Results...",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontFamily: 'poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 120),
            ],
          ),
        ),
      ),
    );
  }
}
