import 'package:flutter/material.dart';
import 'package:trip_go/constants.dart';

import 'Bookings/cancelled_flight_page.dart';
import 'Bookings/upcoming_flight_page.dart';

class MyBookingsScreen extends StatefulWidget {
  @override
  _MyBookingsScreenState createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen> {
  int selectedCategoryIndex = 0;
  int selectedStatusIndex = 0;
  final ScrollController _categoryScrollController = ScrollController();
  final ScrollController _statusScrollController = ScrollController();

  final List<String> bookingCategories = [
    'Flights', 'Hotels', 'Tours', 'Buses', 'Cabs', 'Visa', 'Activities', 'Forex'
  ];

  final List<String> bookingIcons = [
    'assets/icons/flight.png',
    'assets/icons/hotel.png',
    'assets/icons/holiday.png',
    'assets/icons/bu.png',
    'assets/icons/cab.png',
    'assets/icons/visa.png',
    'assets/icons/insurance.png',
    'assets/icons/forex.png',
  ];

  final List<String> statusTabs = [
    'Upcoming', 'Cancelled', 'Completed', 'Unsuccessful'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 40.0,
        centerTitle: false,
        titleSpacing: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_circle_left_outlined, size: 30),
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'My Bookings',
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
          // CATEGORY SCROLLER
          SingleChildScrollView(
            controller: _categoryScrollController,
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(bookingCategories.length, (index) {
                    bool isSelected = selectedCategoryIndex == index;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategoryIndex = index;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
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
                            Image.asset(bookingIcons[index], width: 34, height: 34),
                            SizedBox(height: 5),
                            Text(
                              bookingCategories[index],
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'poppins',
                                fontWeight: FontWeight.w500,
                                color: isSelected ? Colors.deepPurple : Colors.black,
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

          // STATUS SCROLLER
          SingleChildScrollView(
            controller: _statusScrollController,
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8),
                color: Colors.white,
                child: Row(
                  children: List.generate(statusTabs.length, (index) {
                    bool isSelected = selectedStatusIndex == index;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedStatusIndex = index;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        decoration: BoxDecoration(
                          color: isSelected ? constants.ultraLightThemeColor1 : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected ? constants.themeColor1 : Colors.grey.shade300,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          statusTabs[index],
                          style: TextStyle(
                            fontSize: 13,
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.w500,
                            color: isSelected ? Colors.deepPurple : Colors.black,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),


          // CONTENT AREA
          Expanded(
            child: (selectedCategoryIndex == 0 && selectedStatusIndex == 0)
                ? UpcomingFlightsPage()
                : (selectedCategoryIndex == 0 && selectedStatusIndex == 1)
                ? CancelledFlightsPage()
                : Center(
              child: Text(
                '${statusTabs[selectedStatusIndex]} ${bookingCategories[selectedCategoryIndex]} Bookings',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'poppins',
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
