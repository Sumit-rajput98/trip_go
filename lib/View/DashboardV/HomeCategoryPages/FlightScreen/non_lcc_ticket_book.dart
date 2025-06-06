import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../../../Model/FlightM/add_traveller_model.dart';
import '../../../../Model/FlightM/flight_ticket_lcc_model.dart';
import '../../../../ViewM/FlightVM/flight_ticket_non_lcc_view_model.dart';
import 'booking_success_page.dart';

class NonLccFlightTicketBook extends StatefulWidget {
  final String email;
  final Map<String, dynamic>? fare;
  final String? resultIndex;
  final String? traceId;
  final List<Traveller> travellers;
  final Map<String, dynamic> seatDynamicData;
  int? paymentPrice;

  NonLccFlightTicketBook({
    super.key,
    this.fare,
    this.resultIndex,
    this.traceId,
    this.paymentPrice,
    required this.email,
    required this.travellers,
    required this.seatDynamicData,
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
        city: "Gurgaon",
        countryCode: "IN",
        countryName: "India",
        nationality: "IN",
        contactNo: "9879879877",
        email: traveller.email ?? widget.email,
        isLeadPax: true,
        ffAirlineCode: "",
        ffNumber: "",
        gstCompanyName: "",
        gstCompanyAddress: "",
        gstCompanyContactNumber: "",
        gstNumber: "",
        gstCompanyEmail: "",
      );
    }).toList();

    final seatDynamicList = (widget.seatDynamicData['SeatDynamic'] as List<dynamic>).map((item) {
      return SeatDynamic(
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
      );
    }).toList();

    final flightTicketRequest = FlightTicketRequest(
      traceId: widget.traceId ?? "",
      resultIndex: widget.resultIndex ?? "",
      passengers: passengers,
      seatDynamic: seatDynamicList,
    );

    await viewModel.bookFlight(flightTicketRequest);

    if (viewModel.response != null && viewModel.response!.success) {
      setState(() {
        pnr = viewModel.response!.data.pnr;
        bookingId = viewModel.response!.data.bookingId;
        traceId = viewModel.response!.data.traceId;
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BookingSuccessPage(
            pnr: pnr!,
            traceId: traceId!,
            bookingId: bookingId.toString(), paymentPrice: widget.paymentPrice,
          ),
        ),
      );
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
