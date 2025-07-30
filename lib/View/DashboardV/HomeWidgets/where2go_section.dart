import 'package:flutter/material.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/TourScreen/tour_category_view.dart';



class WhereToGoSection extends StatelessWidget {
  const WhereToGoSection({super.key});

  final List<Map<String, String>> items = const [
    {
      'image':
          'https://www.kingsthantourism.com/uploads/packages/thumb/04-days-goa-tour-package-1590829944-9.jpg',
      'label': 'Explore Destinations',
      'title': 'Relax on the beach',
      'slug': 'beaches',
    },
    {
      'image':
          'https://static.toiimg.com/thumb/msid-96460173,width-748,height-499,resizemode=4,imgsize-94378/.jpg',
      'label': 'Themed Recommendation',
      'title': 'Getaways to the Mountains',
      'slug': 'adventure',
    },
    {
      'image':
          'https://media.istockphoto.com/id/1142802668/photo/wedding-travel-honeymoon-trip-couple-in-love-among-balloons-a-guy-proposes-to-a-girl-couple.jpg?s=612x612&w=0&k=20&c=Io03iJTe0GLh6dOAAXXAx8whq9GJgKmIrJg6eJv1Lq4=',
      'label': 'Discover by Interest',
      'title': 'Honeymoon Hotspots',
      'slug': 'honeymoon',
    },
    {
      'image':
          'https://www.kingsthantourism.com/uploads/packages/thumb/04-days-goa-tour-package-1590829944-9.jpg',
      'label': 'Travel by Interest',
      'title': 'Perfect for Groups',
      'slug': 'fixed-group-departure',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'WHERE2GO Next? Let TripGo Inspire You',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 6),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 2 : 4,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.1,
            ),
            itemBuilder: (context, index) {
              final item = items[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          TourCategoryView(name:item['slug'] ?? '', slug: item['slug'] ?? '')
                          ,
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.network(item['image']!, fit: BoxFit.cover),
                      ),
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.75),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 16,
                        left: 10,
                        right: 10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['label']!,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
                                fontFamily: 'Poppins',
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item['title']!,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'Poppins',
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
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
      ),
    );
  }
}
