import 'package:flutter/material.dart';

import '../../Widgets/Drawer/custom_drawer.dart';

class DashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String selectedCountry;
  final Function(String?) onCountryChanged;

  DashboardAppBar({super.key, 
    required this.selectedCountry,
    required this.onCountryChanged,
  });

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


  void _showCountryPopup(BuildContext context) {
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
                      return SizedBox(
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
    return AppBar(
      backgroundColor: Colors.white,
      titleSpacing: 0,
      title: Column(
        children: [
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment:CrossAxisAlignment.start,
                  children: [
                    InkWell(onTap:() {
                      showGeneralDialog(
                        context: context,
                        barrierDismissible: true,
                        barrierLabel: "Drawer",
                        barrierColor: Colors.black.withOpacity(0.5), // background dim
                        transitionDuration: Duration(milliseconds: 300),
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: MediaQuery.of(context).size.height,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(5),
                                  bottomRight: Radius.circular(5),
                                ),
                              ),
                              child: CustomDrawer(), // Your Drawer
                            ),
                          );
                        },
                        transitionBuilder: (context, animation, secondaryAnimation, child) {
                          final tween = Tween<Offset>(
                            begin: Offset(-1, 0), // From left outside screen
                            end: Offset(0, 0),    // To center
                          ).chain(CurveTween(curve: Curves.easeInOut));

                          return SlideTransition(
                            position: animation.drive(tween),
                            child: child,
                          );
                        },
                      );
                    },child: Icon(Icons.list, color: Colors.black, size: 30)),
                    /*IconButton(
                        icon: Icon(Icons.list, color: Colors.black, size: 30),
                      onPressed: () {
                        showGeneralDialog(
                          context: context,
                          barrierDismissible: true,
                          barrierLabel: "Drawer",
                          barrierColor: Colors.black.withOpacity(0.5), // background dim
                          transitionDuration: Duration(milliseconds: 300),
                          pageBuilder: (context, animation, secondaryAnimation) {
                            return Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                height: MediaQuery.of(context).size.height,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  ),
                                ),
                                child: CustomDrawer(), // Your Drawer
                              ),
                            );
                          },
                          transitionBuilder: (context, animation, secondaryAnimation, child) {
                            final tween = Tween<Offset>(
                              begin: Offset(-1, 0), // From left outside screen
                              end: Offset(0, 0),    // To center
                            ).chain(CurveTween(curve: Curves.easeInOut));

                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                            );
                          },
                        );
                      },
                    ),*/
                    SizedBox(width: 10),
                    Image.asset("assets/images/trip_go.png", height: 35),

                  ],
                ),
                GestureDetector(
                  onTap: () => _showCountryPopup(context),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Row(
                      children: [
                        Image.network(
                          countries.firstWhere((c) => c['name'] == selectedCountry)['flag'] ?? '',
                          width: 24,
                          height: 16,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(width: 4),
                        Text(
                          selectedCountry,
                          style: TextStyle(fontSize: 14, color: Colors.black54, fontFamily: 'poppins'),
                        ),
                        SizedBox(width: 2),
                        Icon(Icons.keyboard_arrow_down, size: 20, color: Colors.grey),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight - 10);
}
