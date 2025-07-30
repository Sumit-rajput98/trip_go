import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../../ViewM/BusVM/bus_book_view_model.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../ViewM/BusVM/bus_traveller_provider.dart';
import 'bus_booking_detail_screen.dart';

class BusBookingStatusScreen extends StatefulWidget {
  final Map<String, dynamic> blockPayload;
  const BusBookingStatusScreen({super.key, required this.blockPayload});

  @override
  State<BusBookingStatusScreen> createState() => _BusBookingStatusScreenState();
}

class _BusBookingStatusScreenState extends State<BusBookingStatusScreen> {
  bool _hasNavigated = false; // Prevents multiple navigation

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final bookVM = context.read<BusBookViewModel>();
      bookVM.bookBus(widget.blockPayload);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text("Booking Status")),
      body: Center(
        child: Consumer<BusBookViewModel>(
          builder: (_, vm, __) {
            if (vm.isLoading) {
              return const CircularProgressIndicator();
            }

            final travellerProvider = context.read<BusTravellerProvider>();

            if (vm.error != null) {
              travellerProvider.clear();
              return _AnimatedResult(
                lottiePath: 'assets/animation/failed.json',
                title: 'Booking Failed',
                subtitle: vm.bookResponse?.message ?? 'Please try again later',
              );
            }

            final result = vm.bookResponse?.data;
            if (result == null) {
              return const Text("No booking data available");
            }

            // Navigate to BusBookingDetailsScreen once, after booking success
            if (!_hasNavigated) {
              _hasNavigated = true;

              travellerProvider.clear();
              Future.delayed(Duration(milliseconds: 1500), () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BusBookingDetailsScreen(
                      traceId: result.traceId,
                      busId: result.busId.toString(),
                    ),
                  ),
                );
              });
            }

            return _AnimatedResult(
              lottiePath: 'assets/animation/Success.json',
              title: 'Booking Successful',
              subtitle: 'Invoice #: ${result.invoiceNumber}',
              vm: vm,
            );
          },
        ),
      ),
    );
  }
}

class _AnimatedResult extends StatelessWidget {
  final String lottiePath;
  final String title;
  final String subtitle;
  final BusBookViewModel? vm;

  const _AnimatedResult({
    super.key,
    required this.lottiePath,
    required this.title,
    required this.subtitle,
    this.vm,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 150,
          width: 150,
          child: Lottie.asset(lottiePath, repeat: false),
        ),
        const SizedBox(height: 20),
        Text(
          title,
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: GoogleFonts.poppins(fontSize: 14),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        if (vm?.bookResponse != null)
          Text(
            "🎟️ Ticket No: ${vm!.bookResponse!.data.ticketNo}",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(),
          ),
      ],
    );
  }
}
