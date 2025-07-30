import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../../../Model/FlightM/add_traveller_model.dart';
import '../../../../Model/FlightM/flight_ticket_lcc_round_model.dart';
import '../../../../Model/FlightM/flight_ticket_lcc_round_model.dart';
import '../../../../ViewM/FlightVM/baggage_selection_provider.dart';
import '../../../../ViewM/FlightVM/baggage_selection_round_provider.dart';
import '../../../../ViewM/FlightVM/create_order_view_model..dart';
import '../../../../ViewM/FlightVM/flight_ticket_lcc_round_view_model.dart';
import '../../../../ViewM/FlightVM/meal_provider.dart';
import '../../../../ViewM/FlightVM/meal_selection_round_provider.dart';
import '../../../../ViewM/FlightVM/seat_selection_provider_round.dart';
import '../../../../ViewM/FlightVM/selected_seats_provider.dart';
import '../../../../ViewM/FlightVM/verify_payment_view_model.dart';
import 'FlightWidgets/booking_success_page_round.dart';
import 'booking_success_page.dart';

class FlightDirectTicketBookRound extends StatefulWidget {
  final bool isLcc;
  final bool isLccIb;
  final String email;
  final String phone;
  final String selectedOnwardResultIndex;
  final String selectedReturnResultIndex;
  final Map<String, dynamic>? fare;
  final Map<String, dynamic>? fare2;
  final String? resultIndex;
  final String? traceId;
  final List<Traveller> travellers;
  final Map<String, dynamic> seatDynamicData;
  int? paymentPrice;
  final String? companyName;
  final String? regNo;
  final Map<String, dynamic>? baggageDynamicData;
  final Map<String, dynamic>? mealDynamicData;

  FlightDirectTicketBookRound({
    super.key,
    this.fare,
    this.fare2,
    required this.isLcc,
    required this.isLccIb,
    required this.selectedOnwardResultIndex, // ✅
    required this.selectedReturnResultIndex, // ✅
    this.resultIndex,
    this.traceId,
    this.paymentPrice,
    required this.email,
    required this.phone,
    required this.travellers,
    required this.seatDynamicData,
    this.baggageDynamicData,
    this.mealDynamicData,
    this.companyName,
    this.regNo,
  });

  @override
  State<FlightDirectTicketBookRound> createState() => _FlightDirectTicketBookRoundState();
}

class _FlightDirectTicketBookRoundState extends State<FlightDirectTicketBookRound> {
  final FlightTicketLccRoundViewModel viewModel = FlightTicketLccRoundViewModel();
  // final FlightTicketNonLccViewModel viewModel = FlightTicketNonLccViewModel();
  late Razorpay _razorpay;
  bool _isRazorpayInitialized = false;
  String? pnr;
  String? pnrIb;
  int? bookingIdIb;
  int? bookingId;
  String? traceId;
  late List<Baggage> onwardBaggage;
  late List<Baggage> returnBaggage;
  late List<MealDynamic> onwardMeals;
  late List<MealDynamic> returnMeals;

  @override
  void initState() {
    super.initState();
    onwardBaggage = List.generate(widget.travellers.length, (_) => Baggage.empty());
    returnBaggage = List.generate(widget.travellers.length, (_) => Baggage.empty());
    onwardMeals = List.generate(widget.travellers.length, (_) => MealDynamic.empty());
    returnMeals = List.generate(widget.travellers.length, (_) => MealDynamic.empty());

    print("@@@ - ${widget.fare2} ");
    _razorpay = Razorpay();
    _isRazorpayInitialized = true;
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    // _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    _openCheckout();
  }

  @override
  void dispose() {
    if (_isRazorpayInitialized) {
      _razorpay.clear();
    }
    super.dispose();
  }

  void _openCheckout() async {
    print("Start Razorpay - Creating Order -- ");
    // print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@${widget.isInternational}");

    final orderVM = CreateOrderViewModel();
    final success = await orderVM.createOrder(widget.paymentPrice!, widget.traceId ?? "");

    if (success && orderVM.response != null) {
      final orderData = orderVM.response!.data;

      print("Order ID: ${orderData.orderId}"); // ✅ Print to terminal

      var options = {
        'key': orderData.key,
        'amount': orderData.amount, // already in paise
        'order_id': orderData.orderId,
        'currency': orderData.currency,
        'name': 'TripGo Online',
        'description': 'Flight Ticket Booking',
        'prefill': {
          'contact': widget.phone,
          'email': widget.email,
        },
        'external': {
          'wallets': ['paytm']
        }
      };

      _razorpay.open(options);
    } else {
      print("❌ Failed to create order");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to create Razorpay order")),
      );
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    debugPrint('✅ Payment Successful: ${response.paymentId}');
    debugPrint('✅ Payment orderedId : ${response.orderId}');

    final verifyVM = VerifyPaymentViewModel();
    final isVerified = await verifyVM.verifyPayment(
      response.paymentId!,
      response.orderId!,
    );

    if (isVerified) {
      await _bookFlight(); // Only book flight if payment is verified
    } else {
      debugPrint('❌ Payment verification failed');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Payment verification failed.')),
      );
    }
  }

  // void _handlePaymentError(PaymentFailureResponse response) {
  //   debugPrint('❌ Payment Failed: ${response.code} → ${response.message}');
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(content: Text('Payment failed. Please try again.')),
  //   );
  //   Navigator.pop(context); // Go back if payment failed
  // }

  void _handleExternalWallet(ExternalWalletResponse response) {
    debugPrint('💼 External Wallet: ${response.walletName}');
  }

  Future<void> _bookFlight() async {
    // Parse onward and return seats
    final onwardSeats = (widget.seatDynamicData['SeatDynamic'] as List<dynamic>).map((item) {
      return SeatDynamic(
        airlineCode: item['AirlineCode'] ?? '',
        flightNumber: item['FlightNumber'] ?? '',
        craftType: item['CraftType'] ?? '',
        origin: item['Origin'] ?? '',
        destination: item['Destination'] ?? '',
        availablityType: item['AvailablityType'] ?? 0,
        description: item['Description'] ?? '',
        code: item['Code'] ?? '',
        rowNo: item['RowNo'] ?? '',
        seatNo: item['SeatNo'],
        seatType: item['SeatType'] ?? 0,
        seatWayType: item['SeatWayType'] ?? 0,
        compartment: item['Compartment'] ?? 0,
        deck: item['Deck'] ?? 0,
        currency: item['Currency'] ?? '',
        price: (item['Price'] as num?)?.toDouble() ?? 0.0,
      );
    }).toList();

    final returnSeats = (widget.seatDynamicData['SeatDynamicIB'] as List<dynamic>).map((item) {
      return SeatDynamic(
        airlineCode: item['AirlineCode'] ?? '',
        flightNumber: item['FlightNumber'] ?? '',
        craftType: item['CraftType'] ?? '',
        origin: item['Origin'] ?? '',
        destination: item['Destination'] ?? '',
        availablityType: item['AvailablityType'] ?? 0,
        description: item['Description'] ?? '',
        code: item['Code'] ?? '',
        rowNo: item['RowNo'] ?? '',
        seatNo: item['SeatNo'],
        seatType: item['SeatType'] ?? 0,
        seatWayType: item['SeatWayType'] ?? 0,
        compartment: item['Compartment'] ?? 0,
        deck: item['Deck'] ?? 0,
        currency: item['Currency'] ?? '',
        price: (item['Price'] as num?)?.toDouble() ?? 0.0,
      );
    }).toList();

    final onwardBaggage = (widget.baggageDynamicData?['BaggageDynamic'] as List<dynamic>? ?? [])
        .map((item) => Baggage.fromJson(item))
        .toList();

    final returnBaggage = (widget.baggageDynamicData?['BaggageDynamicIB'] as List<dynamic>? ?? [])
        .map((item) => Baggage.fromJson(item))
        .toList();

    final onwardMeals = (widget.mealDynamicData?['MealDynamic'] as List<dynamic>? ?? [])
        .map((item) => MealDynamic(
      airlineCode: item['AirlineCode'] ?? '',
      flightNumber: item['FlightNumber'] ?? '',
      wayType: item['WayType'] ?? 1,
      code: item['Code'] ?? '',
      description: item['Description'] ?? 0,
      airlineDescription: item['AirlineDescription']?.toString() ?? '',
      quantity: item['Quantity'] ?? 1,
      currency: item['Currency'] ?? '',
      price: (item['Price'] as num?)?.toDouble() ?? 0.0,
      origin: item['Origin'] ?? '',
      destination: item['Destination'] ?? '',
    ))
        .toList();

    final returnMeals = (widget.mealDynamicData?['MealDynamicIB'] as List<dynamic>? ?? [])
        .map((item) => MealDynamic(
      airlineCode: item['AirlineCode'] ?? '',
      flightNumber: item['FlightNumber'] ?? '',
      wayType: item['WayType'] ?? 2,
      code: item['Code'] ?? '',
      description: item['Description'] ?? 0,
      airlineDescription: item['AirlineDescription']?.toString() ?? '',
      quantity: item['Quantity'] ?? 1,
      currency: item['Currency'] ?? '',
      price: (item['Price'] as num?)?.toDouble() ?? 0.0,
      origin: item['Origin'] ?? '',
      destination: item['Destination'] ?? '',
    ))
        .toList();

    // Parse Passengers
    final passengers = widget.travellers.asMap().entries.map((entry) {
      int index = entry.key;
      Traveller traveller = entry.value;

      bool isInfant = traveller.paxType == 3;

      return Passenger(
        title: traveller.title ?? "Mr",
        firstName: traveller.firstName ?? "",
        lastName: traveller.lastName ?? "",
        paxType: traveller.paxType,
        dateOfBirth: traveller.dateOfBirth ?? "",
        gender: 1,
        addressLine1: "123, Test",
        passportNo: "KJHHJKHKJY",
        passportExpiry: "2026-12-06",
        fare: Fare.fromJson(widget.fare!),
        fareIb: Fare.fromJson(widget.fare2!),
        seatDynamic: isInfant ? [] : index < onwardSeats.length ? [onwardSeats[index]] : [],
        seatDynamicIb: isInfant ? [] : index < returnSeats.length ? [returnSeats[index]] : [],

        baggage: isInfant ? [] : index < onwardBaggage.length ? [onwardBaggage[index]] : [],
        baggageIb: isInfant ? [] : index < returnBaggage.length ? [returnBaggage[index]] : [],

        mealDynamic: isInfant ? [] : index < onwardMeals.length ? [onwardMeals[index]] : [],
        mealDynamicIb: isInfant ? [] : index < returnMeals.length ? [returnMeals[index]] : [],
        city: "Gurgaon",
        countryCode: "IN",
        countryName: "India",
        nationality: "IN",
        contactNo: "9879879877",
        email: traveller.email ?? widget.email,
        isLeadPax: true,
        ffAirlineCode: "",
        ffNumber: "",
        gstCompanyName: widget.companyName ?? "",
        gstCompanyAddress: "",
        gstCompanyContactNumber: "",
        gstNumber: widget.regNo ?? "",
        gstCompanyEmail: "",
      );
    }).toList();

    Provider.of<SeatSelectionProvider>(context, listen: false).clearSeats();
    Provider.of<SeatSelectionProviderRound>(context, listen: false).clearSeats();
    Provider.of<BaggageSelectionProvider>(context, listen: false).clearBaggage();
    Provider.of<BaggageSelectionRoundProvider>(context, listen: false).clearBaggage();
    Provider.of<MealProvider>(context, listen: false).clearMeals();
    Provider.of<MealSelectionRoundProvider>(context, listen: false).clearMeals();

    // Create ticket request
    final flightTicketRequest = FlightTicketRequestRound(
      userEmail: widget.email,
      userPhone: widget.phone,
      isLcc: widget.isLcc,
      isLccIb: widget.isLccIb,
      type: "app",
      traceId: widget.traceId ?? "",
      resultIndex: widget.selectedOnwardResultIndex ?? "",
      passengers: passengers,
      resultIndex2: widget.selectedReturnResultIndex ?? "",
    );

    await viewModel.bookFlight(flightTicketRequest);

    // Handle response
    if (viewModel.response != null && viewModel.response!.success) {
      pnr = viewModel.response!.data.response.pnr;
      bookingId = viewModel.response!.data.response.bookingId;
      traceId = viewModel.response!.data.traceId;
      pnrIb = viewModel.response!.data.inbound.response.pnr;
      bookingIdIb = viewModel.response!.data.inbound.response.bookingId;

      setState(() {
        pnr = viewModel.response!.data.response.pnr;
        bookingId = viewModel.response!.data.response.bookingId;
        traceId = viewModel.response!.data.traceId;
        pnrIb = viewModel.response!.data.inbound.response.pnr;
        bookingIdIb = viewModel.response!.data.inbound.response.bookingId;
      });

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BookingSuccessPageRound(
              pnr: pnr!,
              traceId: traceId!,
              bookingId: bookingId,
              paymentPrice: widget.paymentPrice,
              pnrIb: pnrIb!,
              bookingIdIb: bookingIdIb,
            ),
          ),
        );
      }
    } else {
      debugPrint('❌ Booking failed or no response');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Booking failed. Please contact support.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Flight Book Page"),
      // ),
      body: Center(
        child: Text("Processing..."),
      ),
    );
  }
}
