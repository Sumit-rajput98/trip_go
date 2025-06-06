import 'package:flutter/material.dart';import 'package:trip_go/constants.dart';

import 'edit_profile.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {

  final List<Map<String, String>> listItems = [
    {
      "title": "My Profile",
      "img": "https://cdn-icons-png.flaticon.com/512/1077/1077063.png",
    },
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
    },
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
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                // Avatar Image
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                    'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
                  ),
                ),
                const SizedBox(width: 16),
                // Text Column
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Hi,", style: TextStyle(fontSize: 14, fontFamily: 'poppins')),
                    Text("Suren", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'poppins')),
                    Text("suren@gmail.com", style: TextStyle(fontSize: 14, fontFamily: 'poppins')),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 30,),
          ...listItems.map((item) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: listTileWidget(
                title: item["title"]!,
                img: item["img"]!,
                onTap: () {
                  if (item["title"] == "My Profile") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const EditProfilePage()),
                    );
                  }
                },
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