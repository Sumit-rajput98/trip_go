import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:trip_go/ViewM/HotelVM/hotel_book_view_model.dart';
import 'package:provider/provider.dart';
import '../../../../ViewM/HotelVM/create_hotel_order_view_model.dart';
import '../../../../ViewM/HotelVM/hotel_verify_payment_view_model.dart';
import 'hotel_booking_status_screen.dart';

class HotelPaymentGateway extends StatefulWidget {
  final int amount; // in paise
  final String bookingCode;
  final String email;
  final String phone;
  final dynamic bookingRequest;

  const HotelPaymentGateway({
    super.key,
    required this.amount,
    required this.bookingCode,
    required this.email,
    required this.phone,
    required this.bookingRequest,
  });

  @override
  State<HotelPaymentGateway> createState() => _HotelPaymentGatewayState();
}

class _HotelPaymentGatewayState extends State<HotelPaymentGateway> {
  late Razorpay _razorpay;
  bool _isRazorpayInitialized = false;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _isRazorpayInitialized = true;

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    WidgetsBinding.instance.addPostFrameCallback((_) => _openCheckout());
  }

  @override
  void dispose() {
    if (_isRazorpayInitialized) _razorpay.clear();
    super.dispose();
  }

  void _openCheckout() async {
    final orderVM = CreateHotelOrderViewModel();
    await orderVM.createOrder(widget.bookingCode, widget.amount);

    final orderData = orderVM.hotelOrderResponse?.data;
    if (orderData == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to create order")),
      );
      return;
    }

    var options = {
      'key': orderData.key,
      'amount': orderData.amount,
      'order_id': orderData.orderId,
      'currency': orderData.currency,
      'name': 'TripGo Online',
      'description': 'Hotel Booking Payment',
      'prefill': {
        'contact': widget.phone,
        'email': widget.email,
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    _razorpay.open(options);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    final verifyVM = HotelVerifyPaymentViewModel();

    await verifyVM.verifyHotelPayment(
      response.paymentId!,
      response.orderId!,
    );

    if (verifyVM.verifyResponse?.success == true) {
      final hotelVM = context.read<HotelBookViewModel>();

      await hotelVM.bookHotel(widget.bookingRequest);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HotelBookingStatusScreen(
            request: widget.bookingRequest,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(verifyVM.error ?? "Payment verification failed"),
        ),
      );
    }
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    debugPrint('💼 External Wallet: ${response.walletName}');
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
