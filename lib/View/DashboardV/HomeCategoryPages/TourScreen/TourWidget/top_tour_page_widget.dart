import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class TopTourPageWidget extends StatelessWidget {
  const TopTourPageWidget({
    super.key,
    required this.size,
    required this.imgList,
  });

  final Size size;
  final List imgList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.5,
      width: double.infinity,
      child: Stack(
        children: [
          CarouselSlider(
            items: imgList
                .map(
                  (item) => SizedBox(
                width: double.infinity,
                child: Image.network(
                  item,
                  fit: BoxFit.cover,
                ),
              ),
            )
                .toList(),
            options: CarouselOptions(
              viewportFraction: 1.0,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 4),
              height: size.height * 0.5,
              enableInfiniteScroll: true,
            ),
          ),

          // Optional dark overlay
          Container(
            width: double.infinity,
            height: size.height * 0.5,
            color: Colors.black.withOpacity(0.3),
          ),

          // Centered Text
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Explore Our",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 42,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Tour Package",
                  style: GoogleFonts.poppins(
                    fontSize: 42,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          // Search Bar Positioned near bottom
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Container(
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search Destinations",
                        border: InputBorder.none,
                        hintStyle: GoogleFonts.poppins(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Icon(
                    Icons.search,
                    color: Colors.grey[700],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

    );
  }
}
