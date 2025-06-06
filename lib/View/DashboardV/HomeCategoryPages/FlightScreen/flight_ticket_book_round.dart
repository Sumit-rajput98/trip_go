import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../../../Model/FlightM/add_traveller_model.dart';
import '../../../../Model/FlightM/flight_ticket_lcc_round_model.dart';
import '../../../../Model/FlightM/flight_ticket_lcc_round_model.dart';
import '../../../../ViewM/FlightVM/flight_ticket_lcc_round_view_model.dart';
import 'FlightWidgets/booking_success_page_round.dart';
import 'booking_success_page.dart';

class FlightTicketBookRound extends StatefulWidget {
  final String email;
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

  FlightTicketBookRound({
    super.key,
    this.fare,
    this.fare2,
    required this.selectedOnwardResultIndex, // ✅
    required this.selectedReturnResultIndex, // ✅
    this.resultIndex,
    this.traceId,
    this.paymentPrice,
    required this.email,
    required this.travellers,
    required this.seatDynamicData,
    this.companyName,
    this.regNo,
  });

  @override
  State<FlightTicketBookRound> createState() => _FlightTicketBookRoundState();
}

class _FlightTicketBookRoundState extends State<FlightTicketBookRound> {
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
    // _bookFlight();
  }

  @override
  void dispose() {
    if (_isRazorpayInitialized) {
      _razorpay.clear();
    }
    super.dispose();
  }

  void _openCheckout() {
    print("Start razorPay");
    var options = {
      'key': 'rzp_test_2lgdj3701kwk9T', // Use your test or live key here
      'amount': widget.paymentPrice! * 100, // Amount in paise (₹100 = 10000)
      'currency': 'INR',
      'name': 'TripGo Online',
      'description': 'Flight Ticket Booking',
      'prefill': {
        'contact': '9879879877',
        'email': widget.email,
      },
      'external': {
        'wallets': ['paytm']
      }
    };
    _razorpay.open(options);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    debugPrint('✅ Payment Successful: ${response.paymentId}');
    debugPrint('✅ Payment orderedId : ${response.orderId}');
    debugPrint('✅ Payment signature : ${response.signature}');
    await _bookFlight();
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
    final passengers = widget.travellers.asMap().entries.map((entry) {
      int index = entry.key;
      Traveller traveller = entry.value;

      return Passenger(
        title: traveller.title ?? "Mr",
        firstName: traveller.firstName ?? "",
        lastName: traveller.lastName ?? "",
        paxType: 1,
        dateOfBirth: traveller.dateOfBirth ?? "",
        gender: 1,
        addressLine1: "123, Test",
        passportNo: "KJHHJKHKJY",
        passportExpiry: "2026-12-06",
        fare: Fare.fromJson(widget.fare!),
        fareIb: Fare.fromJson(widget.fare2!),
        seatDynamic: onwardSeats[index],
        seatDynamicIb: returnSeats[index],
        baggage: onwardBaggage.isNotEmpty ? onwardBaggage[index] : Baggage.empty(),
        baggageIb: returnBaggage.isNotEmpty ? returnBaggage[index] : Baggage.empty(),
        mealDynamic: onwardMeals.isNotEmpty ? onwardMeals[index] : MealDynamic.empty(),
        mealDynamicIb: returnMeals.isNotEmpty ? returnMeals[index] : MealDynamic.empty(),
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

    final flightTicketRequest = FlightTicketRequestRound(
      traceId: widget.traceId ?? "",
      resultIndex: widget.selectedOnwardResultIndex ?? "",
      passengers: passengers,
      resultIndex2: widget.selectedReturnResultIndex ?? "",
    );

    await viewModel.bookFlight(flightTicketRequest);

    if (viewModel.response != null && viewModel.response!.success) {
      pnr = viewModel.response!.data.response.pnr;
      bookingId = viewModel.response!.data.response.bookingId;
      traceId = viewModel.response!.data.traceId;
      pnrIb = viewModel.response!.data.inbound.response.pnr;
      bookingIdIb = viewModel.response!.data.inbound.response.bookingId;

      print('pnr (onward): $pnr');
      print('bookingId (onward): $bookingId');
      print('traceId: $traceId');
      print('pnrIb (inbound): $pnrIb');
      print('bookingIdIb (inbound): $bookingIdIb');

      setState(() {
        pnr = viewModel.response!.data.response.pnr;
        bookingId = viewModel.response!.data.response.bookingId;
        traceId = viewModel.response!.data.traceId;
        pnrIb = viewModel.response!.data.inbound.response.pnr;
        bookingIdIb = viewModel.response!.data.inbound.response.bookingId;

        // Debug prints
        print('pnr (onward): $pnr');
        print('bookingId (onward): $bookingId');
        print('traceId: $traceId');
        print('pnrIb (inbound): $pnrIb');
        print('bookingIdIb (inbound): $bookingIdIb');
      });
      if(mounted)
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BookingSuccessPageRound(
              pnr: pnr!,
              traceId: traceId!,
              bookingId: bookingId, paymentPrice: widget.paymentPrice,
              pnrIb: pnrIb!,
              bookingIdIb: bookingIdIb,
            ),
          ),
        );
    } else {
      debugPrint('❌ Booking failed or no response');
      print("pnr = ${pnrIb}");
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
