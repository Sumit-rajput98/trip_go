import 'dart:async';
import 'package:flutter/material.dart';
import 'package:trip_go/View/DashboardV/bottom_navigation_bar.dart';
import 'package:trip_go/constants.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';

class TripGoSplash extends StatefulWidget {
  const TripGoSplash({super.key});

  @override
  State<TripGoSplash> createState() => _TripGoSplashState();
}

class _TripGoSplashState extends State<TripGoSplash> with TickerProviderStateMixin {
  final List<String> originalImages = [
    'https://images.unsplash.com/photo-1518684079-3c830dcef090?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://www.travelandleisure.com/thmb/Tl-ao3XY417UTy0X0i1BUhMVKm0=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/TAL-emerald-buddha-lead-image-TODOBANGKOKDOTY25-3248d9150b6f4fe48905023aadcb4439.jpg',
    'https://www.pandotrip.com/wp-content/uploads/2013/08/1D110-Bertrand-Monney.jpg',
    'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/10/a4/4a/26/langkawi-from-above.jpg?w=1200&h=-1&s=1',
    'https://images.contentstack.io/v3/assets/blt06f605a34f1194ff/bltd4e1c33717ea9c21/64e20e43ad2e0876bf02eb12/0_-_BCC-2023-BEST-PLACES-TO-VISIT-IN-ISTANBUL-0.webp?format=webp&quality=60&width=1440',
    'https://images.unsplash.com/photo-1573843981267-be1999ff37cd?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8bWFsZGl2ZXN8ZW58MHx8MHx8fDA%3D',
    'https://invisit.in/images/destination/kashmir/kashmir-thumbnail2.jpg',
    'https://static.toiimg.com/thumb/msid-98540602,width-748,height-499,resizemode=4,imgsize-259152/.jpg',
    'https://rishikeshdaytour.com/blog/wp-content/uploads/2019/03/Rishikesh-Uttarakhand-India.jpg',
    'https://media.istockphoto.com/id/535168027/photo/india-goa-palolem-beach.jpg?s=612x612&w=0&k=20&c=iGV1Ue0Efj87dQirWnUpZVG1dNobUjfVvMGdKHTJ7Qg=',
    'https://imgcld.yatra.com/ytimages/image/upload/v1517480778/AdvNation/ANN_DES95/ann_top_Ladakh_buV00Q.jpg',
    'https://nomadicweekends.com/blog/wp-content/uploads/2019/03/Lachung-City-In-between-the-Mountain-Ranges.jpg',
  ];

  late List<String> gridImages;
  late List<AnimationController> _controllers;
  late List<Animation<Offset>> _offsetAnimations;
  bool navigating = false;
  late ScrollController _scrollController;

  late AnimationController _logoController;
  late Animation<double> _logoAnimation;
  bool _showBurstLogo = false;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();

    // Repeat images if needed
    gridImages = List.generate(18, (i) => originalImages[i % originalImages.length]);

    _controllers = List.generate(
      gridImages.length,
          (i) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 900),
      ),
    );

    _offsetAnimations = List.generate(
      gridImages.length,
          (i) => Tween<Offset>(begin: const Offset(0, 1.5), end: Offset.zero).animate(
        CurvedAnimation(parent: _controllers[i], curve: Curves.easeOutBack),
      ),
    );

    _startAnimations();
  }

  void _startAnimations() async {
    for (int i = 0; i < _controllers.length; i++) {
      await Future.delayed(const Duration(milliseconds: 80));
      _controllers[i].forward();
    }

    // Start auto-scroll
    Future.delayed(const Duration(seconds: 1), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(seconds: 10),
          curve: Curves.linear,
        );
      }
    });

    await Future.delayed(const Duration(seconds: 3)); // adjust as needed
    if (mounted && !navigating) {
      navigating = true;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const BottomNavigationbar()),
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  Widget buildMasonryGrid(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Positioned.fill(
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: size.height * 0.3 , // just above the curve
          // top: size.height * 0.08,
        ),
        child: MasonryGridView.count(
          controller: _scrollController,
          crossAxisCount: 3,
          mainAxisSpacing: 14,
          crossAxisSpacing: 12,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: gridImages.length,
          itemBuilder: (context, idx) {
            final double imgH = (idx % 3 == 0)
                ? size.width / 2.1
                : (idx % 3 == 1)
                    ? size.width / 2.6
                    : size.width / 2.3;
            final double imgW = size.width / 3.6;

            return SlideTransition(
              position: _offsetAnimations[idx],
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.network(
                  gridImages[idx],
                  width: imgW,
                  height: imgH,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          buildMasonryGrid(context),

          // Bottom curved container with logo
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipPath(
              clipper: TopRoundedCurveClipper(),
              child: Container(
                height: size.height * 0.33,
                width: double.infinity,
                color: Color(0xFFF0F2F8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/trip_go.png', height: 60),
                    const SizedBox(height: 12),
                     Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 5),
                       child: Text(
                        'Your Trusted Travel Partner',
                        style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500, color: constants.themeColor1)
                       ),
                     ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// A top-rounded curve (concave down)
class TopRoundedCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0); // Start at top left
    path.quadraticBezierTo(size.width / 2, 40, size.width, 0); // Hill shape
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

