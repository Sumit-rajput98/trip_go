import 'package:flutter/material.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/CabScreen/pages/cab_search_screen.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/VisaScreen/visa_screen.dart';
import 'package:trip_go/View/Widgets/support_page.dart';
// import 'package:trip_go/View/DashboardV/HomeCategoryPages/BusScreen/bus_screen_view.dart';
import 'package:trip_go/constants.dart';
import 'HomeCategoryPages/BusScreen/BusScreen/bus_screen_view.dart';
import 'HomeCategoryPages/FlightScreen/flight_booking_screen.dart';
import 'HomeCategoryPages/HotelScreen/hotel_page_screen.dart';
import 'HomeCategoryPages/TourScreen/tour_page.dart';

class VisaPage extends StatelessWidget {
  const VisaPage({super.key});

  @override
  Widget build(BuildContext context) => Center(child: Text("Visa Page"));
}

class ActivityPage extends StatelessWidget {
  const ActivityPage({super.key});

  @override
  Widget build(BuildContext context) => Center(child: Text("Activity Page"));
}

class ForexPage extends StatelessWidget {
  const ForexPage({super.key});

  @override
  Widget build(BuildContext context) => Center(child: Text("Forex Page"));
}

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

class CategoryScreen extends StatefulWidget {
  final int initialIndex;

  const CategoryScreen({super.key, this.initialIndex = 0});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late int selectedIndex;
  final ScrollController _scrollController = ScrollController();


  final List<String> menuItems = [
    'Flight', 'Hotel', 'Tours', 'Buses', 'Cabs', 'Visa', 'Insurance', 'Forex'
  ];

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex;

    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (selectedIndex == menuItems.length - 1) {
        _scrollToEnd();
      }
    });
  }

  void _scrollToEnd() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  final List<String> menuIcons = [
    'assets/icons/flight.png',
    'assets/icons/hotel.png',
    'assets/icons/holiday.png',
    'assets/icons/bu.png',
    'assets/icons/cab.png',
    'assets/icons/visa.png', 
    'assets/icons/insurance.png', // Activities
    'assets/icons/forex.png',
  ];

  final List<Widget> pages = [
    FlightBookingScreen(),
    HotelScreen(),
    TourPage(),
    BusScreenView(),
    CabSearchScreen(),
    VisaScreen(),
    VisaScreen(),
    VisaScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 40.0, // Sets the AppBar height to 40 pixels
        centerTitle: false,  // Aligns the title to the start (left)
        titleSpacing: 0,     // Removes default spacing before the title
        leading: IconButton(
          icon: Icon(Icons.arrow_circle_left_outlined, size: 30),
          padding: EdgeInsets.zero, // Eliminates padding around the icon
          constraints: BoxConstraints(), // Removes default constraints
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          menuItems[selectedIndex],
          style: TextStyle(
            fontSize: 16.0,
            fontFamily: 'poppins',
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
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
                          color: isSelected ? constants.ultraLightThemeColor1 : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: isSelected ? constants.themeColor1 : Colors.transparent,
                            width: 1,
                          ),
                        ),
                        child: Column(
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
                                color: isSelected ? constants.themeColor1 : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
          // SizedBox(height: 10),
          Expanded(child: pages[selectedIndex]),
        ],
      ),
    );
  }
}
