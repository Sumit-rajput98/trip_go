import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/TourScreen/TourPartsSection/carsoul_section.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/TourScreen/TourPartsSection/contact_info_banner.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/TourScreen/TourPartsSection/holiday_theme_scroll_section.dart';
import '../../../../constants.dart';
import 'TourPartsSection/destination_page_view.dart';
import 'TourPartsSection/international_destinations.dart';
import 'TourPartsSection/popular_indian_destination.dart';
import 'TourPartsSection/tour_slider_card.dart';
import 'TourWidget/explore_more_button.dart';
import 'TourWidget/trending_avatar_row.dart';

class TrendingDestinations extends StatefulWidget {
  const TrendingDestinations({super.key});

  @override
  State<TrendingDestinations> createState() => _TrendingDestinationsState();
}

class _TrendingDestinationsState extends State<TrendingDestinations> {
  final PageController _pageController = PageController(viewportFraction: 0.95);
  int _currentPage = 0;
  Timer? _autoScrollTimer;

  final List<List<Map<String, String>>> _citiesGrouped = [
    [
      {'name': 'Bhutan', 'image': 'https://plus.unsplash.com/premium_photo-1661952578770-79010299a9f9?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8Ymh1dGFufGVufDB8fDB8fHww'},
      {'name': 'Australia', 'image': 'https://images.unsplash.com/photo-1624138784614-87fd1b6528f8?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8QXVzdHJhbGlhfGVufDB8fDB8fHww'},
    ],
    [
      {'name': 'Dubai', 'image': 'https://images.unsplash.com/photo-1694834394112-efef3fbb26f2?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fER1YmFpfGVufDB8fDB8fHww'},
      {'name': 'Japan', 'image': 'https://images.unsplash.com/photo-1683120057335-440c32aa38ff?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8SmFwYW58ZW58MHx8MHx8fDA%3D'},
    ],
    [
      {'name': 'Switzerland', 'image': 'https://media.istockphoto.com/id/1826593744/photo/snow-falling-and-train-passing-through-famous-mountain-in-filisur-switzerland-train-express.webp?a=1&b=1&s=612x612&w=0&k=20&c=s0ueBC8p3Y01Fi7zxd_8x5YcbOEPJf0A5ZflPf9fQCY='},
      {'name': 'Singapore', 'image': 'https://plus.unsplash.com/premium_photo-1697729432930-3f11644e9184?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8c2luZ2Fwb3JlfGVufDB8fDB8fHww'},
    ],
    [
      {'name': 'Bali', 'image': 'https://plus.unsplash.com/premium_photo-1677829177642-30def98b0963?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OXx8QmFsaXxlbnwwfHwwfHx8MA%3D%3D'},
      {'name': 'Thailand', 'image': 'https://plus.unsplash.com/premium_photo-1661962958462-9e52fda9954d?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8VGhhaWxhbmR8ZW58MHx8MHx8fDA%3D'},
    ],
  ];

  @override
  void initState() {
    super.initState();

    _pageController.addListener(() {
      int next = _pageController.page!.round();
      if (_currentPage != next) {
        setState(() {
          _currentPage = next;
        });
      }
    });

    _autoScrollTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_pageController.hasClients) {
        int nextPage = (_pageController.page!.round() + 1) % _citiesGrouped.length;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TrendingAvatarRow(),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: RichText(
              text: TextSpan(
                text: 'Top',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: constants.themeColor1,
                ),
                children: [
                  TextSpan(
                    text: ' Trending Destinations',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Explore the hottest travel spots around the globe and experience the best of holidays.',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[700]),
            ),
          ),
          const SizedBox(height: 20),

          DestinationPageView(
            pageController: _pageController,
            currentPage: _currentPage,
          ),

          const SizedBox(height: 24),
          CustomCarousel(),
          const SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: const PopularIndianDestination(),
          ),

          const SizedBox(height: 50),

          ExploreMoreButton(
            onPressed: () {
              // Your navigation or action logic here
            },
          ),

          const SizedBox(height: 40),

          SizedBox(
            height: 650, // Increased height to allow image to show above
            child: Stack(
              children: [
                // Background image floating above the slider cards
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: 320,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Background image
                      Image.network(
                        'https://www.tripgoonline.com/Images/tour/banner-hq.jpg',
                        fit: BoxFit.cover,
                      ),

                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 30,),
                          Text(
                            'FEATURED TOUR',
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              letterSpacing: 1.2,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'poppins'
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'Most Popular',
                            style: TextStyle(
                              fontSize: 40,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'poppins'
                            ),
                          ),
                          Text(
                            'Tours',
                            style: TextStyle(
                              fontSize: 40,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'poppins'
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // The card list appears below the top image
                Positioned(
                  top: 240, // Push down so the top image is not covered
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    height: 390,
                    child: AutoSlidingTourSlider(),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: const InternationalDestinations(),
          ),

          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: ExploreMoreButton(
              onPressed: () {
                // Your navigation or action logic here
              },
            ),
          ),

          HolidayThemeScroll(),
          SizedBox(height: 20,),
          ContactInfoBanner(),
          SizedBox(height: 20,),
        ],
      ),
    );
  }
}



