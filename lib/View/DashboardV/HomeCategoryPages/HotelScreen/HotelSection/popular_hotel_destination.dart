import 'package:flutter/material.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/HotelScreen/hotel_search_view.dart';
import 'package:intl/intl.dart';

class PopularHotelDestinations extends StatefulWidget {
  const PopularHotelDestinations({super.key});

  @override
  State<PopularHotelDestinations> createState() =>
      _PopularHotelDestinationsState();
}

class _PopularHotelDestinationsState extends State<PopularHotelDestinations> {
  int selectedIndex = -1;

  final List<Map<String, String>> destinations = const [
    {
      "image": "https://www.easemytrip.com/images/hotel-img/hyd-sm.webp",
      "title": "Hyderabad",
      "desc":
          "Hotels, Budget Hotels, 3 Star Hotels, 4 Star Hotels, 5 Star Hotels",
    },
    {
      "image": "https://www.easemytrip.com/images/hotel-img/goa-sm.webp",
      "title": "Goa",
      "desc":
          "Hotels, Budget Hotels, 3 Star Hotels, 4 Star Hotels, 5 Star Hotels",
    },
    {
      "image": "https://www.easemytrip.com/images/hotel-img/mumb-sm.webp",
      "title": "Mumbai",
      "desc":
          "Hotels, Budget Hotels, 3 Star Hotels, 4 Star Hotels, 5 Star Hotels",
    },
    {
      "image": "https://www.easemytrip.com/images/hotel-img/pune-sm.webp",
      "title": "Pune",
      "desc":
          "Hotels, Budget Hotels, 3 Star Hotels, 4 Star Hotels, 5 Star Hotels",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final tomorrow = today.add(const Duration(days: 1));

    final formattedCin = DateFormat('yyyy-MM-dd').format(today);
    final formattedCout = DateFormat('yyyy-MM-dd').format(tomorrow);

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Center(
              child: Text(
                "Book Hotels at Popular Destinations",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'poppins',
                ),
              ),
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: destinations.length,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemBuilder: (context, index) {
            final item = destinations[index];
            final isSelected = selectedIndex == index;

            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => HotelSearchResultPage(
                          city: item['title']!,
                          cin: formattedCin,
                          cout: formattedCout,
                          rooms: '1',
                          pax: "1_0", // 1 adult, 0 children
                          totalGuests: 1,
                        ),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFCCCBFF)),
                  gradient:
                      isSelected
                          ? const LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [Colors.white, Color(0xFFDDE8FE)],
                          )
                          : null,
                  color: isSelected ? null : Colors.white,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        item['image']!,
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['title']!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'poppins',
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item['desc']!,
                            style: const TextStyle(
                              fontSize: 12,
                              fontFamily: 'poppins',
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
