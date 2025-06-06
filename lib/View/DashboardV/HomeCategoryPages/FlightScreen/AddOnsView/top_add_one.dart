import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/AddOnsView/baggage_selection_page.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/AddOnsView/meals_addon.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/AddOnsView/popular_add_ons.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/AddOnsView/seat_selection_page.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/AddOnsView/seat_selection_page_RT.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/FlightReviewScreen/traveller_details.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/common_widget/bottom_bar.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/flight_ticket_book.dart';
import 'package:trip_go/constants.dart';
import 'package:trip_go/Model/FlightM/flight_SSR_model_lcc.dart';
import '../../../../../Model/FlightM/add_traveller_model.dart';
import '../../../../../ViewM/FlightVM/selected_seats_provider.dart';
import '../non_lcc_ticket_book.dart';

class AddOnsPage extends StatefulWidget {
  Map<String, dynamic>? fare;
  final Data? flightSsrLccRes;
  final String email;
  final int? adultCount;
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
  AddOnsPage({super.key,required this.email, this.flightSsrLccRes, this.adultCount, this.flightSsrLccRes1, this.flightSsrLccRes2, this.rt,  this.price, this.fare, this.traceId, this.resultIndex, required this.travellers,
    required this.isLcc,
    this.companyName,
    this.regNo,
  });

  @override
  State<AddOnsPage> createState() => _AddOnsPageState();
}

class _AddOnsPageState extends State<AddOnsPage> with TickerProviderStateMixin {
  late TabController _tabController;

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
                widget.rt!?
                SeatSelectionPageRT(flightSsrRes1: widget.flightSsrLccRes1,flightSsrRes2: widget.flightSsrLccRes2,adultCount: 2,)
                :SeatSelectionPage(flightSsrRes: widget.flightSsrLccRes!,adultCount:widget.adultCount),
                widget.rt!?
                BaggageTabView(flightSsrRes: widget.flightSsrLccRes1!):
                BaggageTabView(flightSsrRes: widget.flightSsrLccRes!),
                widget.rt!?
                MealsAddOnsPage(flightSsrRes: widget.flightSsrLccRes2):
                MealsAddOnsPage(flightSsrRes: widget.flightSsrLccRes)
                /*BaggageTabView(flightSsrRes: widget.flightSsrLccRes!),
                */
                /*PopularAddOnsSection()*/
              ],
            ),
          ),
        ],
      ),
      bottomSheet: Consumer<SeatSelectionProvider>(
        builder: (context, seatProvider, _) {
          final selectedSeats = seatProvider.selectedSeats;
          final paymentPrice = widget.price! + seatProvider.totalPrice.toInt();

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

          final seatDynamicData = {
            "SeatDynamic": seatDynamicList,
          };

          print("Current seat data: ${jsonEncode(seatDynamicData)}");

          return buildBottomBar(context, () {
            if (widget.isLcc) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FlightTicketBook(
                    companyName: widget.companyName, // ← pass company name
                    regNo: widget.regNo,
                    email: widget.email,
                    paymentPrice: paymentPrice,
                    fare: widget.fare,
                    resultIndex: widget.resultIndex,
                    traceId: widget.traceId,
                    travellers: widget.travellers,
                    seatDynamicData: seatDynamicData,
                  ),
                ),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NonLccFlightTicketBook(
                    email: widget.email,
                    paymentPrice: paymentPrice,
                    fare: widget.fare,
                    resultIndex: widget.resultIndex,
                    traceId: widget.traceId,
                    travellers: widget.travellers,
                    seatDynamicData: seatDynamicData,
                  ),
                ),
              );
            }
          }, price: widget.price! + seatProvider.totalPrice.toInt(),);
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
