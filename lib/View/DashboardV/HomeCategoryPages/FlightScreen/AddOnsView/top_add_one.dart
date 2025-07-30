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

class AddOnsPage extends StatefulWidget {
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
  AddOnsPage({
    super.key, this.isInternational, required this.email, this.flightSsrLccRes, this.adultCount, this.flightSsrLccRes1, this.flightSsrLccRes2, this.rt,  this.price, this.fare, this.traceId, this.resultIndex, required this.travellers,
    required this.isLcc,
    this.childrenCount,
    this.infantCount,
    this.companyName,
    this.regNo, required this.phone,
  });

  @override
  State<AddOnsPage> createState() => _AddOnsPageState();
}

class _AddOnsPageState extends State<AddOnsPage> with TickerProviderStateMixin {
  late TabController _tabController;
  double mealTotalPrice = 0.0;
  double baggageTotalPrice = 0.0;
  ValueNotifier<int> baggagePriceNotifier = ValueNotifier<int>(0);

  final List<Tab> _tabs = const [
    Tab(text: "SEATS"),
    Tab(text: "BAGGAGE"),
    Tab(text: "MEALS",)
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("isInternational : ${widget.isInternational}");
    final seatProvider = Provider.of<SeatSelectionProvider>(context, listen: false);
    final selectedSeats = seatProvider.selectedSeats;
    return SafeArea(
      top: false,
      child: Scaffold(
          backgroundColor: Colors.white,
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
              // Tabs
              Container(
                color: Colors.white,
                child: TabBar(
                  controller: _tabController,
                  tabs: _tabs,
                  indicatorColor: constants.themeColor2,
                  indicatorWeight: 2.5,
                  labelColor: constants.themeColor1,
                  unselectedLabelColor: Colors.black54,
                  labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                  unselectedLabelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w400),
                  // Remove labelPadding and isScrollable for equal distribution
                  isScrollable: false, // Changed from true to false
                  indicatorPadding: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  // Add this for equal width distribution
                  indicatorSize: TabBarIndicatorSize.tab,
                ),
              ),

              // Tab Views
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    SeatSelectionPage(flightSsrRes: widget.flightSsrLccRes!,adultCount:widget.adultCount, childrenCount: widget.childrenCount, infantCount: widget.infantCount,),
                    BaggageTabView(flightSsrRes: widget.flightSsrLccRes!,onBaggagePriceChanged: (price) {
                      setState(() {
                        baggageTotalPrice = price;
                      });
                    },),
                    MealsAddOnsPage(flightSsrRes: widget.flightSsrLccRes,onMealPriceChange: (price) {
                      setState(() {
                        mealTotalPrice = price;
                      });
                    },),
                    /*BaggageTabView(flightSsrRes: widget.flightSsrLccRes!),
                  */
                    /*PopularAddOnsSection()*/
                  ],
                ),
              ),
            ],
          ),
          bottomSheet: Consumer3<SeatSelectionProvider, BaggageSelectionProvider, MealProvider>(
            builder: (context, seatProvider, baggageProvider, mealProvider, _) {

              final mealDynamicList = mealProvider.selectedMeals;

              final totalPrice = widget.price! +
                  seatProvider.totalPrice.toInt() +
                  baggageProvider.totalBaggagePrice.toInt() +
                  mealProvider.totalMealPrice.toInt();

              final selectedSeats = seatProvider.selectedSeats;
              final selectedBaggage = baggageProvider.selectedBaggage;

              final paymentPrice = widget.price! + seatProvider.totalPrice.toInt();

              final mealDynamicData = {
                "MealDynamic": [mealDynamicList],
              };

              final seatDynamicList = selectedSeats.map((seat) => {
                "AirlineCode": seat.airlineCode,
                "FlightNumber": seat.flightNumber,
                "CraftType": seat.craftType,
                "Origin": seat.origin,
                "Destination": seat.destination,
                "AvailablityType": seat.availablityType,
                "Description": seat.description,
                "Code": seat.code,
                "RowNo": seat.rowNo,
                "SeatNo": seat.seatNo,
                "SeatType": seat.seatType,
                "SeatWayType": seat.seatWayType,
                "Compartment": seat.compartment,
                "Deck": seat.deck,
                "Currency": seat.currency,
                "Price": seat.price,
              }).toList();

              final baggageDynamicList = selectedBaggage.map((baggage) => {
                "AirlineCode": baggage.airlineCode,
                "FlightNumber": baggage.flightNumber,
                "WayType": baggage.wayType,
                "Code": baggage.code,
                "Description": baggage.description,
                "Weight": baggage.weight,
                "Currency": baggage.currency,
                "Price": baggage.price,
                "Origin": baggage.origin,
                "Destination": baggage.destination,
              }).toList();

              return
                buildBottomBar(context, () {
                  final nextScreen =
                  // widget.isLcc
                  //     ? FlightTicketBook(
                  //   isInternational: widget.isInternational,
                  //   companyName: widget.companyName,
                  //   isLcc: widget.isLcc,
                  //   regNo: widget.regNo,
                  //   email: widget.email,
                  //   phone:widget.phone,
                  //   paymentPrice: paymentPrice,
                  //   fare: widget.fare,
                  //   resultIndex: widget.resultIndex,
                  //   traceId: widget.traceId,
                  //   travellers: widget.travellers,
                  //   seatDynamicData: {
                  //     "SeatDynamic": seatDynamicList,
                  //   },
                  //   baggageDynamicData: {
                  //     "BaggageDynamic": baggageDynamicList,
                  //   },
                  //   mealDynamicData: mealDynamicData,
                  // )
                  //     :
                  NonLccFlightTicketBook(
                    isLcc: widget.isLcc,
                    isInternational: widget.isInternational,
                    companyName: widget.companyName,
                    regNo: widget.regNo,
                    email: widget.email,
                    phone:widget.phone,
                    paymentPrice: paymentPrice,
                    fare: widget.fare,
                    resultIndex: widget.resultIndex,
                    traceId: widget.traceId,
                    travellers: widget.travellers,
                    seatDynamicData: {
                      "SeatDynamic": seatDynamicList,
                    },
                    baggageDynamicData: {
                      "BaggageDynamic": baggageDynamicList,
                    },
                    mealDynamicData: mealDynamicData,
                  );

                  Navigator.push(context, MaterialPageRoute(builder: (_) => nextScreen));
                }, price: totalPrice);
            },
          )
      ),
    );
  }
}
class UpiPage extends StatelessWidget {
  const UpiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("UPI PAGE")),
    );
  }
}