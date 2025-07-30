import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_go/constants.dart';
import '../../ViewM/AccountVM/user_booking_view_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Bookings/booking_card.dart';
import 'Bookings/status_tabs_bookings.dart';
import 'bottom_navigation_bar.dart';

class MyBookingsScreen extends StatefulWidget {
  const MyBookingsScreen({super.key});

  @override
  _MyBookingsScreenState createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen> {
  int selectedCategoryIndex = 0; // Flights
  int selectedStatusIndex = 0;   // Upcoming
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

  // final List<String> statusTabs = [
  //   'Upcoming', 'Cancelled', 'Completed', 'Unsuccessful'
  // ];

  final List<String> statusTabs = [
    'All', 'Successful', 'Failed', 'Other Fare', 'Other Class','Booked Other', 'Not Confirmed'
  ];

  @override
  void initState() {
    super.initState();
    Future.microtask(()async {
      final prefs = await SharedPreferences.getInstance();

      final phone = prefs.getString('phone') ?? '';
      final countryCode = prefs.getString('countryCode') ?? '91';

      Provider.of<UserBookingViewModel>(context, listen: false)
          .fetchUserBookingDetails(
        countryCode: countryCode,
        phoneNumber: phone,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<UserBookingViewModel>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 40.0,
        centerTitle: false,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 0),
          child: Text(
            'My Bookings',
            style: TextStyle(
              fontSize: 16.0,
              fontFamily: 'poppins',
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_circle_left_outlined, size: 30),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const BottomNavigationbar(),
              ),
                  (route) => false, // This removes all previous routes
            );
          },
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

          // STATUS TABS
          StatusTabs(
            tabs: statusTabs,
            selectedIndex: selectedStatusIndex,
            onTabSelected: (index) => setState(() => selectedStatusIndex = index),
          ),

          // CONTENT AREA
          Expanded(
            child: Builder(
              builder: (_) {
                if (viewModel.isLoading) {
                  return Center(child: CircularProgressIndicator());
                }

                if (viewModel.error != null) {
                  return Center(child: Text(viewModel.error!));
                }

                final bookings = viewModel.bookingModel?.data ?? [];

                if (selectedCategoryIndex == 0) {
                  // Flights only
                  final filteredBookings = bookings.where((booking) {
                    switch (selectedStatusIndex) {
                      case 0: return true;                     // All
                      case 1: return booking.status == 1;      // Successful
                      case 2: return booking.status == 2;      // Failed
                      case 3: return booking.status == 3;      // OtherFare
                      case 4: return booking.status == 4;      // OtherClass
                      case 5: return booking.status == 5;      // Booked Other
                      case 6: return booking.status == 6;      // Not Confirmed
                      default: return true;
                    }
                  }).toList();

                  if (filteredBookings.isEmpty) {
                    return Center(
                      child: Text(
                        "No bookings found.",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: filteredBookings.length,
                    padding: const EdgeInsets.all(16),
                    itemBuilder: (context, index) =>
                        BookingCard(booking: filteredBookings[index]),
                  );
                }

                return Center(
                  child: Text(
                    '${statusTabs[selectedStatusIndex]} ${bookingCategories[selectedCategoryIndex]} Bookings',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
