import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/profile/login/login_view.dart';
import 'package:trip_go/constants.dart';
import 'package:trip_go/ViewM/AccountVM/user_view_model.dart';

class DrawerUserInfo extends StatefulWidget {
  const DrawerUserInfo({super.key});

  @override
  State<DrawerUserInfo> createState() => _DrawerUserInfoState();
}

class _DrawerUserInfoState extends State<DrawerUserInfo> {
  String? phone, countryCode;
  bool? isLoggedIn;

  @override
  void initState() {
    super.initState();
    _loadAndFetchUser();
  }

  Future<void> _loadAndFetchUser() async {
    final prefs = await SharedPreferences.getInstance();
    phone = prefs.getString('phone')?.trim();
    countryCode = prefs.getString('countryCode') ?? "91";
    isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (phone != null) {
      final userVM = Provider.of<UserViewModel>(context, listen: false);
      await userVM.fetchUserDetail({
        "CountryCode": countryCode,
        "PhoneNumber": phone,
      });
    }

    setState(() {}); // Refresh UI when data is fetched
  }

  @override
  Widget build(BuildContext context) {
    final userVM = Provider.of<UserViewModel>(context);
    final user = userVM.userModel?.data;

    // Show login/signup prompt if not logged in
    if (!(isLoggedIn ?? false)) {
      return Stack(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [constants.themeColor2, constants.themeColor1],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 28,
                  backgroundImage: AssetImage('assets/images/user.png'),
                  backgroundColor: Colors.white,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                   onTap: () async {
  await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const LoginView()),
  );
  _loadAndFetchUser(); // Refresh drawer UI after returning from login
},


                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login or Signup',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'and Grab Exclusive deals',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    // Show user info if logged in
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [constants.themeColor1, constants.themeColor2],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child:
          userVM.isLoading
              ? Shimmer.fromColors(
                baseColor: Colors.white.withOpacity(0.4),
                highlightColor: Colors.white.withOpacity(0.7),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.white,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 16,
                            width: 100,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 6),
                          Container(
                            height: 14,
                            width: 180,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
              : Row(
                children: [
                  const CircleAvatar(
                    radius: 28,
                    backgroundImage: AssetImage('assets/images/user.png'),
                    backgroundColor: Colors.white,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hi, ${user?.firstName ?? "--"}",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          user?.email ?? "--",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
    );
  }
}
