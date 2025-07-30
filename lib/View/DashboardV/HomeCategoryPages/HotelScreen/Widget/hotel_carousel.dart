import 'dart:async';
import 'package:flutter/material.dart';

class HotelCarousel extends StatefulWidget {
  const HotelCarousel({super.key});

  @override
  State<HotelCarousel> createState() => _HotelCarouselState();
}

class _HotelCarouselState extends State<HotelCarousel> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> carouselData = [
    {
      'image':
      'https://www.harbourhotels.co.uk/media/d4ipp450/1c57cb2a162815dd23ef3db35d0e8521.jpg',
      'title': 'Search Hotel\nSmooth Hotel Booking\nUnbeatable Low Price',
    },
    {
      'image':
      'https://3.imimg.com/data3/FM/MD/MY-1906485/hotel-booking.jpg',
      'title': 'Unlock Exclusive Deals\nPremium Stays',
    },
    {
      'image':
      'https://www.harbourhotels.co.uk/media/d4ipp450/1c57cb2a162815dd23ef3db35d0e8521.jpg',
      'title': 'Experience Hassle-Free\nHotel Bookings\nPremium Stays',
    },
  ];

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_pageController.hasClients) {
        _currentPage = (_currentPage + 1) % carouselData.length;
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300, // Adjust as needed
      child: PageView.builder(
        controller: _pageController,
        itemCount: carouselData.length,
        itemBuilder: (context, index) {
          final item = carouselData[index];
          return Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                item['image']!,
                fit: BoxFit.cover,
              ),
              Container(
                color: Colors.black.withOpacity(0.3),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.99,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    item['title']!,
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'poppins',
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
