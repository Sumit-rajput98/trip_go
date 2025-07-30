import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/AddOnsView/baggage_selection_page.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/AddOnsView/baggage_selection_page_RT.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/AddOnsView/meals_addon.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/AddOnsView/popular_add_ons.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/AddOnsView/seat_selection_page.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/AddOnsView/seat_selection_page_RT.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/FlightReviewScreen/traveller_details.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/common_widget/bottom_bar.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/flight_ticket_book_round.dart';
import 'package:trip_go/ViewM/FlightVM/meal_selection_round_provider.dart';
import 'package:trip_go/constants.dart';
import '../../../../../Model/FlightM/add_traveller_model.dart';
import '../../../../../Model/FlightM/flight_SSR_round_model.dart';
import '../../../../../ViewM/FlightVM/baggage_selection_round_provider.dart';
import '../../../../../ViewM/FlightVM/seat_selection_provider_round.dart';
import '../../../../../ViewM/FlightVM/selected_seats_provider.dart';
import '../flight_direct_ticket_book_round.dart';
import '../non_lcc_ticket_book.dart';
import 'baggage_selection_round_page.dart';
import 'meal_addon_round.dart';
import 'meal_selection_page_rt.dart';

class AddOnsPageRound extends StatefulWidget {
  Map<String, dynamic>? fare;
  Map<String, dynamic>? fare2;
  final Data1? flightSsrLccRes;
  final int adultCount;
  final int? childrenCount;
  final int? infantsCount;
  final Data1? flightSsrLccRes1;
  final Data1? flightSsrLccRes2;
  final String selectedOnwardResultIndex;
  final String selectedReturnResultIndex;
  final bool? rt;
  final int? price;
  final String email;
  final String phone;
  String? traceId;
  String? resultIndex;
  final bool isLcc;
  final bool isLccIb;
  final List<Traveller> travellers;
  final String? companyName;
  final String? regNo;

  AddOnsPageRound({super.key,
    required this.isLcc,
    required this.isLccIb,
    this.flightSsrLccRes,
    required this.adultCount,
    this.childrenCount,
    this.infantsCount,
    required this.selectedOnwardResultIndex, // ✅
    required this.selectedReturnResultIndex, // ✅
    this.flightSsrLccRes1, this.flightSsrLccRes2, this.rt,  this.price, this.fare, this.fare2, this.traceId, this.resultIndex,required this.email,required this.phone, required this.travellers,this.companyName,
    this.regNo, });

  @override
  State<AddOnsPageRound> createState() => _AddOnsPageRoundState();
}

class _AddOnsPageRoundState extends State<AddOnsPageRound> with TickerProviderStateMixin {
  late TabController _tabController;

  final List<Tab> _tabs = const [
    Tab(text: "SEATS"),
    Tab(text: "BAGGAGE"),
    Tab(text: "MEALS",)
  ];

  @override
  void initState() {
    super.initState();
    print("### - ${widget.selectedOnwardResultIndex}");
    print(widget.selectedReturnResultIndex);
    _tabController = TabController(length: _tabs.length, vsync: this);
    print("fare2 : ${widget.fare2}");
    print("baggage-${widget.flightSsrLccRes?.baggage}");
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final seatProvider = Provider.of<SeatSelectionProvider>(context, listen: false);
    final selectedSeats = seatProvider.selectedSeats;
    return Scaffold(
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
                              "${widget.adultCount.toString()} Adult" ,
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
                SeatSelectionPageRT(flightSsrRes1: widget.flightSsrLccRes1,flightSsrRes2: widget.flightSsrLccRes2,adultCount: widget.adultCount,childrenCount: widget.childrenCount, infantsCount: widget.infantsCount,),
                BaggageSelectionPageRT(flightSsrRes1: widget.flightSsrLccRes1,flightSsrRes2: widget.flightSsrLccRes2,adultCount: widget.adultCount,),
                MealSelectionPageRT(flightSsrRes1: widget.flightSsrLccRes1, flightSsrRes2: widget.flightSsrLccRes2,adultCount: widget.adultCount
                ),
                /*BaggageTabView(flightSsrRes: widget.flightSsrLccRes!),
                */
                /*PopularAddOnsSection()*/
              ],
            ),
          ),
        ],
      ),
      bottomSheet: Consumer3<SeatSelectionProviderRound, BaggageSelectionRoundProvider, MealSelectionRoundProvider>(
        builder: (context, seatProvider, baggageProvider, mealProvider, _) {
          final selectedSeats = seatProvider.selectedSeats;
          final totalSeatPrice = seatProvider.totalPrice.toInt();
          final totalBaggagePrice = baggageProvider.totalBaggagePrice.toInt();
          final totalMealPrice = mealProvider.totalMealPrice.toInt();
          final paymentPrice = widget.price! + totalSeatPrice + totalBaggagePrice + totalMealPrice;

          final seatDynamicData = {
            "SeatDynamic": seatProvider.onwardSeats.map((seat) => {
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
            }).toList(),
            "SeatDynamicIB": seatProvider.returnSeats.map((seat) => {
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
            }).toList(),
          };

          final baggageDynamicData = {
            "BaggageDynamic": baggageProvider.onwardBaggage.map((baggage) => {
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
            }).toList(),
            "BaggageDynamicIB": baggageProvider.returnBaggage.map((baggage) => {
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
            }).toList(),
          };

          final mealDynamicData = {
            "MealDynamic": mealProvider.onwardMeals.map((meal) => {
              "AirlineCode": meal.airlineCode,
              "FlightNumber": meal.flightNumber,
              "WayType": 1,
              "Code": meal.code,
              "Description": meal.description,
              "AirlineDescription": meal.airlineDescription,
              "Quantity": 1,
              "Currency": meal.currency,
              "Price": meal.price,
              "Origin": meal.origin,
              "Destination": meal.destination,
            }).toList(),
            "MealDynamicIB": mealProvider.returnMeals.map((meal) => {
              "AirlineCode": meal.airlineCode,
              "FlightNumber": meal.flightNumber,
              "WayType": 2,
              "Code": meal.code,
              "Description": meal.description,
              "AirlineDescription": meal.airlineDescription,
              "Quantity": 1,
              "Currency": meal.currency,
              "Price": meal.price,
              "Origin": meal.origin,
              "Destination": meal.destination,
            }).toList(),
          };

          print('SEATS PASSED TO NEXT SCREEN:\n${jsonEncode(seatDynamicData)}');
          print('BAGGAGE PASSED TO NEXT SCREEN:\n${jsonEncode(baggageDynamicData)}');
          print('MEALS PASSED TO NEXT SCREEN:\n${jsonEncode(mealDynamicData)}');

          return buildBottomBar(context, () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FlightDirectTicketBookRound(
                  isLccIb: widget.isLccIb,
                  isLcc: widget.isLcc,
                  email: widget.email,
                  phone : widget.phone,
                  paymentPrice: paymentPrice,
                  fare: widget.fare,
                  fare2: widget.fare2,
                  resultIndex: widget.resultIndex,
                  traceId: widget.traceId,
                  travellers: widget.travellers,
                  seatDynamicData: seatDynamicData,
                  baggageDynamicData: baggageDynamicData,
                  mealDynamicData: mealDynamicData, // <-- Add this
                  selectedOnwardResultIndex: widget.selectedOnwardResultIndex,
                  selectedReturnResultIndex: widget.selectedReturnResultIndex,
                  companyName: widget.companyName,
                  regNo: widget.regNo,
                ),
              ),
            );

            // }
          }, price: paymentPrice);
        },
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
