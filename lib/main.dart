import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:trip_go/AppManager/Api/api_service/TourService/indian_destination_view_model.dart';
import 'package:trip_go/Model/AccountM/forgot_password_model.dart';
import 'package:trip_go/Splash/logo_intro_screen.dart';
import 'package:trip_go/Splash/splash_screen.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/BusScreen/AddOn/chart_tab.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/CabScreen/pages/cab_create_order_view_model.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/HotelScreen/hotel_promo_section.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/profile/auth_provider.dart';
import 'package:trip_go/View/DashboardV/bottom_navigation_bar.dart';
import 'package:trip_go/ViewM/AccountVM/change_password_view_model.dart';
import 'package:trip_go/ViewM/AccountVM/edit_profile_view_model.dart';
import 'package:trip_go/ViewM/AccountVM/forgot_password_view_model.dart';
import 'package:trip_go/ViewM/AccountVM/login_otp_view_model.dart';
import 'package:trip_go/ViewM/AccountVM/login_view_model.dart';
import 'package:trip_go/ViewM/AccountVM/register_view_model.dart';
import 'package:trip_go/ViewM/AccountVM/user_booking_view_model.dart';
import 'package:trip_go/ViewM/AccountVM/user_view_model.dart';
import 'package:trip_go/ViewM/AccountVM/validate_otp_view_model.dart';
import 'package:trip_go/ViewM/BusVM/bus_block_view_model.dart';
import 'package:trip_go/ViewM/BusVM/bus_booking_details_view_model.dart';
import 'package:trip_go/ViewM/BusVM/bus_cancel_view_model.dart';
import 'package:trip_go/ViewM/BusVM/bus_city_view_model.dart';
import 'package:trip_go/ViewM/BusVM/bus_order_view_model.dart';
import 'package:trip_go/ViewM/BusVM/bus_search_view_model.dart';
import 'package:trip_go/ViewM/BusVM/bus_traveller_provider.dart';
import 'package:trip_go/ViewM/CabVM/cab_book_view_model.dart';
import 'package:trip_go/ViewM/CabVM/cab_booking_details_view_model.dart';
import 'package:trip_go/ViewM/CabVM/cab_verify_payment_view_model.dart';
import 'package:trip_go/ViewM/FlightVM/create_order_view_model..dart';
import 'package:trip_go/ViewM/FlightVM/fare_rules_view_model.dart';
import 'package:trip_go/ViewM/FlightVM/flight_quote_view_model.dart';
import 'package:trip_go/ViewM/FlightVM/flight_search_view_model.dart';
import 'package:trip_go/ViewM/FlightVM/flight_ssr_lcc_view_model.dart';
import 'package:trip_go/ViewM/FlightVM/meal_selection_round_provider.dart';
import 'package:trip_go/ViewM/FlightVM/upsell_view_model.dart';
import 'package:trip_go/ViewM/HotelVM/hotel_book_view_model.dart';
import 'package:trip_go/ViewM/HotelVM/hotel_booking_details_view_model.dart';
import 'package:trip_go/ViewM/HotelVM/hotel_booking_view_model.dart';
import 'package:trip_go/ViewM/HotelVM/hotel_city_search_view_model.dart';
import 'package:trip_go/ViewM/HotelVM/hotel_search_view_model.dart';
import 'package:trip_go/ViewM/Offers/exclusive_offers_view_model.dart';
import 'package:trip_go/ViewM/TourVM/trending_packages_view_model.dart';
import 'View/DashboardV/HomeCategoryPages/BusScreen/BusScreen/bus_seat_provider.dart';
import 'View/DashboardV/HomeCategoryPages/FlightScreen/FlightReviewScreen/promo_section/promo_provider.dart';
import 'ViewM/BusVM/bus_boarding_view_model.dart';
import 'ViewM/BusVM/bus_book_view_model.dart';
import 'ViewM/BusVM/bus_verify_payment_view_model.dart';
import 'ViewM/CabVM/cab_search_view_model.dart';
import 'ViewM/FlightVM/baggage_selection_provider.dart';
import 'ViewM/FlightVM/baggage_selection_round_provider.dart';
import 'ViewM/FlightVM/flight_quote_round_view_model.dart';
import 'ViewM/FlightVM/flight_ssr_lcc_round_view_model.dart';
import 'ViewM/FlightVM/flight_ticket_lcc_view_model.dart';
import 'ViewM/FlightVM/meal_provider.dart';
import 'ViewM/FlightVM/round_trip_flight_search_view_model.dart';
import 'ViewM/FlightVM/seat_selection_provider_round.dart';
import 'ViewM/FlightVM/select_city_view_model.dart';
import 'ViewM/FlightVM/selected_seats_provider.dart';
import 'ViewM/HotelVM/hotel_detail_view_model.dart';
import 'ViewM/TourVM/category_view_model.dart';
import 'ViewM/TourVM/destinantion_view_model.dart';
import 'ViewM/TourVM/holiday_themes_view_model.dart';
import 'ViewM/TourVM/international_destination_view_model.dart';
import 'ViewM/TourVM/quick_enquiry_view_model.dart';
import 'ViewM/TourVM/subcategory_view_model.dart';

void main() {
 
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SeatSelectionProvider()),
        ChangeNotifierProvider(create: (_) => SeatSelectionProviderRound()),
        ChangeNotifierProvider(create: (_) => BaggageSelectionProvider()),
        ChangeNotifierProvider(create: (_) => MealProvider()),
        ChangeNotifierProvider(create: (_) => MealSelectionRoundProvider()),
        ChangeNotifierProvider(create: (_) => BaggageSelectionRoundProvider()),
        ChangeNotifierProvider(create: (_) => PromoProvider()),
        ChangeNotifierProvider(create: (_) => FlightSearchViewModel()),
        ChangeNotifierProvider(create: (_) => SelectCityViewModel()),
        ChangeNotifierProvider(create: (_) => FlightQuoteViewModel()),
        ChangeNotifierProvider(create: (_) => FlightQuoteRoundViewModel()),
        ChangeNotifierProvider(create: (_) => RoundTripFlightSearchViewModel()),
        ChangeNotifierProvider(create: (_) => FareRulesViewModel()),
        ChangeNotifierProvider(create: (_) => FlightSsrLccViewModel()),
        ChangeNotifierProvider(create: (_) => FlightSsrLccRoundViewModel()),
        ChangeNotifierProvider(create: (_) => FlightTicketLccViewModel()),
        ChangeNotifierProvider(create: (_) => TrendingPackagesViewModel()),
        ChangeNotifierProvider(create: (_) => IndianDestinationViewModel()),
        ChangeNotifierProvider(create: (_) => InternationalDestinationViewModel()),
        ChangeNotifierProvider(create: (_) => DestinationViewModel()),
        ChangeNotifierProvider(create: (_) => CategoryViewModel()),
        ChangeNotifierProvider(create: (_) => SubCategoryViewModel()),
        ChangeNotifierProvider(create: (_) => HolidayThemesViewModel()),
        ChangeNotifierProvider(create: (_) => QuickEnquiryViewModel()),
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => LoginOtpViewModel()),
        ChangeNotifierProvider(create: (_) => ValidateOtpViewModel()),
        ChangeNotifierProvider(create: (_) => RegisterViewModel()),
        ChangeNotifierProvider(create: (_) => ForgotPasswordViewModel()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => EditProfileViewModel()),
        ChangeNotifierProvider(create: (_) => UserBookingViewModel()),
        ChangeNotifierProvider(create: (_) => ExclusiveOffersViewModel()),
        ChangeNotifierProvider(create: (_) => ChangePasswordViewModel()),
        ChangeNotifierProvider(create: (_) => HotelSearchViewModel()),
        ChangeNotifierProvider(create: (_) => UpsellViewModel()),
        ChangeNotifierProvider(create: (_) => HotelPromoProvider()),
        ChangeNotifierProvider(create: (_) => HotelDetailViewModel()),
        ChangeNotifierProvider(create: (_) => HotelPreBookingViewModel()),
        ChangeNotifierProvider(create: (_) => HotelBookViewModel()),
        ChangeNotifierProvider(create: (_) => HotelBookingDetailViewModel()),
        ChangeNotifierProvider(create: (_) => BusSeatProvider()),
        ChangeNotifierProvider(create: (_) => BusCityViewModel()),
        ChangeNotifierProvider(create: (_) => BusSearchViewModel()),
        ChangeNotifierProvider(create: (_) => BusBoardingViewModel()),
        ChangeNotifierProvider(create: (_) => BusTravellerProvider()),
        ChangeNotifierProvider(create: (_) => BusBlockViewModel()),
        ChangeNotifierProvider(create: (_) => BusOrderViewModel()),
        ChangeNotifierProvider(create: (_) => BusVerifyPaymentViewModel()),
        ChangeNotifierProvider(create: (_) => BusBookViewModel()),
        ChangeNotifierProvider(create: (_) => BusBookingDetailsViewModel()),
        ChangeNotifierProvider(create: (_) => BusCancelViewModel()),
        ChangeNotifierProvider(create: (_) => HotelCitySearchViewModel()),
        ChangeNotifierProvider(create: (_) => CabSearchViewModel()),
        ChangeNotifierProvider(create: (_) => CabBookViewModel()),
        ChangeNotifierProvider(create: (_) => CabCreateOrderViewModel()),
        ChangeNotifierProvider(create: (_) => CabVerifyPaymentViewModel()),
        ChangeNotifierProvider(create: (_) => CabBookingDetailsViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top], // Only keep the top overlay (status bar)
    );
    return GetMaterialApp(
      title: 'TripGo Online',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home:LogoIntroScreen()
    );
  }
}

