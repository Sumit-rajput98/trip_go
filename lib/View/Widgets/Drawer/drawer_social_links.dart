import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'custom_drawer.dart';

class DrawerSocialLinks extends StatefulWidget {
  const DrawerSocialLinks({super.key});

  @override
  State<DrawerSocialLinks> createState() => _DrawerSocialLinksState();
}

class _DrawerSocialLinksState extends State<DrawerSocialLinks> {
  _launchURL(String link) async {
  final url = link;
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    throw 'Could not launch $url';
  }
}
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Colors.white,
      child:  Column(
        children: [
          InkWell(
            onTap: (){
              _launchURL('https://www.instagram.com/tripgo_online?igshid=YmMyMTA2M2Y%3D');
            },
            child: listTileWidget(title: 'Instagram', img: 'https://cdn-icons-png.flaticon.com/128/174/174855.png', size: 30,),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10,right: 10,),
            child: Divider(
              height: 1,
              color: Colors.black.withOpacity(.2),
              thickness: .5,
            ),
          ),
          InkWell(
            onTap: (){
              _launchURL('https://www.facebook.com/TravelTGO/');
            },
            child: listTileWidget(title: 'Facebook', img: 'https://cdn-icons-png.flaticon.com/128/733/733547.png', size: 30,),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10,right: 10,),
            child: Divider(
              height: 1,
              color: Colors.black.withOpacity(.2),
              thickness: .5,
            ),
          ),
          InkWell(
            onTap: (){
              _launchURL('https://twitter.com/tripgoonline');
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 6),
              child: listTileWidget(title: 'X', img: 'https://cdn-icons-png.flaticon.com/128/5968/5968958.png', size: 20,),
            ),

          ),
          Padding(
            padding: const EdgeInsets.only(left: 10,right: 10,),
            child: Divider(
              height: 1,
              color: Colors.black.withOpacity(.2),
              thickness: .5,
            ),
          ),
          // InkWell(
          //   onTap: (){},
          //   child: listTileWidget(title: 'LinkedIn', img: 'https://static.vecteezy.com/system/resources/previews/018/930/480/non_2x/linkedin-logo-linkedin-icon-transparent-free-png.png',),

          // ),
           Padding(
            padding: const EdgeInsets.only(left: 10,right: 10,),
            child: Divider(
              height: 1,
              color: Colors.black.withOpacity(.2),
              thickness: .5,
            ),
          ),

        ],
      ),
    );
  }
}
