import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';

import 'package:trip_go/View/Widgets/Drawer/custom_drawer.dart';


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
            icon: CupertinoIcons.tickets,
            title: constants.titleOne,
            subtitle: constants.subtitleOne,
          ),
          _divider(),
          _drawerTile(
            icon: Icons.account_balance_wallet_outlined,
            title: "TripGo wallet",
            subtitle: constants.subtitleTwo,
          ),
          //_proTile(),
        ],
      ),
    );
  }

  Widget _divider() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Divider(
      height: 1,
      color: Colors.black.withOpacity(.2),
      thickness: .5,
    ),
  );

  Widget _drawerTile({required IconData icon, required String title, required String subtitle}) {
    return InkWell(
      onTap: () {},
      child: ListTile(
        leading: Icon(icon, size: 30, color: const Color(0xff1B499F)),
        title: Text(title, style: constants.titleStyle),
        subtitle: Text(subtitle, style: constants.fontStyle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 20),
      ),
    );
  }

  Widget _proTile() {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: const Color(0xff1B499F),
          borderRadius: BorderRadius.circular(5),
        ),
        child: ListTile(
          leading: ImageIcon(
            const NetworkImage("https://cdn-icons-png.flaticon.com/512/9967/9967681.png"),
            size: 30,
            color: Colors.yellow[800],
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              children: [
                Text("TripGo Pro", style: constants.emtPro),
                const SizedBox(width: 10),
                Container(
                  height: 15,
                  width: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.red,
                  ),
                  child: Center(
                    child: Text(
                      "NEW",
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          subtitle: Text("Join TripGo Pro for premium services", style: constants.emtPro2),
          trailing: Icon(Icons.arrow_forward_ios, size: 20, color: Colors.yellow[800]),
        ),

      ),
    );
  }
}
