import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/profile/auth_provider.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/profile/user_profile_page.dart';
import 'package:trip_go/View/DashboardV/HomeWidgets/all_deals_page.dart';
import 'package:trip_go/View/DashboardV/my_bookings_screen.dart';
import 'package:trip_go/View/Widgets/about_trip_go_page.dart';
import 'package:trip_go/constants.dart';
import 'package:share_plus/share_plus.dart';

import '../../login_bottom_sheet.dart';
import 'login/login_view.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  
  final List<Map<String, dynamic>> benefits = [
    {
      'title': 'Unlock e-Cash',
      'route': null, // Replace with your actual page
    },
    {'title': 'Manage your bookings', 'route': MyBookingsScreen()},
    {'title': 'Get exclusive deals', 'route': OffersPage()},
    {'title': 'Faster checkouts', 'route': null},
  ];

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AuthProvider>(context, listen: false).checkLoginStatus();
    });
  }

  void _scrollRight() {
    _scrollController.animateTo(
      _scrollController.offset + 120,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final authProvider = Provider.of<AuthProvider>(context);
    final isLoggedIn = authProvider.isLoggedIn;

    // Build dynamic list items
    List<Map<String, String>> listItems = [
      // {
      //   "title": "My Settings",
      //   "img": "https://cdn-icons-png.flaticon.com/512/2099/2099058.png",
      // },
      {
        "title": "Share the App",
        "img": "https://cdn-icons-png.flaticon.com/512/929/929610.png",
      },
      {
        "title": "Rate Us",
        "img": "https://cdn-icons-png.flaticon.com/512/1828/1828884.png",
      },
      {
        "title": "About TripGo",
        "img": "https://cdn-icons-png.flaticon.com/512/942/942748.png",
      },
    ];

    if (isLoggedIn) {
      listItems.insert(0, {
        "title": "My Profile",
        "img": "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: constants.ultraLightThemeColor1,
        title: const Text('Account', style: TextStyle(fontFamily: 'poppins')),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: const Text(
              'Benefits',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'poppins',
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Benefits List with Scroll Icon
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: ListView.separated(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: benefits.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final benefit = benefits[index];
                        final hasRoute = benefit['route'] != null;

                        return InkWell(
                          onTap:
                              hasRoute
                                  ? benefit['title']== 'Manage your bookings'? (){
                                    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    Navigator.pop(context);  
   if (authProvider.isLoggedIn) {
      // Navigate to wallet page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MyBookingsScreen()),
      );
    }
    else{
       Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginView()),
      );
    }
                                  }: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => benefit['route'],
                                      ),
                                    );
                                  }
                                  : null, // Do nothing on tap
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: constants.ultraLightThemeColor1,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  size: 18,
                                  color: constants.lightThemeColor1,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  benefit['title'],
                                  style: const TextStyle(fontFamily: 'Poppins'),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 30, // reduced width
                  child: IconButton(
                    padding: EdgeInsets.zero, // removes internal padding
                    iconSize: 18, // smaller icon
                    icon: const Icon(Icons.arrow_forward_ios),
                    onPressed: _scrollRight,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),
          if (!isLoggedIn)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                height: media.height * 0.06,
                width: media.width,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginView()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: constants.themeColor1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text(
                    'LOGIN / SIGN UP',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontFamily: 'poppins',
                    ),
                  ),
                ),
              ),
            ),

          const SizedBox(height: 20),

          ...listItems.map((item) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: listTileWidget(
                title: item["title"]!,
                img: item["img"]!,
                onTap: () {
                  switch (item["title"]) {
                    case "My Profile":
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const UserProfilePage(),
                        ),
                      );
                      break;

                    case "Share the App":
                      Share.share(
                        'Check out TripGo – your travel buddy! 🚀 Download now: https://www.tripgoonline.com/',
                        subject: 'TripGo App',
                      );
                      break;

                    case "About TripGo":
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AboutTripGoPage(),
                        ),
                      );
                      break;

                    default:
                      // You can show a toast or leave it empty for unimplemented options
                      break;
                  }
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}

class listTileWidget extends StatelessWidget {
  final String title;
  final String img;
  final VoidCallback? onTap;

  const listTileWidget({
    super.key,
    required this.title,
    required this.img,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Image.network(img, height: 20),
      title: Text(title, style: constants.titleStyle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 20),
    );
  }
}
