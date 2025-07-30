import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/AddOnsView/baggage_selection_page.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/AddOnsView/meals_addon.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/AddOnsView/seat_selection_page.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/common_widget/bottom_bar.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/flight_ticket_book.dart';
import 'package:trip_go/constants.dart';
import 'package:trip_go/Model/FlightM/flight_SSR_model_lcc.dart';
import '../../../../../Model/FlightM/add_traveller_model.dart';
import '../../../../../ViewM/FlightVM/baggage_selection_provider.dart';
import '../../../../../ViewM/FlightVM/meal_provider.dart';
import '../../../../../ViewM/FlightVM/selected_seats_provider.dart';
import '../non_lcc_ticket_book.dart';

class InternationalAddOnsPage extends StatefulWidget {
  Map<String, dynamic>? fare;
  final bool? isInternational;
  final Data? flightSsrLccRes;
  final String email;
  final String phone;
  final int? adultCount;
  final int? childrenCount;
  final int? infantCount;
  final Data? flightSsrLccRes1;
  final Data? flightSsrLccRes2;
  final bool? rt;
  final int? price;
  String? traceId;
  String? resultIndex;
  final bool isLcc;
  final String? companyName;
  final String? regNo;
  final List<Traveller> travellers;

  InternationalAddOnsPage({
    super.key, this.isInternational, required this.email, this.flightSsrLccRes, this.adultCount, this.flightSsrLccRes1, this.flightSsrLccRes2, this.rt,  this.price, this.fare, this.traceId, this.resultIndex, required this.travellers,
    required this.isLcc,
    this.companyName,
    this.childrenCount,
    this.infantCount,
    this.regNo, required this.phone,
  });

  @override
  State<InternationalAddOnsPage> createState() => _InternationalAddOnsPageState();
}

class _InternationalAddOnsPageState extends State<InternationalAddOnsPage> with TickerProviderStateMixin {
  late TabController _directionTabController;
  late TabController _addonTabController;

  double mealTotalPrice = 0.0;
  double baggageTotalPrice = 0.0;

  final List<Tab> _addonTabs = const [
    Tab(text: "SEATS"),
    Tab(text: "BAGGAGE"),
    Tab(text: "MEALS"),
  ];

  @override
  void initState() {
    super.initState();
    _directionTabController = TabController(length: 2, vsync: this); // Onward + Return
    _addonTabController = TabController(length: _addonTabs.length, vsync: this);
  }

  @override
  void dispose() {
    _directionTabController.dispose();
    _addonTabController.dispose();
    super.dispose();
  }

  Widget _buildAddOnTabs(Data? flightSsrRes) {
    if (flightSsrRes == null) {
      return const Center(child: Text("No Add-on Data Available"));
    }

    return Column(
      children: [
        TabBar(
          controller: _addonTabController,
          tabs: _addonTabs,
          indicatorColor: Colors.blue,
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.black54,
        ),
        Expanded(
          child: TabBarView(
            controller: _addonTabController,
            children: [
              SeatSelectionPage(
                flightSsrRes: flightSsrRes!,
                adultCount: widget.adultCount,
                childrenCount: widget.childrenCount,
                infantCount: widget.infantCount,
              ),
              BaggageTabView(
                flightSsrRes: flightSsrRes,
                onBaggagePriceChanged: (price) {
                  setState(() => baggageTotalPrice = price);
                },
              ),
              MealsAddOnsPage(
                flightSsrRes: flightSsrRes,
                onMealPriceChange: (price) {
                  setState(() => mealTotalPrice = price);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Top section - fixed
          Container(
            padding: const EdgeInsets.fromLTRB(16, 40, 16, 12),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // First row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(onTap:()=>Navigator.pop(context),child: const Icon(Icons.arrow_back, color: Colors.black87)),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Add ons",
                              textAlign: TextAlign.start,
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 4,),
                            Text(
                              "${widget.adultCount.toString()} Adult | ${widget.childrenCount.toString()} Children" ,
                              textAlign: TextAlign.start,
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      "Skip to Payment",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: constants.themeColor1,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(thickness: 1,color: Colors.black,),
          TabBar(
            controller: _directionTabController,
            indicatorColor: Colors.blue,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black,
            labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            indicator: BoxDecoration(
              color: const Color(0xFF1B499F),
              borderRadius: BorderRadius.circular(8),
            ),
            tabs: const [
              Tab(icon: Icon(Icons.flight_takeoff), text: "Onward"),
              Tab(icon: Icon(Icons.flight_land), text: "Return"),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _directionTabController,
              children: [
                _buildAddOnTabs(widget.flightSsrLccRes1),
                _buildAddOnTabs(widget.flightSsrLccRes2),
              ],
            ),
          ),
        ],
      ),
      bottomSheet: Consumer3<SeatSelectionProvider, BaggageSelectionProvider, MealProvider>(
        builder: (context, seatProvider, baggageProvider, mealProvider, _) {
          final totalPrice = (widget.price ?? 0) +
              seatProvider.totalPrice.toInt() +
              baggageProvider.totalBaggagePrice.toInt() +
              mealProvider.totalMealPrice.toInt();

          final seatDynamicList = seatProvider.selectedSeats.map((seat) => seat.toJson()).toList();
          final baggageDynamicList = baggageProvider.selectedBaggage.map((bag) => bag.toJson()).toList();
          final mealDynamicList = {"MealDynamic": [mealProvider.selectedMeals]};

          return buildBottomBar(context, () {
            // Navigate to booking screen
            Navigator.push(context, MaterialPageRoute(builder: (_) => NonLccFlightTicketBook(
              isLcc: widget.isLcc,
              isInternational: true,
              companyName: widget.companyName,
              regNo: widget.regNo,
              email: widget.email,
              phone: widget.phone,
              paymentPrice: totalPrice,
              fare: widget.fare,
              resultIndex: widget.resultIndex,
              traceId: widget.traceId,
              travellers: widget.travellers,
              seatDynamicData: {"SeatDynamic": seatDynamicList},
              baggageDynamicData: {"BaggageDynamic": baggageDynamicList},
              mealDynamicData: mealDynamicList,
            )));
          }, price: totalPrice);
        },
      ),
    );
  }
}