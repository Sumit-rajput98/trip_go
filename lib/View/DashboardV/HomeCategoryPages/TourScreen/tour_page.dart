import 'package:flutter/material.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/TourScreen/trending_destinations.dart';
import 'TourWidget/top_tour_page_widget.dart';

class TourPage extends StatefulWidget {
  const TourPage({super.key});

  @override
  State<TourPage> createState() => _TourPageState();
}

class _TourPageState extends State<TourPage> {
  List imgList = [
    "https://images.pexels.com/photos/2178175/pexels-photo-2178175.jpeg?auto=compress&cs=tinysrgb&w=600",
    "https://images.pexels.com/photos/2082103/pexels-photo-2082103.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    "https://images.pexels.com/photos/2161449/pexels-photo-2161449.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    "https://images.pexels.com/photos/2161449/pexels-photo-2161449.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
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
            TrendingDestinations()
          ],
        ),
      ),

    );
  }
}

