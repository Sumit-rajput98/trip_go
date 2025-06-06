import 'package:flutter/material.dart';
import 'package:trip_go/constants.dart';

import '../../login_bottom_sheet.dart';
import 'login_view.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final List<String> benefits = [
    'Unlock e-Cash',
    'Manage your bookings',
    'Get exclusive deals',
    'Faster checkouts',
  ];

  final ScrollController _scrollController = ScrollController();

  // Call this to scroll forward
  void _scrollRight() {
    _scrollController.animateTo(
      _scrollController.offset + 120,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  final List<Map<String, String>> listItems = [
    {
      "title": "My Settings",
      "img": "https://cdn-icons-png.flaticon.com/512/2099/2099058.png",
    },
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
    }
  ];

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: constants.ultraLightThemeColor1,
        title: const Text(
          'Account',
          style: TextStyle(fontFamily: 'poppins'),
        ),
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
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'poppins'),
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
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: constants.ultraLightThemeColor1,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.check_circle, size: 18, color: constants.lightThemeColor1,),
                                const SizedBox(width: 6),
                                Text(benefits[index]),
                              ],
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
              )
            ),

            const SizedBox(height: 30),

            // Login Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                height: media.height * 0.06,
                width: media.width,
                child: ElevatedButton(
                  onPressed: () {
                    // showModalBottomSheet(
                    //   context: context,
                    //   isScrollControlled: true,
                    //   backgroundColor: Colors.transparent,
                    //   builder: (_) => const LoginBottomSheet(),
                    // );
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginView()));
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
                    style: TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'poppins'),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // List Tiles
            ...listItems.map((item) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: listTileWidget(
                  title: item["title"]!,
                  img: item["img"]!,
                ),
              );
            }).toList(),
          ],
        ),
    );
  }
}

// Your list tile widget
class listTileWidget extends StatelessWidget {
  final String title;
  final String img;
  const listTileWidget({
    super.key,
    required this.title,
    required this.img,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(img, height: 20),
      title: Text(title, style: constants.titleStyle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 20),
    );
  }
}
