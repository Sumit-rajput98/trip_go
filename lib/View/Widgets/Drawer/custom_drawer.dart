import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trip_go/View/Widgets/Drawer/trip_go_offer_card.dart';
import 'package:trip_go/View/Widgets/country_selection_page.dart';

import 'drawer_header.dart';
import 'drawer_main_options.dart';
import 'drawer_quick_access.dart';
import 'drawer_social_links.dart';
import 'drawer_user_info.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String selectedCountry = 'India';
  final List<Map<String, String>> countries = [
    {'name': 'India', 'flag': 'https://flagcdn.com/w40/in.png'},
    {'name': 'USA', 'flag': 'https://flagcdn.com/w40/us.png'},
    {'name': 'UK', 'flag': 'https://flagcdn.com/w40/gb.png'},
    {'name': 'Germany', 'flag': 'https://flagcdn.com/w40/de.png'},
    {'name': 'France', 'flag': 'https://flagcdn.com/w40/fr.png'},
    {'name': 'Japan', 'flag': 'https://flagcdn.com/w40/jp.png'},
    {'name': 'Canada', 'flag': 'https://flagcdn.com/w40/ca.png'},
    {'name': 'Brazil', 'flag': 'https://flagcdn.com/w40/br.png'},
    {'name': 'Australia', 'flag': 'https://flagcdn.com/w40/au.png'},
    {'name': 'Italy', 'flag': 'https://flagcdn.com/w40/it.png'},
  ];
  void showCountryPopup(BuildContext context,String selectedCountry,Function(String?) onCountryChanged) {
    final overlay = Overlay.of(context);
    OverlayEntry? entry;

    entry = OverlayEntry(
      builder: (context) => Positioned(
        top: kToolbarHeight + 10,
        right: 0,
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 250,
            height: 300,
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),  // padding adjustments
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8)],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero, // Remove the default padding
                    itemCount: countries.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 36, // fixed height for uniformity and compactness
                        child: InkWell(
                          onTap: () {
                            onCountryChanged(countries[index]['name']);
                            entry?.remove();
                          },
                          child: Row(
                            children: [
                              SizedBox(width: 8),
                              Image.network(
                                countries[index]['flag'] ?? '',
                                width: 24,
                                height: 16,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(width: 10),
                              Text(
                                countries[index]['name'] ?? '',
                                style: TextStyle(fontSize: 14, fontFamily: 'poppins'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    overlay.insert(entry);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 380,
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10,right: 10),
          child: Column(
            children: [
              const DrawerHeaderCloseButton(),
              const DrawerUserInfo(),
              //const TripGoOfferCard(),
              const DrawerQuickAccess(),
              DrawerMainOptions(),
              const SizedBox(height: 10),
              DrawerSocialLinks(),
              const SizedBox(height: 10),
              Card(
                elevation: 2,
                color: Colors.white,
                child:  Column(
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>CountrySelectionPage(selectedCountry: selectedCountry, onApply: (value) {
                          if (value != null) {
                            setState(() {
                              selectedCountry = value;
                            });
                          }
                        },)));
                        /*showCountryPopup(context,selectedCountry,
                           (value) {
                            if (value != null) {
                              setState(() {
                                selectedCountry = value;
                              });
                            }
                          },);*/
                      },
                      child: ListTile(
                        leading: Image.network(
                          countries.firstWhere((c) => c['name'] == selectedCountry)['flag'] ?? '',
                          width: 24,
                          height: 16,
                          fit: BoxFit.cover,
                        ),
                        title: Text("Country/Region",style: constants.fontStyle,),
                        subtitle: Text(selectedCountry,style: constants.titleStyle,),
                        trailing: Icon(Icons.arrow_forward_ios,size: 20,),
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                elevation: 2,
                color: Colors.white,
                child:  Column(
                  children: [
                    InkWell(
                      onTap: (){},
                      child: ListTile(
                        leading: Icon(Icons.logout,size: 30,color: Colors.red[900],),
                        title: Text("Sign out ",style: constants.singIn,),
                        trailing: Icon(Icons.arrow_forward_ios,size: 20,),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10,),
            ],
          ),
        ),
      ),


    );
  }
}

class listTileWidget extends StatelessWidget {
  final String title;
  final String img;
  const listTileWidget({
    super.key,
    required this.title, required this.img
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(img,height: 30,),
      title: Text(title,style: constants.titleStyle,),
      trailing: Icon(Icons.arrow_forward_ios,size: 20,),
    );
  }
}



class constants{
static var primaryColor = const Color(0xff296e48);

  static var appBarColor = Colors.blue;
  static var blackColor = Colors.black;
  static var subtitleColor = Colors.black;
  static var fontStyle = GoogleFonts.poppins(
      fontSize: 11, color: Colors.black,
      fontWeight: FontWeight.w400
  );
  static var titleStyle = GoogleFonts.poppins(
    fontSize: 13, color: Colors.black,
    fontWeight: FontWeight.w700,
  );
  static var emailStyle = GoogleFonts.poppins(
    fontSize: 15, color: Colors.black,
    fontWeight: FontWeight.bold,
  );
  static var emtPro = GoogleFonts.poppins(
    fontSize: 15, color: Colors.yellow[800],
    fontWeight: FontWeight.bold,
  );
  static var emtPro2 = GoogleFonts.poppins(
    fontSize: 10, color: Colors.white,
    fontWeight: FontWeight.bold,
  );
  static var singIn = GoogleFonts.poppins(
    fontSize: 15, color: Colors.red[900],
    fontWeight: FontWeight.w700,
  );

  //Onbording text
  static var titleOne = "Your Booking";
  static var subtitleOne = "view and manage your bookings";
  static var titleTwo = "Emt wallet";
  static var subtitleTwo = "Use your wallet for hassle-free bookings";
  static var titleThree = "EMT PRO";
  static var subtitleThree = "Join TripGo Pro for premium services";
  static var titleFour = "Gift Cards/Coupon";
  static var subtitleTFour = "Check savings on your bookings";
  static var titleFive = "Promo Codes";
  static var subtitleFive = "Refer a Friend and Earn";
  static var titleSix = "Help Center";
  static var subtitleSix = "Contact our customer support";
  static var titleSeven= "Refer and Earn";
  static var subtitleSeven = "Refer a Friend and invite them to Sing Up";
  static var title = "Rate our App";
  static var subtitle= "Share your feedback";
  static Color themeColor1= Color(0xff1B499F);
  static Color themeColor2= Color(0xffF73130);
}
