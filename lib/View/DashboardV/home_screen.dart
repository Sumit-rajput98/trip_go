import 'package:flutter/material.dart';
import 'package:trip_go/View/DashboardV/HomeWidgets/holiday_cards.dart';
import 'package:trip_go/constants.dart';
import 'HomeWidgets/offers_cards_widgets.dart';
import 'HomeWidgets/referal_scroll_widget.dart';
import 'HomeWidgets/special_offers_scroll_widget.dart';
import 'Widget/custom_header_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedOffer = 'Top Offers';

  @override
  Widget build(BuildContext context) {
    List<String> imgList = [
      "assets/images/mega_offer.jpg",
      "assets/images/mega_offer2.jpg",
      "assets/images/mega_offer4.jpg",
      "assets/images/mega_offer5.jpg"
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0,12,0,12),
          child: ImageCarouselSlider(imgList: imgList),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: const ReferalScrollWidget(),
        ),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Special Offers.",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'poppins',
                ),
              ),
              Row(
                children: [
                  Text(
                    "View All",
                    style: TextStyle(
                      fontSize: 15,
                      color: constants.themeColor2,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'poppins',
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(Icons.arrow_forward_ios, size: 18, color: constants.themeColor2),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SpecialOffersScrollWidget(
            selectedOffer: selectedOffer, // Pass the current selected offer
            onOfferTapped: (offer) {
              setState(() {
                selectedOffer = offer; // Update the selected offer
              });
            },
          ),
        ),
        const SizedBox(height: 30),
        selectedOffer.isNotEmpty
            ? OffersCardsWidget(offer: selectedOffer)
            : const SizedBox.shrink(),
        SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Best Holiday Packages",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'poppins',
                ),
              ),
              Row(
                children: [
                  Text(
                    "View All",
                    style: TextStyle(
                      fontSize: 15,
                      color: constants.themeColor2,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'poppins',
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(Icons.arrow_forward_ios, size: 18, color: constants.themeColor2),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 30,),
        HolidaySection(),
        SizedBox(height: 30,),
      ],
    );
  }
}
