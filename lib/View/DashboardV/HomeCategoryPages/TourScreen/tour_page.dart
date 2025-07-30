import 'package:flutter/material.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/TourScreen/trending_destinations.dart';
import 'TourWidget/enquire_button.dart';
import 'TourWidget/top_tour_page_widget.dart';

class TourPage extends StatefulWidget {
  const TourPage({super.key});

  @override
  State<TourPage> createState() => _TourPageState();
}

class _TourPageState extends State<TourPage> {
  List imgList = [
    "https://www.tripgoonline.com/Images/tour/australia-banner-home.webp",
    "https://www.tripgoonline.com/Images/tour/kerala_newbb.png",
    "https://www.tripgoonline.com/Images/tour/kashmir-banner-home.webp",
    "https://www.tripgoonline.com/Images/tour/dubai_newbb.png",
  ];
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (String img in imgList) {
        precacheImage(NetworkImage(img), context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            TopTourPageWidget(size: size, imgList: imgList),
            TrendingDestinations(),
            SizedBox(height: 20,),
          ],
        ),
      ),
      floatingActionButton: AnimatedEnquireButton(),
    );
  }
}

