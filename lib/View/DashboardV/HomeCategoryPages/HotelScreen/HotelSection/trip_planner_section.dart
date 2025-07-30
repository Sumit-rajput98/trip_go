import 'dart:async';
import 'package:flutter/material.dart';

class TripPlannerScreen extends StatefulWidget {
  const TripPlannerScreen({super.key});

  @override
  State<TripPlannerScreen> createState() => _TripPlannerScreenState();
}

class _TripPlannerScreenState extends State<TripPlannerScreen> {
  final List<String> categories = ["All", "City", "Beach", "Outdoor", "Relax", "Romance"];
  String selectedCategory = "All";
  int currentPage = 0;
  late PageController _pageController;
  Timer? _timer;

  final Map<String, List<Map<String, String>>> categoryData = {
    "All": [
      {
        "image": "https://dreamstour.dreamstechnologies.com/html/assets/img/destination/destination-04.jpg",
        "title": "Brazil"
      },
      {
        "image": "https://dreamstour.dreamstechnologies.com/html/assets/img/destination/destination-03.jpg",
        "title": "Australia"
      },
      {
        "image": "https://dreamstour.dreamstechnologies.com/html/assets/img/destination/destination-05.jpg",
        "title": "Canada"
      },
      {
        "image": "https://dreamstour.dreamstechnologies.com/html/assets/img/destination/destination-01.jpg",
        "title": "Turkey"
      },
      {
        "image": "https://dreamstour.dreamstechnologies.com/html/assets/img/destination/destination-02.jpg",
        "title": "Thailand"
      },
    ],
    "City": [
      {
        "image": "https://dreamstour.dreamstechnologies.com/html/assets/img/destination/destination-05.jpg",
        "title": "Canada"
      }

    ],
    "Beach": [
      {
        "image": "https://dreamstour.dreamstechnologies.com/html/assets/img/destination/destination-02.jpg",
        "title": "Thailand"
      },
    ],
    "Outdoor": [
      {
        "image": "https://dreamstour.dreamstechnologies.com/html/assets/img/destination/destination-03.jpg",
        "title": "Australia"
      },
    ],
    "Relax": [
      {
        "image": "https://dreamstour.dreamstechnologies.com/html/assets/img/destination/destination-01.jpg",
        "title": "Turkey"
      }
    ],
    "Romance": [
      {
        "image": "https://dreamstour.dreamstechnologies.com/html/assets/img/destination/destination-01.jpg",
        "title": "Turkey"
      }
    ],
  };

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.9);
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_pageController.hasClients) {
        if (currentPage < (categoryData[selectedCategory]?.length ?? 0) - 1) {
          currentPage++;
        } else {
          currentPage = 0;
        }
        _pageController.animateToPage(
          currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> selectedData = categoryData[selectedCategory] ?? [];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Quick and easy trip planner",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'poppins',
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Pick a vibe and explore the top destinations",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
              fontFamily: 'poppins',
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = category == selectedCategory;

                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (_) {
                      setState(() {
                        selectedCategory = category;
                        currentPage = 0;
                        _pageController.jumpToPage(0);
                      });
                    },
                    selectedColor: Color(0xFF007BFF),
                    backgroundColor: Colors.white,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontFamily: 'poppins'
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: selectedData.length > 1 && selectedCategory == "All"
                ? PageView.builder(
              controller: _pageController,
              itemCount: selectedData.length - 1,
              itemBuilder: (context, index) {
                final item1 = selectedData[index];
                final item2 = selectedData[index + 1];

                return Row(
                  children: [
                    Expanded(child: _buildImageCard(item1)),
                    const SizedBox(width: 2),
                    Expanded(child: _buildImageCard(item2)),
                  ],
                );
              },
            )
                : PageView.builder(
              controller: _pageController,
              itemCount: (selectedData.length / 2).ceil(),
              itemBuilder: (context, index) {
                final item1 = selectedData[index * 2];
                final item2 = (index * 2 + 1 < selectedData.length) ? selectedData[index * 2 + 1] : null;

                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildImageCard(item1),
                    const SizedBox(width: 8),
                    if (item2 != null) _buildImageCard(item2),
                  ],
                );
              },
            ),

          ),
        ],
      ),
    );
  }

  Widget _buildImageCard(Map<String, String> item) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = (screenWidth - 40) / 2; // 16 padding + 8 spacing + 16 padding

    return Container(
      width: cardWidth,
      height: 200,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: NetworkImage(item['image']!),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Colors.black.withOpacity(0.6),
              Colors.transparent,
            ],
          ),
        ),
        alignment: Alignment.bottomLeft,
        padding: const EdgeInsets.all(12),
        child: Text(
          item['title']!,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'poppins',
          ),
        ),
      ),
    );
  }

}