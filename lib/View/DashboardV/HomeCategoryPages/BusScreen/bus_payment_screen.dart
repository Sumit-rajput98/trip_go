import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../../../ViewM/BusVM/bus_book_view_model.dart';
import '../../../../ViewM/BusVM/bus_order_view_model.dart';
import '../../../../ViewM/BusVM/bus_verify_payment_view_model.dart';
import 'bus_book_screen.dart';

class BusPaymentGateway extends StatefulWidget {
  final int amount; // in rupees
  final String traceId;
  final String email;
  final String phone;
  final Map<String, dynamic> blockPayload;

  const BusPaymentGateway({
    super.key,
    required this.amount,
    required this.traceId,
    required this.email,
    required this.phone,
    required this.blockPayload,
  });

  @override
  State<BusPaymentGateway> createState() => _BusPaymentGatewayState();
}

class _BusPaymentGatewayState extends State<BusPaymentGateway> {
  late Razorpay _razorpay;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _isInitialized = true;

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    WidgetsBinding.instance.addPostFrameCallback((_) => _startOrderCreation());
  }

  @override
  void dispose() {
    if (_isInitialized) _razorpay.clear();
    super.dispose();
  }

  void _startOrderCreation() async {
    final orderVM = context.read<BusOrderViewModel>();
    await orderVM.createBusOrder({
      "TraceId": widget.traceId,
      "amount": widget.amount , // convert to paise
    });

    final data = orderVM.orderResponse?.data;
    if (data == null) {
      debugPrint("❌ Order Response is null");
      debugPrint("Error: ${orderVM.error}");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to create payment order")),
      );
      return;
    }

    debugPrint("✅ Order Created: ${data.orderId}");

    final options = {
      'key': data.key,
      'amount': data.amount,
      'order_id': data.orderId,
      'currency': data.currency,
      'name': 'TripGo Online',
      'description': 'Bus Booking',
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
    debugPrint("✅ Payment ID: ${response.paymentId}");
    debugPrint("📦 Order ID: ${response.orderId}");

    final verifyVM = BusVerifyPaymentViewModel();
    await verifyVM.verifyBusPayment(response.paymentId!, response.orderId!);

    if (verifyVM.verifyResponse?.success == true) {
      // final bookVM = context.read<BusBookViewModel>();
      // await bookVM.bookBus(widget.blockPayload);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => BusBookingStatusScreen(blockPayload: widget.blockPayload),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(verifyVM.error ?? "Payment verification failed")),
      );
    }
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    debugPrint("💼 External Wallet: ${response.walletName}");
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
