import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/profile/auth_provider.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/profile/login/login_view.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/profile/profile_page.dart';
import 'package:trip_go/View/Widgets/notification_page.dart';
import 'package:trip_go/View/Widgets/support_page.dart';
import 'package:trip_go/constants.dart';

class DrawerQuickAccess extends StatelessWidget {
  const DrawerQuickAccess({super.key});

  void _handleAccountTap(BuildContext context) {
    //final authProvider = Provider.of<AuthProvider>(context, listen: false);
    
    
      Navigator.push(
        context, 
        MaterialPageRoute(builder: (context) => const ProfilePage())
      );
    
  }
  void _handleSupportTap(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>SupportPage()));
  }
  void _handleNotificationTap(BuildContext context){
     final authProvider = Provider.of<AuthProvider>(context, listen: false);
    Navigator.pop(context);  
   if (authProvider.isLoggedIn) {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>NotificationPage()));
   }
    else{
       Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginView()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final iconSize = screenWidth * 0.06;
    final circleSize = screenWidth * 0.14;

    final items = [
      {
        'icon': Icons.person_outline, 
        'label': 'My Account',
        'onTap': () => _handleAccountTap(context)
      },
      {
        'icon': Icons.chat_bubble_outline, 
        'label': 'Support',
        'onTap': ()=> _handleSupportTap(context)// Add support page navigation
      },
      {
        'icon': Icons.notifications_none, 
        'label': 'Notifications',
        'onTap': () => _handleNotificationTap(context)// Add notifications page navigation
      },
    ];

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.map((item) {
          return Column(
            children: [
              GestureDetector(
                onTap: item['onTap'] as VoidCallback?,
                child: Container(
                  width: circleSize,
                  height: circleSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [constants.themeColor1, constants.themeColor1],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: constants.themeColor1.withOpacity(0.2),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      item['icon'] as IconData,
                      size: iconSize,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                item['label'] as String,
                style: GoogleFonts.poppins(
                  fontSize: screenWidth * 0.032,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
