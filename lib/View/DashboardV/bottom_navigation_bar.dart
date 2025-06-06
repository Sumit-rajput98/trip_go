import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:trip_go/View/DashboardV/dashboard_screen.dart';
import '../../constants.dart';
import 'HomeCategoryPages/profile/profile_page.dart';
import 'category_screen.dart';
import 'login_bottom_sheet.dart';
import 'my_bookings_screen.dart';

class BookingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(child: Text("Bookings Page"));
}

class WalletPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(child: Text("Wallets Page"));
}

class BottomNavigationbar extends StatefulWidget {
  const BottomNavigationbar({super.key});

  @override
  State<BottomNavigationbar> createState() => _BottomNavigationbarState();
}

class _BottomNavigationbarState extends State<BottomNavigationbar> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => const LoginBottomSheet(),
      );
    });
  }

  int _bottomNavIndex = 0;

  List<Widget> pages = [
    DashboardScreen(),
    MyBookingsScreen(),
    WalletPage(),
    ProfilePage()
  ];

  List<IconData> iconList = [
    CupertinoIcons.home,
    CupertinoIcons.tickets,
    Icons.account_balance_wallet_outlined,
    CupertinoIcons.person,
  ];

  List<String> titleList = [
    "Home",
    "Bookings",
    "Wallet",
    "Profile",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: IndexedStack(
          index: _bottomNavIndex,
          children: pages,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(top: 25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 62,
                width: 62,
                decoration: BoxDecoration(
                  color: constants.themeColor1,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                    )
                  ],
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.mic,
                      color: Colors.white, size: 32),
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                "Voice Search",
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'poppins'
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 65,
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
              ),
            ],
          ),
          child: AnimatedBottomNavigationBar.builder(
            itemCount: iconList.length,
            tabBuilder: (int index, bool isActive) {
              final color = isActive ? constants.themeColor1 : Colors.grey;

              // Add horizontal padding near the center FAB
              if (index == 1) {
                return Padding(
                  padding: const EdgeInsets.only(right: 24), // Before FAB
                  child: buildTabItem(index, color),
                );
              } else if (index == 2) {
                return Padding(
                  padding: const EdgeInsets.only(left: 24), // After FAB
                  child: buildTabItem(index, color),
                );
              } else {
                return buildTabItem(index, color);
              }
            },
            activeIndex: _bottomNavIndex,
            gapLocation: GapLocation.center,
            notchSmoothness: NotchSmoothness.softEdge,
            notchMargin: 8,
            backgroundColor: Colors.transparent,
            leftCornerRadius: 24,
            rightCornerRadius: 24,
            splashColor: constants.themeColor2,
            elevation: 0,
            onTap: (index) {
              setState(() {
                _bottomNavIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget buildTabItem(int index, Color color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(iconList[index], size: 24, color: color),
        const SizedBox(height: 4),
        Text(
          titleList[index],
          style: TextStyle(
            fontSize: 11,
            color: color,
            fontWeight: FontWeight.w500,
            fontFamily: 'poppins',
          ),
        ),
      ],
    );
  }
}