import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../../constants.dart';

// Your TourSliderCard widget as given
class TourSliderCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String nights;
  final String price;

  const TourSliderCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.nights,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      width: 340,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            Image.network(
              imageUrl,
              height: 220,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
            Positioned(
              right: 15,
              top: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Color(0xff002543),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Text(
                  nights,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(12),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'poppins',
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Divider(thickness: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        _IconWithText(
                          iconUrl:
                          "https://tripoholidays.in/public/images/hotel-icon.png",
                          label: "Hotel",
                        ),
                        _IconWithText(
                          iconUrl:
                          "https://tripoholidays.in/public/images/binoculars-icon.png",
                          label: "Sightseeing",
                        ),
                        _IconWithText(
                          iconUrl:
                          "https://tripoholidays.in/public/images/sedan-icon.png",
                          label: "Transfers",
                        ),
                        _IconWithText(
                          iconUrl:
                          "https://tripoholidays.in/public/images/dinner-icon.png",
                          label: "Meals",
                        ),
                      ],
                    ),
                    const Divider(thickness: 1),
                    const SizedBox(height: 6),
                    Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Starting From:   ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'poppins',
                            ),
                          ),
                          TextSpan(
                            text: '₹$price',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'poppins',
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IconWithText extends StatelessWidget {
  final String iconUrl;
  final String label;

  const _IconWithText({required this.iconUrl, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ImageIcon(
          NetworkImage(iconUrl),
          size: 24,
          color: Colors.black87,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontFamily: 'poppins',
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}

// Auto sliding slider widget using PageView and Timer
class AutoSlidingTourSlider extends StatefulWidget {
  const AutoSlidingTourSlider({super.key});

  @override
  _AutoSlidingTourSliderState createState() => _AutoSlidingTourSliderState();
}

class _AutoSlidingTourSliderState extends State<AutoSlidingTourSlider> {
  final PageController _pageController = PageController(viewportFraction: 0.9);
  int _currentPage = 0;
  Timer? _timer;

  final List<TourSliderCard> _cards = const [
    TourSliderCard(
      imageUrl:
      'https://tripoholidays.in/public/img/media_gallery/Thumbnail%20Image-01_i5PuiUdqQ3.jpg',
      title: 'Glamour of Europe Escape',
      nights: '12 nights',
      price: '282999',
    ),
    TourSliderCard(
      imageUrl:
      'https://tripoholidays.in/public/img/media_gallery/european-enchants_OQToNqjEuq.jpg',
      title: 'European Enchants',
      nights: '11 nights',
      price: '269999',
    ),
    TourSliderCard(
      imageUrl:
      'https://tripoholidays.in/public/img/media_gallery/exortic-europe_BOh6tVH2rC.jpg',
      title: 'Exotic Europe',
      nights: '6 nights',
      price: '142999',
    ),
    TourSliderCard(
      imageUrl:
      'https://tripoholidays.in/public/img/media_gallery/italian-odyssey_vBPVU0IVOs.jpg',
      title: 'Italian Odyssey',
      nights: '6 nights',
      price: '162999',
    ),
    // Add more cards if you want
  ];

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_currentPage < _cards.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 400),
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
    return SizedBox(
      height: 390,
      child: PageView.builder(
        controller: _pageController,
        itemCount: _cards.length,
        itemBuilder: (context, index) {
          return _cards[index];
        },
      ),
    );
  }
}
