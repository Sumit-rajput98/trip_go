import 'package:flutter/material.dart';
import 'package:trip_go/View/DashboardV/home_screen.dart';
import 'package:trip_go/constants.dart';
import '../Widgets/Drawer/custom_drawer.dart';
import 'category_screen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  //String selectedCountry = 'India';

  final List<String> menuItems = [
    'Flight', 'Hotel', 'Tours', 'Buses', // Top 4
    'Cabs ', 'Visa', 'Insurance', 'Forex' // Bottom 4
  ];

  final List<String> menuIcons = [
    'assets/icons/flight.png',
    'assets/icons/hotel.png',
    'assets/icons/holiday.png',
    'assets/icons/bu.png',
    'assets/icons/cab.png',
    'assets/icons/visa.png',
    'assets/icons/insurance.png',
    'assets/icons/forex.png',
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // In your build method:
            Container(
              height: screenHeight * 0.3,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(50),
                ),
                image: DecorationImage(
                  image: AssetImage('assets/images/home-bg.jpg'),
                  fit:
                  BoxFit
                      .cover,
                  /*colorFilter: ColorFilter.mode(
                    Color(0xff1B499F).withOpacity(0.75),
                    BlendMode.softLight,
                  ),*/
                ),
              ),
              padding: EdgeInsets.fromLTRB(
                screenWidth * 0.04,
                screenHeight * 0.06,
                screenWidth * 0.04,
                screenHeight * 0.02,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () => _showCustomDrawer(context),
                        child: Icon(
                          Icons.menu,
                          color: Color(0xff1B499F),
                          size: screenWidth * 0.07,
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.035),
                      Image.asset(
                        "assets/images/trip_go.png",
                        height: screenHeight * 0.045,
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icons/notification.png', // replace with your actual notification image path
                        height: screenWidth * 0.065,
                      ),
                      SizedBox(width: screenWidth * 0.04),
                      Image.asset(
                        'assets/icons/wallet.png', // replace with your actual wallet image path
                        height: screenWidth * 0.065,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Positioned(
              top: screenHeight * 0.3 - (screenHeight * 0.06), // 6% overlap
              left: screenWidth * 0.04,
              right: screenWidth * 0.04,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Container(
                  height: screenHeight * 0.12, // Adjust card height as needed
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(4, (index) {
                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => _navigateToCategory(context, index),
                        child: _buildTopCategoryItem(context, index),
                      );
                    }),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.3 + screenHeight * 0.06,),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                    child: Column(
                      children: [
                        SizedBox(height: screenHeight * 0.02),
                        // SizedBox(height: screenHeight * 0.04), // space below top 4
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(4, (i) {
                              return GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () => _navigateToCategory(context, i + 4),
                                child: _buildBottomCategoryItem(context, i + 4),
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                  HomeScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopCategoryItem(BuildContext context, int index) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth * 0.20, // Responsive width
      padding: EdgeInsets.all(screenWidth * 0.025),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            menuIcons[index],
            width: screenWidth * 0.090,
            height: screenWidth * 0.095,
          ),
          SizedBox(height: screenWidth * 0.01),
          Text(
            menuItems[index],
            style: TextStyle(
              fontSize: screenWidth * 0.033,
              fontFamily: 'poppins',
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomCategoryItem(BuildContext context, int index) {
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => _navigateToCategory(context, index),
      child: Container(
        width: screenWidth * 0.21,
        height: screenWidth * 0.21,
        padding: EdgeInsets.all(screenWidth * 0.02),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3)),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(height: 10,),
            Image.asset(
              menuIcons[index],
              width: screenWidth * 0.085,
              height: screenWidth * 0.085,
            ),
            SizedBox(height: screenWidth * 0.01),
            Text(
              menuItems[index],
              style: TextStyle(
                fontSize: screenWidth * 0.031,
                fontFamily: 'poppins',
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToCategory(BuildContext context, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => CategoryScreen(initialIndex: index)),
    );
  }

  void _showCustomDrawer(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Drawer",
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
            ),
            child: CustomDrawer(),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final tween = Tween<Offset>(
          begin: Offset(-1, 0),
          end: Offset(0, 0),
        ).chain(CurveTween(curve: Curves.easeInOut));

        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }
}
