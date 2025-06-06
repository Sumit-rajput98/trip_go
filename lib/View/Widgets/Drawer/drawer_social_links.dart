import 'package:flutter/material.dart';
import 'package:trip_go/constants.dart';

import 'custom_drawer.dart';

class DrawerSocialLinks extends StatelessWidget {
  const DrawerSocialLinks({super.key});


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Colors.white,
      child:  Column(
        children: [
          InkWell(
            onTap: (){},
            child: listTileWidget(title: 'Instagram', img: 'https://clipart-library.com/images_k/instagram-png-transparent/instagram-png-transparent-22.png',),
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
            onTap: (){},
            child: listTileWidget(title: 'Facebook', img: 'https://cdn.pixabay.com/photo/2021/06/15/12/51/facebook-6338509_1280.png',),
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
            onTap: (){},
            child: listTileWidget(title: 'X', img: 'https://freepnglogo.com/images/all_img/1707222563twitter-logo-png.png',),

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
            onTap: (){},
            child: listTileWidget(title: 'LinkedIn', img: 'https://static.vecteezy.com/system/resources/previews/018/930/480/non_2x/linkedin-logo-linkedin-icon-transparent-free-png.png',),

          ),
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
