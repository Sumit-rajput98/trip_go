import 'package:flutter/material.dart';
import 'HomeCategoryPages/FlightScreen/flight_booking_screen.dart';
import 'HomeCategoryPages/HotelScreen/hotel_page_screen.dart';
import 'HomeCategoryPages/TourScreen/tour_page.dart';
import 'package:trip_go/View/DashboardV/Widget/dashboard_app_bar.dart';

class CabsPage extends StatelessWidget {
  const CabsPage({super.key});

  @override
  Widget build(BuildContext context) => Center(child: Text("Cabs Page"));
}

class BusesPage extends StatelessWidget {
  const BusesPage({super.key});

  @override
  Widget build(BuildContext context) => Center(child: Text("Buses Page"));
}

class HomeScreen extends StatefulWidget {
  final int initialIndex;

  const HomeScreen({super.key, this.initialIndex = 0});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCountry = 'India';
  late int selectedIndex;

  final List<String> menuItems = ['Flight', 'Hotel', 'Tours', 'Cabs', 'Buses'];
  final List<String> menuIcons = [
    'assets/icons/flight2.png',
    'assets/icons/hotel2.png',
    'assets/icons/tours2.png',
    'assets/icons/cabs2.png',
    'assets/icons/buses2.png',
  ];

  final List<Widget> pages = [
    FlightBookingScreen(),
    HotelScreen(),
    TourPage(),
    CabsPage(),
    BusesPage(),
  ];

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: DashboardAppBar(
        selectedCountry: selectedCountry,
        onCountryChanged: (value) {
          if (value != null) {
            setState(() {
              selectedCountry = value;
            });
          }
        },
      ),
      body: Column(
        children: [
          Divider(color: Colors.grey.shade300, thickness: 1.0),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(menuItems.length, (index) {
                bool isSelected = selectedIndex == index;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.deepPurple.shade50 : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isSelected ? Colors.deepPurple.shade100 : Colors.transparent,
                        width: 1,
                      ),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        if (isSelected)
                          Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: RadialGradient(
                                colors: [
                                  Colors.white.withOpacity(0.6),
                                  Colors.white.withOpacity(0.0),
                                ],
                                radius: 0.7,
                              ),
                            ),
                          ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(menuIcons[index], width: 34, height: 34),
                            SizedBox(height: 5),
                            Text(
                              menuItems[index],
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'poppins',
                                fontWeight: FontWeight.w500,
                                color: isSelected ? Colors.deepPurple : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
          SizedBox(height: 10),
          Expanded(child: pages[selectedIndex]),
        ],
      ),
    );
  }
}