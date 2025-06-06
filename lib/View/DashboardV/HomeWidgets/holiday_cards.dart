import 'package:flutter/material.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/common_widget/bottom_sgeets.dart';

class HolidaySection extends StatelessWidget {
  const HolidaySection({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> holidayCards = [
      {
        'imageUrl':
        'https://img.freepik.com/free-photo/bali-pagoda-sunrise-indonesia_1150-11013.jpg?t=st=1746547094~exp=1746550694~hmac=c7ae29a0e824785bc0ed3fd50064c1ef5c9b25dc8e763fee50391b86e217c553&w=1380',
        'title': 'Bali Paradise',
      },
      {
        'imageUrl':
        'https://img.freepik.com/free-photo/famous-eiffel-tower-paris-with-beautiful-sunrise-sky_1150-11061.jpg',
        'title': 'Romantic Paris',
      },
      {
        'imageUrl':
        'https://img.freepik.com/free-photo/mountains-nature-landscape-travel_1150-10565.jpg',
        'title': 'Swiss Alps',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HorizontalScrollerWidget(cards: holidayCards),
      ],
    );
  }
}

class HorizontalScrollerWidget extends StatelessWidget {
  final List<Map<String, String>> cards;

  const HorizontalScrollerWidget({
    super.key,
    required this.cards,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        height: 180,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(cards.length, (index) {
              final card = cards[index];
              return Container(
                width: 150,
                height: 180,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 4,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                      child: Image.network(
                        card['imageUrl']!,
                        height: 100,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        card['title']!,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'By TripGo',
                            style: TextStyle(fontSize: 10, color: Colors.grey),
                          ),
                          Text(
                            'Read more',
                            style: TextStyle(fontSize: 10, color: AppColors.themeColor2), // Replace with your AppColors.themeColor2
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

