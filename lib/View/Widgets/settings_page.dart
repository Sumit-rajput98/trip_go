import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/profile/change_password.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/profile/edit_profile.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/profilePage/change_password.dart';
import 'package:trip_go/View/Widgets/about_trip_go_page.dart';
import 'package:trip_go/View/Widgets/custom_app_bar.dart';
import 'package:trip_go/View/Widgets/notification_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Settings"),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          const SizedBox(height: 10),
          _buildSectionTitle("Account"),
          _buildSettingTile(
            context,
            icon: Icons.lock_outline,
            title: 'Change Password',
            onTap: () {
              Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ChangePasswordView(),
                              ),
                            );
            },
          ),
          _buildSettingTile(
            context,
            icon: Icons.person_outline,
            title: 'Edit Profile',
            onTap: () {
              Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const EditProfilePage(),
                              ),
                            );
            },
          ),
          // _buildSectionTitle("Preferences"),
          // _buildSettingTile(
          //   context,
          //   icon: Icons.notifications_outlined,
          //   title: 'Notifications',
          //   onTap: () {
          //     Navigator.push(
          //                     context,
          //                     MaterialPageRoute(
          //                       builder: (_) => const NotificationPage(),
          //                     ),
          //                   );
          //   },
          // ),
          // _buildSettingTile(
          //   context,
          //   icon: Icons.language_outlined,
          //   title: 'Language',
          //   onTap: () {
              
          //   },
          // ),
          // _buildSettingTile(
          //   context,
          //   icon: Icons.dark_mode_outlined,
          //   title: 'Dark Mode',
          //   trailing: Switch(
          //     value: false,
          //     onChanged: (val) {},
          //   ),
          // ),
          _buildSectionTitle("Support"),
          _buildSettingTile(
            context,
            icon: Icons.info_outline,
            title: 'About Us',
            onTap: () {
              Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const AboutTripGoPage(),
                              ),
                            );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.black54),
      title: Text(
        title,
        style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
      ),
      trailing: trailing ?? const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Text(
        title,
        style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.grey[700]),
      ),
    );
  }
}
