import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trip_go/constants.dart';

class LoginBottomSheet extends StatefulWidget {
  const LoginBottomSheet({super.key});

  @override
  State<LoginBottomSheet> createState() => _LoginBottomSheetState();
}

class _LoginBottomSheetState extends State<LoginBottomSheet> {
  final List<Map<String, String>> carouselItems = [
    {
      'title': 'Enjoy Massive Savings',
      'subtitle': 'With Discounted Fare on Flight Bookings',
      'image': 'https://images.emtcontent.com/common/flightpopico1.svg',
      'bgColor': '0xFFE3F2FD',
    },
    {
      'title': 'Check in to Savings',
      'subtitle': 'Book your favourite hotel at cheap price.',
      'image': 'https://images.emtcontent.com/common/hotelpopico.svg',
      'bgColor': '0xFFE8F5E9',
    },
    {
      'title': 'Get Exclusive Bus Deals',
      'subtitle': 'Save more on every bus ride you book.',
      'image': 'https://images.emtcontent.com/common/buspopico.svg',
      'bgColor': '0xFFFFF3E0',
    },
    {
      'title': 'Invite & Earn!',
      'subtitle': 'Invite Friends & Earn Up to ₹2000 in EMT Wallet',
      'image': 'https://images.emtcontent.com/common/invite-earn-icon.svg',
      'bgColor': '0xFFF3E5F5',
    },
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      duration: const Duration(milliseconds: 300),
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Container(
          height: 500,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: CarouselSlider.builder(
                  itemCount: carouselItems.length,
                  itemBuilder: (context, index, _) {
                    final item = carouselItems[index];
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color(int.parse(item['bgColor']!)),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(item['title']!,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Poppins')),
                                  const SizedBox(height: 6),
                                  Text(item['subtitle']!,
                                      style: const TextStyle(
                                          fontSize: 13, fontFamily: 'Poppins')),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: SvgPicture.network(
                              item['image']!,
                              height: 70,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  options: CarouselOptions(
                    height: 140,
                    autoPlay: true,
                    viewportFraction: 1.0,
                    onPageChanged: (index, reason) {
                      setState(() => _currentIndex = index);
                    },
                  ),
                ),
              ),


              Positioned(
                top: 12,
                right: 12,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.close, size: 18, color: Colors.black),
                  ),
                ),
              ),


              Positioned(
                top: 120,
                left: 0,
                right: 0,
                child: Container(
                  height: 380,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 8),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      const Text(
                        'Login or Create an account',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins'),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        style: const TextStyle(fontFamily: 'Poppins'),
                        decoration: InputDecoration(
                          hintText: 'Enter your Email Id/Mobile no.',
                          prefixIcon: const Icon(Icons.email_outlined),
                          hintStyle: const TextStyle(fontFamily: 'Poppins'),
                          focusColor: Colors.red,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            constants.themeColor1,
                            constants.themeColor2
                          ]),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Center(
                          child: Text(
                            'CONTINUE',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),


                      const Divider(),
                      const SizedBox(height: 4),

                      Center(
                        child: Text(
                          'Or Login Via',
                          style: TextStyle(fontFamily: 'Poppins'),
                        ),
                      ),

                      const SizedBox(height: 4),
                      const Divider(),

                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: Colors.grey.shade400),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 10),
                              ),
                              child: Image.network(
                                'https://images.emtcontent.com/mob-web/google-logo.png',
                                height: 24,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: Colors.grey.shade400),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 10),
                              ),
                              child: Image.network(
                                'https://images.emtcontent.com/mob-web/facebook.png',
                                height: 24,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
