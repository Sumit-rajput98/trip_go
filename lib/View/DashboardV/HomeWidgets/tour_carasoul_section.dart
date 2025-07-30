import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/TourScreen/tour_category_view.dart';



class TourCarouselSection extends StatelessWidget {
  const TourCarouselSection({super.key});

  final List<Map<String, String>> carouselData = const [
    {
      'image':
          'https://images.pexels.com/photos/31625198/pexels-photo-31625198/free-photo-of-aerial-view-of-melasti-beach-coastal-road-in-bali.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
          
      'slug': 'megahalaya'
    },
    {
      'image':
          'https://images.pexels.com/photos/30596983/pexels-photo-30596983/free-photo-of-aerial-view-of-eiffel-tower-in-paris.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'slug': 'france'
    },
    {
      'image':
          'http://images.pexels.com/photos/31643020/pexels-photo-31643020/free-photo-of-serene-river-landscape-in-ramamangalam-kerala.png?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'slug': 'kerala'
    },
    {
      'image':
          'https://images.pexels.com/photos/31546481/pexels-photo-31546481/free-photo-of-ancient-temple-in-siem-reap-surrounded-by-lush-trees.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'slug': 'saudi'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 160,
        enlargeCenterPage: true,
        autoPlay: true,
        viewportFraction: 0.85,
      ),
      items: carouselData.map((item) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => TourCategoryView(name:item['slug']!,slug: item['slug']!),
              ),
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              item['image']!,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
        );
      }).toList(),
    );
  }
}
