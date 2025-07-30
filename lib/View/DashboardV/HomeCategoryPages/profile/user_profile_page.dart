import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/profile/auth_provider.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/profile/profile_page.dart';
import 'package:trip_go/View/Widgets/settings_page.dart';
import 'package:trip_go/ViewM/AccountVM/user_view_model.dart';
import 'package:trip_go/constants.dart';
import 'package:share_plus/share_plus.dart';

import 'edit_profile.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  String? phone, countryCode;

  final List<Map<String, String>> listItems = [
    {
      "title": "Edit Profile",
      "img": "https://cdn-icons-png.flaticon.com/512/1077/1077063.png",
    },
    {
      "title": "My Settings",
      "img": "https://cdn-icons-png.flaticon.com/512/2099/2099058.png",
    }
    // {
    //   "title": "Share the App",
    //   "img": "https://cdn-icons-png.flaticon.com/512/929/929610.png",
    // },
    // {
    //   "title": "Rate Us",
    //   "img": "https://cdn-icons-png.flaticon.com/512/1828/1828884.png",
    // },
    // {
    //   "title": "About TripGo",
    //   "img": "https://cdn-icons-png.flaticon.com/512/942/942748.png",
    // },
  ];

  @override
  void initState() {
    super.initState();
    _loadAndFetchUser();
  }

  Future<void> _loadAndFetchUser() async {
    final prefs = await SharedPreferences.getInstance();
    phone = prefs.getString('phone')?.trim();
    countryCode = prefs.getString('countryCode') ?? "91";

    if (phone != null) {
      final userVM = Provider.of<UserViewModel>(context, listen: false);
      await userVM.fetchUserDetail({
        "CountryCode": countryCode,
        "PhoneNumber": phone,
      });
    }
  }

  Future<void> _logout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text("Confirm Logout"),
            content: const Text("Are you sure you want to logout?"),
            actions: [
              TextButton(
                child: const Text("Cancel"),
                onPressed: () => Navigator.pop(context, false),
              ),
              TextButton(
                child: const Text(
                  "Logout",
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () => Navigator.pop(context, true),
              ),
            ],
          ),
    );

    if (confirmed == true) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      Provider.of<AuthProvider>(context, listen: false).logout();

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const ProfilePage()),
        (route) => false,
      );

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Logged out successfully")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final userVM = Provider.of<UserViewModel>(context);
    final user = userVM.userModel?.data;

    final fullName = [
      if (user?.title?.isNotEmpty ?? false) user?.title,
      user?.firstName,
      user?.lastName,
    ].where((e) => e != null && e!.isNotEmpty).join(" ");

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: constants.ultraLightThemeColor1,
        title: const Text('Account', style: TextStyle(fontFamily: 'poppins')),
        centerTitle: true,
        elevation: 0,
      ),
      body:
          userVM.isLoading
              ? const Center(child: CircularProgressIndicator())
              : user == null
              ? const Center(child: Text("No user data found"))
              : ListView(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                children: [
                  const SizedBox(height: 20),
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    color: Colors.white,
                    shadowColor: Colors.grey.shade200,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                              'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Hi,",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'poppins',
                                  ),
                                ),
                                Text(
                                  fullName,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'poppins',
                                  ),
                                ),
                                if ((user.email ?? '').isNotEmpty)
                                  Text(
                                    user.email!,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'poppins',
                                    ),
                                  ),
                                if ((user.phone ?? '').isNotEmpty)
                                  Text(
                                    user.phone!,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'poppins',
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // if (user.address != null ||
                  //     user.dob != null ||
                  //     user.gender != null)
                  //   Card(
                  //     elevation: 4, // Changed from 2 to match profile card
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(12),
                  //     ),
                  //     color: Colors.white, // Added to match profile card
                  //     shadowColor:
                  //         Colors.grey.shade200, // Added to match profile card
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(16),
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           if (user.address != null ||
                  //               user.city != null ||
                  //               user.zip != null)
                  //             _infoRow(
                  //               "Address",
                  //               "${user.address ?? ''}, ${user.city ?? ''}, ${user.state ?? ''}, ${user.country ?? ''} - ${user.zip ?? ''}",
                  //             ),
                  //           if (user.dob != null)
                  //             _infoRow(
                  //               "DOB",
                  //               user.dob.toString().split("T").first,
                  //             ),
                  //           if (user.gender != null)
                  //             _infoRow("Gender", user.gender.toString()),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // const SizedBox(height: 20),
                  ...listItems.map((item) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: listTileWidget(
                        title: item["title"]!,
                        img: item["img"]!,
                        onTap: () async {
                          if (item["title"] == "Edit Profile") {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const EditProfilePage(),
                              ),
                            );
                            await _loadAndFetchUser(); // reload user data
                          } else if (item["title"] == "My Settings") {
                           Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const SettingsPage(),
                              ),
                            );
                          }
                        },
                      ),
                    );
                  }),
                  const SizedBox(height: 10),
                  listTileWidget(
                    title: "Logout",
                    img:
                        "https://cdn-icons-png.flaticon.com/512/1828/1828479.png",
                    onTap: _logout,
                  ),
                ],
              ),
    );
  }

  // Widget _infoRow(String label, String value) {
  //   return Padding(
  //     padding: const EdgeInsets.only(bottom: 12),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           label,
  //           style: const TextStyle(
  //             fontSize: 14,
  //             fontWeight: FontWeight.w600,
  //             fontFamily: 'poppins',
  //             color: Colors.black,
  //           ),
  //         ),
  //         const SizedBox(height: 4),
  //         Text(
  //           value,
  //           style: const TextStyle(
  //             fontSize: 14,
  //             fontFamily: 'poppins',
  //             color: Colors.black87,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
