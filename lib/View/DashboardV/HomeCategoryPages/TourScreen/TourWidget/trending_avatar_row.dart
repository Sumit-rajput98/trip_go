import 'package:flutter/material.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/TourScreen/tour_category_view.dart';

class TrendingAvatarRow extends StatelessWidget {
  const TrendingAvatarRow({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> items = [
      {
        'name': 'Group Departure',
        'slug': 'fixed-group-departure',
        'image': 'https://images.unsplash.com/photo-1511632765486-a01980e01a18?...'
      },
      {
        'name': 'Honeymoon',
        'slug': 'honeymoon',
        'image': 'https://images.unsplash.com/photo-1654413285620-12c2a8e1f6dd?...'
      },
      {
        'name': 'Family',
        'slug': 'family',
        'image': 'https://images.unsplash.com/photo-1611024847487-e26177381a3f?...'
      },
      {
        'name': 'Beaches',
        'slug': 'beaches',
        'image': 'https://images.unsplash.com/photo-1590523741831-ab7e8b8f9c7f?...'
      },
      {
        'name': 'Luxury',
        'slug': 'luxury',
        'image': 'https://plus.unsplash.com/premium_photo-1677474827617-6a7269f97574?...'
      },
      {
        'name': 'Adventure',
        'slug': 'adventure',
        'image': 'https://images.unsplash.com/flagged/photo-1557806856-73584969d0c5?...'
      },
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue.shade200, width: 1),
          borderRadius: BorderRadius.circular(45),
        ),
        child: Row(
          children: items.map((item) {
            return Container(
              margin: const EdgeInsets.only(right: 20),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => TourCategoryView(
                      name: item['name']!,
                      slug: item['slug']!,
                    )),
                  );
                },
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(item['image']!),
                      radius: 22,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      item['name']!,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'poppins'
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
