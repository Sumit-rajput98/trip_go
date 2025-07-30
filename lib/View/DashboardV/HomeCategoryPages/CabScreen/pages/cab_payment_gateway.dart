import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../../../../ViewM/CabVM/cab_book_view_model.dart';
import '../../../../../ViewM/CabVM/cab_verify_payment_view_model.dart';
import 'cab_booking_success_page.dart';
import 'cab_create_order_view_model.dart';

class CabPaymentGateway extends StatefulWidget {
  final String cabId;
  final int amount; // ₹ in rupees
  final String email;
  final String phone;
  final Map<String, dynamic> bookingPayload;

  const CabPaymentGateway({
    super.key,
    required this.cabId,
    required this.amount,
    required this.email,
    required this.phone,
    required this.bookingPayload,
  });

  @override
  State<CabPaymentGateway> createState() => _CabPaymentGatewayState();
}

class _CabPaymentGatewayState extends State<CabPaymentGateway> {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    WidgetsBinding.instance.addPostFrameCallback((_) => _startOrder());
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _startOrder() async {
    final vm = context.read<CabCreateOrderViewModel>();
    await vm.createCabOrder(cabId: widget.cabId, amount: widget.amount);

    final data = vm.orderData;

    if (data == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(vm.error ?? "Order creation failed")),
      );
      return;
    }

    final options = {
      'key': data.key,
      'amount': data.amount, // in paise
      'order_id': data.orderId,
      'currency': data.currency,
      'name': 'TripGo Online',
      'description': 'Cab Booking',
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

    final verifyVM = CabVerifyPaymentViewModel();
    await verifyVM.verifyCabPayment(response.paymentId!, response.orderId!);

    if (verifyVM.verifyResponse?.success == true) {
      final cabBookVM = context.read<CabBookViewModel>();
      await cabBookVM.bookCab(widget.bookingPayload);

      if (cabBookVM.cabBookingResponse != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => CabBookingResultPage(
              success: cabBookVM.cabBookingResponse!.success,
              orderNo: cabBookVM.cabBookingResponse!.data?.booking.orderNo ?? '',
              message: cabBookVM.cabBookingResponse!.message,
              vm: cabBookVM,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("❌ Booking Failed: ${cabBookVM.error ?? "Unknown error"}")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Payment Verification Failed: ${verifyVM.error ?? "Try again"}")),
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
