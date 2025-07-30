import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../../../Model/FlightM/add_traveller_model.dart';
import '../../../../Model/FlightM/flight_ticket_lcc_model.dart';
import '../../../../ViewM/FlightVM/baggage_selection_provider.dart';
import '../../../../ViewM/FlightVM/create_order_view_model..dart';
import '../../../../ViewM/FlightVM/flight_ticket_non_lcc_view_model.dart';
import '../../../../ViewM/FlightVM/meal_provider.dart';
import '../../../../ViewM/FlightVM/selected_seats_provider.dart';
import '../../../../ViewM/FlightVM/verify_payment_view_model.dart';
import 'booking_success_page.dart';

class NonLccFlightTicketBook extends StatefulWidget {
  final bool? isInternational;
  final bool isLcc;
  final String email;
  final String phone;
  final String? companyName;
  final String? regNo;
  final Map<String, dynamic>? fare;
  final String? resultIndex;
  final String? traceId;
  final List<Traveller> travellers;
  final Map<String, dynamic> seatDynamicData;
  final Map<String, dynamic>? baggageDynamicData;
  final Map<String, dynamic>? mealDynamicData;
  int? paymentPrice;

  NonLccFlightTicketBook({
    super.key,
    this.fare,
    this.isInternational,
    this.companyName,
    this.regNo,
    this.resultIndex,
    this.traceId,
    this.paymentPrice,
    required this.isLcc,
    required this.email,
    required this.travellers,
    required this.seatDynamicData,
    this.baggageDynamicData,
    this.mealDynamicData,
    required this. phone
  });

  @override
  State<NonLccFlightTicketBook> createState() => _NonLccFlightTicketBookState();
}

class _NonLccFlightTicketBookState extends State<NonLccFlightTicketBook> {
  final FlightTicketNonLccViewModel viewModel = FlightTicketNonLccViewModel();
  late Razorpay _razorpay;
  bool _isRazorpayInitialized = false;
  String? pnr;
  int? bookingId;
  String? traceId;

  @override
  void initState() {
    super.initState();
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
    print("Start Razorpay - Creating Order -- ${widget.isInternational}");
    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@${widget.isInternational}");

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
    print(widget.isInternational);

    // 1. Parse meal data
    final List<MealDynamic> mealList =
    ((widget.mealDynamicData?['MealDynamic'] as List?)?.first as Map<String, dynamic>)
        .values
        .map((item) => MealDynamic(
      airlineCode: item['AirlineCode'] ?? '',
      flightNumber: item['FlightNumber'] ?? '',
      wayType: item['WayType'] ?? 0,
      code: item['Code'] ?? '',
      description: item['Description'],
      airlineDescription: item['AirlineDescription'] ?? '',
      quantity: item['Quantity'] ?? 0,
      currency: item['Currency'] ?? '',
      price: (item['Price'] as num?)?.toDouble() ?? 0.0,
      origin: item['Origin'] ?? '',
      destination: item['Destination'] ?? '',
    ))
        .toList();

    // 2. Parse seat data
    final List<SeatDynamic> seatList = (widget.seatDynamicData['SeatDynamic'] as List<dynamic>)
        .map((item) => SeatDynamic(
      airlineCode: item['AirlineCode'] ?? '',
      flightNumber: item['FlightNumber'] ?? '',
      craftType: item['CraftType'] ?? '',
      origin: item['Origin'] ?? '',
      destination: item['Destination'] ?? '',
      availablityType: item['AvailablityType'] ?? 0,
      description: item['Description'] ?? 0,
      code: item['Code'] ?? '',
      rowNo: item['RowNo'] ?? '',
      seatNo: item['SeatNo'],
      seatType: item['SeatType'] ?? 0,
      seatWayType: item['SeatWayType'] ?? 0,
      compartment: item['Compartment'] ?? 0,
      deck: item['Deck'] ?? 0,
      currency: item['Currency'] ?? '',
      price: (item['Price'] as num?)?.toDouble() ?? 0.0,
    ))
        .toList();

    // 3. Parse baggage data
    final List<BaggageDynamic> baggageList =
    (widget.baggageDynamicData?['BaggageDynamic'] as List<dynamic>)
        .map((item) => BaggageDynamic(
      airlineCode: item['AirlineCode'] ?? '',
      flightNumber: item['FlightNumber'] ?? '',
      wayType: item['WayType'] ?? 0,
      code: item['Code'] ?? '',
      description: item['Description'] ?? 0,
      weight: item['Weight'] ?? 0,
      currency: item['Currency'] ?? '',
      price: (item['Price'] as num?)?.toDouble() ?? 0.0,
      origin: item['Origin'] ?? '',
      destination: item['Destination'] ?? '',
    ))
        .toList();

    // 4. Assign per passenger
    final passengers = widget.travellers.asMap().entries.map((entry) {
      int index = entry.key;
      Traveller traveller = entry.value;
      bool isInfant = traveller.paxType == 3;

      return Passenger(
        title: traveller.title ?? "Mr",
        firstName: traveller.firstName,
        lastName: traveller.lastName,
        paxType: traveller.paxType,
        dateOfBirth: traveller.dateOfBirth ?? "",
        gender: 1,
        addressLine1: "123, Test",
        passportNo: "KJHHJKHKJY",
        passportExpiry: "2026-12-06",
        fare: Fare.fromJson(widget.fare!),
        city: "Gurgaon",
        countryCode: "IN",
        countryName: "India",
        nationality: "IN",
        contactNo: "9879879877",
        email: traveller.email ?? widget.email,
        isLeadPax: index == 0,

        ffAirlineCode: "",
        ffNumber: "",
        gstCompanyName: widget.companyName ?? "",
        gstCompanyAddress: "",
        gstCompanyContactNumber: "",
        gstNumber: widget.regNo ?? "",
        gstCompanyEmail: "",

        // ✅ Assign individual seat/meal/baggage if available
        seatDynamic: isInfant ? [] : index < seatList.length ? [seatList[index]] : [],
        baggageDynamic: isInfant ? [] : index < baggageList.length ? [baggageList[index]] : [],
        mealDynamic: isInfant ? [] : index < mealList.length ? [mealList[index]] : [],
      );
    }).toList();

    // 5. Clear providers after use
    Provider.of<SeatSelectionProvider>(context, listen: false).clearSeats();
    Provider.of<BaggageSelectionProvider>(context, listen: false).clearBaggage();
    Provider.of<MealProvider>(context, listen: false).clearMeals();

    // 6. Prepare final request
    final flightTicketRequest = FlightTicketRequest(
      isLcc: widget.isLcc,
      userEmail: widget.email,
      userPhone: widget.phone,
      type: "app",
      traceId: widget.traceId ?? "",
      resultIndex: widget.resultIndex ?? "",
      passengers: passengers,
      seatDynamic: seatList,
      baggageDynamic: baggageList,
      mealDynamic: mealList,
    );

    // 7. Make booking
    await viewModel.bookFlight(flightTicketRequest);

    // 8. Handle result
    if (viewModel.response != null && viewModel.response!.success) {
      setState(() {
        pnr = viewModel.response!.data.pnr;
        bookingId = viewModel.response!.data.bookingId;
        traceId = viewModel.response!.data.traceId;
      });

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BookingSuccessPage(
              isInternational: widget.isInternational,
              pnr: pnr!,
              traceId: traceId!,
              bookingId: bookingId.toString(),
              paymentPrice: widget.paymentPrice,
            ),
          ),
        );
      }
    } else {
      debugPrint('❌ Booking failed or no response');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Booking failed. Please contact support.')),
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
