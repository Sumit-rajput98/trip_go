import 'package:flutter/material.dart';
import 'package:trip_go/View/Widgets/custom_app_bar.dart';

class HotDealsPage extends StatefulWidget {
  const HotDealsPage({super.key});

  @override
  State<HotDealsPage> createState() => _HotDealsPageState();
}

class _HotDealsPageState extends State<HotDealsPage> {
  final Color primaryColor = const Color(0xff1B499F);
  int selectedIndex = 0;


  final List<Map<String, dynamic>> offerTabs = [
    {"label": "Hot Deals", "icon": Icons.local_fire_department},
  ];

  final String currentTab = "Hot Deals";

  String getHeadingForTab(String tab) {
    switch (tab) {
      case 'Bank Offers':
        return 'Find Best Bank Offers';
      case 'Flight Offers':
        return 'Latest Flight Booking Discounts';
      case 'Bus Offers':
        return 'Bus Booking Coupons';
      case 'Cab Offers':
        return 'Affordable Cab Rides';
      case 'Hot Deals':
        return 'Hot Travel Deals Right Now';
      default:
        return 'Amazing Travel Offers and Deals';
    }
  }

  List<Map<String, String>> getOffersForTab(String tab) {
    switch (tab) {
      case 'Bank Offers':
        return [
          {
            "image": "https://demoxml.com/html/comre/images/c-img-2.jpg",
            "title": "HDFC Bank Offer",
            "desc": "Use HDFC Cards & Get 10% Off on Flights & Hotels",
            "code": "TRIPGOHDFC"
          },
          {
            "image": "https://demoxml.com/html/comre/images/c-img-3.jpg",
            "title": "ICICI Instant Discount",
            "desc": "Flat ₹1000 Off on Domestic Flights",
            "code": "TRIPGOICICI"
          },
        ];
      default:
        return [
          {
            "image": "https://demoxml.com/html/comre/images/c-img-1.jpg",
            "title": "New User Offer",
            "desc": "Register and Get Discount on First Bookings",
            "code": "TRIPGONEW"
          },
          {
            "image": "https://demoxml.com/html/comre/images/c-img-2.jpg",
            "title": "Book With ₹0 Payment",
            "desc": "Book Hotels with ₹0 Pay Now Option",
            "code": "TRIPGOZERO"
          },
          {
            "image": "https://demoxml.com/html/comre/images/c-img-3.jpg",
            "title": "Pilgrimage Deal",
            "desc": "Save ₹3000 on Religious Tour Packages",
            "code": "TRIPGODIVINE"
          },
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final offers = getOffersForTab(currentTab);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Hot Deals"),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        children: [
          Text(
            getHeadingForTab(currentTab),
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, fontFamily: 'Poppins'),
          ),
          const SizedBox(height: 10),
          _buildSearchBar(),
          const SizedBox(height: 12),
          ...offers.map(_buildOfferCard).toList(),
        ],
      ),
    );
  }

  Widget _buildCustomTabBar() {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(offerTabs.length, (index) {
            final tab = offerTabs[index];
            final isSelected = selectedIndex == index;

            return GestureDetector(
              onTap: () {
                setState(() => selectedIndex = index);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      tab['icon'],
                      color: isSelected ? Colors.white : Colors.black87,
                      size: 18,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      tab['label'],
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search offers...",
        prefixIcon: Icon(Icons.search),
        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        filled: true,
        fillColor: Colors.grey[100],
      ),
      style: TextStyle(fontFamily: 'Poppins', fontSize: 14),
    );
  }

  Widget _buildOfferCard(Map<String, String> deal) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  deal['image']!,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(deal['title']!,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Poppins')),
                    SizedBox(height: 4),
                    Text(deal['desc']!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 12, fontFamily: 'Poppins', color: Colors.black87)),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text("PROMOCODE",
                    style: TextStyle(fontSize: 11, fontFamily: 'Poppins', color: Colors.black87)),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    Text(deal['code']!,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins')),
                    const SizedBox(width: 4),
                    Icon(Icons.copy, size: 16),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
