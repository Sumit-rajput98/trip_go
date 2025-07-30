import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/FlightPartSections/daily_deals.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/FlightPartSections/where2_go_section.dart';
import 'package:trip_go/View/DashboardV/HomeWidgets/benifits_section.dart';
import 'package:trip_go/View/DashboardV/HomeWidgets/holiday_cards.dart';
import 'package:trip_go/View/DashboardV/HomeWidgets/top_travel_spot_section.dart';
import 'package:trip_go/View/DashboardV/HomeWidgets/tour_carasoul_section.dart';
import 'package:trip_go/View/DashboardV/HomeWidgets/where2go_section.dart';
import 'package:trip_go/ViewM/Offers/exclusive_offers_view_model.dart';
import 'package:trip_go/constants.dart';
import 'HomeCategoryPages/FlightScreen/flight_routes_view.dart';
import 'HomeWidgets/all_deals_page.dart';
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
  String selectedOffer = 'Flights';

  @override
  void initState() {
    super.initState();

    // Call fetch API here
    Future.microtask(() {
      Provider.of<ExclusiveOffersViewModel>(
        context,
        listen: false,
      ).fetchExclusiveOffers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final exclusiveVM = Provider.of<ExclusiveOffersViewModel>(context);
    print("length is: ${exclusiveVM.offersModel?.data?.length ?? 0}");

    List<String> imgList = [
      "assets/images/mega_offer.jpg",
      "assets/images/mega_offer2.jpg",
      "assets/images/mega_offer4.jpg",
      "assets/images/mega_offer5.jpg",
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
          child: ImageCarouselSlider(imgList: imgList),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: const ReferalScrollWidget(),
        ),

        const SizedBox(height: 30),

        DailyDeals(),

        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Offers for You",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'poppins',
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> OffersPage()));
                },
                child: Row(
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
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                      color: constants.themeColor2,
                    ),
                  ],
                ),
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
            ? exclusiveVM.isLoading
                ? const Center(child: CircularProgressIndicator())
                : OffersCardsWidget(
                  offer: selectedOffer,
                  offersList:
                      selectedOffer == 'All'
                          ? exclusiveVM.offersModel?.data ?? []
                          : exclusiveVM.offersModel?.data
                                  ?.where(
                                    (offer) =>
                                        (offer.offerType ?? '').toLowerCase() ==
                                        selectedOffer.toLowerCase(),
                                  )
                                  .toList() ??
                              [],
                )
                
            : const SizedBox.shrink(),
        SizedBox(height: 20),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 12),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       const Text(
        //         "Best Holiday Packages",
        //         style: TextStyle(
        //           fontSize: 15,
        //           color: Colors.black,
        //           fontWeight: FontWeight.w500,
        //           fontFamily: 'poppins',
        //         ),
        //       ),
        //       Row(
        //         children: [
        //           Text(
        //             "View All",
        //             style: TextStyle(
        //               fontSize: 15,
        //               color: constants.themeColor2,
        //               fontWeight: FontWeight.w500,
        //               fontFamily: 'poppins',
        //             ),
        //           ),
        //           const SizedBox(width: 4),
        //           Icon(
        //             Icons.arrow_forward_ios,
        //             size: 18,
        //             color: constants.themeColor2,
        //           ),
        //         ],
        //       ),
        //     ],
        //   ),
        // ),
        // SizedBox(height: 30),
//HolidaySection(),

        FlightRoutesView(),

SizedBox(height: 30),
TopTravelSpotsSection(),
SizedBox(height: 30),
WhereToGoSection(),
SizedBox(height: 30),
TourCarouselSection(),
SizedBox(height: 30),
BenefitsSection(),
SizedBox(height: 30),


      ],
    );
  }
}
