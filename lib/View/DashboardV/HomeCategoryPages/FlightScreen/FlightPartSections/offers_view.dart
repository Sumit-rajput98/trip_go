import 'package:flutter/material.dart';

import '../../../../../constants.dart';

class OffersView extends StatefulWidget {
  const OffersView({super.key});

  @override
  State<OffersView> createState() => _OffersViewState();
}

class _OffersViewState extends State<OffersView> {
  final List<String> titles = ['All', 'Flights', 'Hotels', 'Cabs', 'Bus'];
  String selected = 'All'; // default selected
  final List<Map<String, String>> offers = [
    {
      'image': 'assets/images/deal.png',
      'category': 'Bus, Hotels, Cabs, Flight',
      'title': 'Ready for some DealPanti',
    },
    {
      'image': 'assets/images/akasa.png',
      'category': 'FLights',
      'title': 'Flat ₹500 off on flight bookings!',
    },
  ];


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Offers For You",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'poppins',
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'poppins',
                    color: constants.themeColor2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Five Bordered Boxes
            /*Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: titles.map((title) {
                final isSelected = selected == title;
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selected = title;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isSelected ? Colors.blue : Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          title,
                          style: TextStyle(
                            color: isSelected ? Colors.blue : Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            fontFamily: 'poppins',
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 20),*/

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(2, (index) {
                return Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Rounded Image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            offers[index]['image']!, // Different image
                            height: 160,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Small text
                        Text(
                          offers[index]['category']!,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontFamily: 'poppins',
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Heading text
                        Text(
                          offers[index]['title']!,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontFamily: 'poppins',
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}