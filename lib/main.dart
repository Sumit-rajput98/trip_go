import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/FlightWidgets/multi_city_flight_list_screen.dart';
import 'package:trip_go/View/DashboardV/bottom_navigation_bar.dart';
import 'package:trip_go/View/DashboardV/dashboard_screen.dart';
import 'package:trip_go/ViewM/FlightVM/fare_rules_view_model.dart';
import 'package:trip_go/ViewM/FlightVM/flight_quote_view_model.dart';
import 'package:trip_go/ViewM/FlightVM/flight_search_view_model.dart';
import 'package:trip_go/ViewM/FlightVM/flight_ssr_lcc_view_model.dart';
import 'View/DashboardV/HomeCategoryPages/FlightScreen/FlightReviewScreen/promo_section/promo_provider.dart';
import 'ViewM/FlightVM/flight_ticket_lcc_view_model.dart';
import 'ViewM/FlightVM/round_trip_flight_search_view_model.dart';
import 'ViewM/FlightVM/seat_selection_provider_round.dart';
import 'ViewM/FlightVM/select_city_view_model.dart';
import 'ViewM/FlightVM/selected_seats_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SeatSelectionProvider()),
        ChangeNotifierProvider(create: (_) => SeatSelectionProviderRound()),
        ChangeNotifierProvider(create: (_) => PromoProvider()),
        ChangeNotifierProvider(create: (_) => FlightSearchViewModel()),
        ChangeNotifierProvider(create: (_) => SelectCityViewModel()),
        ChangeNotifierProvider(create: (_) => FlightQuoteViewModel()),
        ChangeNotifierProvider(create: (_) => RoundTripFlightSearchViewModel()),
        ChangeNotifierProvider(create: (_) => FareRulesViewModel()),
        ChangeNotifierProvider(create: (_) => FlightSsrLccViewModel()),
        ChangeNotifierProvider(create: (_) => FlightTicketLccViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home:BottomNavigationbar()
    );
  }
}

