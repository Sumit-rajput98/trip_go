import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/profile/auth_provider.dart';
import 'package:trip_go/View/Widgets/country_selection_page.dart';

import 'drawer_header.dart';
import 'drawer_main_options.dart';
import 'drawer_quick_access.dart';
import 'drawer_social_links.dart';
import 'drawer_user_info.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  
  String selectedCountry = 'India';
  final List<Map<String, String>> countries = [
    {'name': 'India', 'flag': 'https://flagcdn.com/w40/in.png'},
    {'name': 'USA', 'flag': 'https://flagcdn.com/w40/us.png'},
    {'name': 'UK', 'flag': 'https://flagcdn.com/w40/gb.png'},
    {'name': 'Germany', 'flag': 'https://flagcdn.com/w40/de.png'},
    {'name': 'France', 'flag': 'https://flagcdn.com/w40/fr.png'},
    {'name': 'Japan', 'flag': 'https://flagcdn.com/w40/jp.png'},
    {'name': 'Canada', 'flag': 'https://flagcdn.com/w40/ca.png'},
    {'name': 'Brazil', 'flag': 'https://flagcdn.com/w40/br.png'},
    {'name': 'Australia', 'flag': 'https://flagcdn.com/w40/au.png'},
    {'name': 'Italy', 'flag': 'https://flagcdn.com/w40/it.png'},
  ];

  Future<void> _logout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Confirm Logout"),
        content: const Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              "Logout",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await Provider.of<AuthProvider>(context, listen: false).logout();
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Logged out successfully")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Drawer(
      width: 380,
      backgroundColor: Colors.white,
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                SizedBox(height: 30,),
                const DrawerHeaderCloseButton(),
                const DrawerUserInfo(),
                const DrawerQuickAccess(),
                const DrawerMainOptions(),
                const SizedBox(height: 10),
                const DrawerSocialLinks(),
                const SizedBox(height: 10),

                // Country/Region Selection
                Card(
                  elevation: 2,
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CountrySelectionPage(
                            selectedCountry: selectedCountry,
                            onApply: (value) => setState(() => selectedCountry = value),
                          ),
                        ),
                      );
                    },
                    child: ListTile(
                      leading: Image.network(
                        countries.firstWhere((c) => c['name'] == selectedCountry)['flag'] ?? '',
                        width: 24,
                        height: 16,
                        fit: BoxFit.cover,
                      ),
                      title: Text("Country/Region", style: constants.fontStyle),
                      subtitle: Text(selectedCountry, style: constants.titleStyle),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 20),
                    ),
                  ),
                ),

                // Logout Button (only when logged in)
                if (authProvider.isLoggedIn)
                  Card(
                    elevation: 2,
                    color: Colors.white,
                    child: InkWell(
                      onTap: _logout,
                      child: ListTile(
                        leading: Icon(Icons.logout, size: 30, color: Colors.red[900]),
                        title: Text("Log out", style: constants.singIn),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 20),
                      ),
                    ),
                  ),

                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class constants{
static var primaryColor = const Color(0xff296e48);

  static var appBarColor = Colors.blue;
  static var blackColor = Colors.black;
  static var subtitleColor = Colors.black;
  static var fontStyle = GoogleFonts.poppins(
      fontSize: 11, color: Colors.black,
      fontWeight: FontWeight.w400
  );
  static var titleStyle = GoogleFonts.poppins(
    fontSize: 13, color: Colors.black,
    fontWeight: FontWeight.w700,
  );
  static var emailStyle = GoogleFonts.poppins(
    fontSize: 15, color: Colors.black,
    fontWeight: FontWeight.bold,
  );
  static var emtPro = GoogleFonts.poppins(
    fontSize: 15, color: Colors.yellow[800],
    fontWeight: FontWeight.bold,
  );
  static var emtPro2 = GoogleFonts.poppins(
    fontSize: 10, color: Colors.white,
    fontWeight: FontWeight.bold,
  );
  static var singIn = GoogleFonts.poppins(
    fontSize: 15, color: Colors.red[900],
    fontWeight: FontWeight.w700,
  );

  //Onbording text
  static var titleOne = "Your Booking";
  static var subtitleOne = "view and manage your bookings";
  static var titleTwo = "Emt wallet";
  static var subtitleTwo = "Use your wallet for hassle-free bookings";
  static var titleThree = "EMT PRO";
  static var subtitleThree = "Join TripGo Pro for premium services";
  static var titleFour = "Gift Cards/Coupon";
  static var subtitleTFour = "Check savings on your bookings";
  static var titleFive = "Promo Codes";
  static var subtitleFive = "Refer a Friend and Earn";
  static var titleSix = "Help Center";
  static var subtitleSix = "Contact our customer support";
  static var titleSeven= "Refer and Earn";
  static var subtitleSeven = "Refer a Friend and invite them to Sing Up";
  static var title = "Rate our App";
  static var subtitle= "Share your feedback";
  static Color themeColor1= Color(0xff1B499F);
  static Color themeColor2= Color(0xffF73130);
}
class listTileWidget extends StatelessWidget {
  final String title;
  final String img;
  final double? size;
  const listTileWidget({
    super.key,
    required this.title, required this.img,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(img,height: size,),
      title: Text(title,style: constants.titleStyle,),
      trailing: Icon(Icons.arrow_forward_ios,size: 20,),
    );
  }
}