import 'package:flutter/material.dart';

class CustomCarousel extends StatefulWidget {
  const CustomCarousel({super.key});

  @override
  _CustomCarouselState createState() => _CustomCarouselState();
}

class _CustomCarouselState extends State<CustomCarousel> {
  final PageController _pageController = PageController(viewportFraction: 0.9);
  int _currentIndex = 0;

  final List<String> images = [
    "https://images.emtcontent.com/holiday-img/home-img/mob-mp-tours-packages.webp",
    "https://images.emtcontent.com/holiday-img/home-img/abudhabi-banner-desk.webp",
    "https://images.emtcontent.com/holiday-img/home-img/kenya-holbnr.webp",
  ];

  void scrollLeft() {
    if (_currentIndex > 0) {
      _pageController.jumpToPage(_currentIndex - 1);
    }
  }

  void scrollRight() {
    if (_currentIndex < images.length - 1) {
      _pageController.jumpToPage(_currentIndex + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 140,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemCount: images.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    images[index],
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 100,
                    fit: BoxFit.fill
                  ),
                ),
              );
            },
          ),
        ),
        // Left Arrow
        Positioned(
          left: 10,
          top: 45,
          child: CircleAvatar(
            backgroundColor: Colors.black.withOpacity(0.5), // Semi-transparent background
            radius: 20,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios, size: 18, ),
              onPressed: scrollLeft,
              color: Colors.white,
              splashRadius: 24,
            ),
          ),
        ),
        // Right Arrow
        Positioned(
          right: 10,
          top: 45,
          child: CircleAvatar(
            backgroundColor: Colors.black.withOpacity(0.5),
            radius: 20,
            child: IconButton(
              icon: const Icon(Icons.arrow_forward_ios, size: 18),
              onPressed: scrollRight,
              color: Colors.white,
              splashRadius: 24,
            ),
          ),
        ),
      ],
    );
  }
}
