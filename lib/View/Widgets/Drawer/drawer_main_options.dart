import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/profile/auth_provider.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/profile/login/login_view.dart';
import 'package:trip_go/View/DashboardV/bottom_navigation_bar.dart';
import 'package:trip_go/View/DashboardV/my_bookings_screen.dart';
import 'package:trip_go/View/Widgets/Drawer/custom_drawer.dart';
import 'package:trip_go/View/Widgets/wallat_page.dart';

class DrawerMainOptions extends StatelessWidget {
  const DrawerMainOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Colors.white,
      child: Column(
        children: [
          _drawerTile(
            icon: Icons.confirmation_number,
            title: constants.titleOne,
            subtitle: constants.subtitleOne,
            onTap: () => _handleBookingTap(context),
          ),
          _divider(),
          _drawerTile(
            icon: Icons.account_balance_wallet_outlined,
            title: "TripGo wallet",
            subtitle: constants.subtitleTwo,
            onTap: () => _handleWalletTap(context),
          ),
          //_proTile(),
        ],
      ),
    );
  }

  void _handleBookingTap(BuildContext context) {
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
  }

  void _handleWalletTap(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    Navigator.pop(context); // Close drawer first

    if (authProvider.isLoggedIn) {
      // Navigate to wallet page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const WalletPage()),
      );
    } else {
      // Navigate to login with callback
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginView(),
        ),
      );
    }
  }

  Widget _divider() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Divider(
      height: 1,
      color: Colors.black.withOpacity(.2),
      thickness: .5,
    ),
  );

  Widget _drawerTile({
    required IconData icon,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, size: 30, color: const Color(0xff1B499F)),
      title: Text(title, style: constants.titleStyle),
      subtitle: Text(subtitle, style: constants.fontStyle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 20),
    );
  }
}



