import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ImageCarouselSlider extends StatelessWidget {
  final List<String> imgList;

  const ImageCarouselSlider({Key? key, required this.imgList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 180,
        autoPlay: true,
        viewportFraction: 1.0,
        enlargeCenterPage: false,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        enableInfiniteScroll: true,
      ),
      items:
      imgList
          .map(
            (item) => Container(
          margin: EdgeInsets.symmetric(
            horizontal: 4,
          ),
          child: RoundedNetworkImage(imageUrl: item),
        ),
      )
          .toList(),
    );
  }
}

class RoundedNetworkImage extends StatelessWidget {
  final String imageUrl;

  const RoundedNetworkImage({Key? key, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.asset(
        imageUrl,
        fit: BoxFit.cover,
        width:
        MediaQuery.of(context).size.width - 32,
        /*loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return Center(child: CircularProgressIndicator());
        },
        errorBuilder:
            (context, error, stackTrace) =>
                Center(child: Icon(Icons.broken_image, size: 50))*/
      ),
    );
  }
}
