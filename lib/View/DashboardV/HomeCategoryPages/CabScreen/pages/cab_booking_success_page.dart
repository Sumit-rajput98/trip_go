import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../ViewM/CabVM/cab_book_view_model.dart'; // Custom widget for success/failure animation

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../ViewM/CabVM/cab_book_view_model.dart';
import '../../../../../ViewM/CabVM/cab_booking_details_view_model.dart';
import 'cab_booking_details_page.dart';

class CabBookingResultPage extends StatefulWidget {
  final bool success;
  final String orderNo;
  final String message;
  final CabBookViewModel vm;

  const CabBookingResultPage({
    super.key,
    required this.success,
    required this.orderNo,
    required this.message,
    required this.vm,
  });

  @override
  State<CabBookingResultPage> createState() => _CabBookingResultPageState();
}

class _CabBookingResultPageState extends State<CabBookingResultPage> {
  @override
  void initState() {
    super.initState();

    if (widget.success) {
      Future.delayed(const Duration(seconds: 3), () async {
        final bookingVM = Provider.of<CabBookingDetailsViewModel>(context, listen: false);
        await bookingVM.loadBookingDetails(widget.orderNo);

        if (bookingVM.bookingDetails != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => CabBookingDetailPage(booking: bookingVM.bookingDetails!),
            ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String lottiePath = widget.success
        ? 'assets/animation/Success.json'
        : 'assets/animation/failed.json';

    String title = widget.success ? "Booking Successful!" : "Booking Failed!";
    String subtitle = widget.success
        ? "Your cab has been booked successfully.\nThank you!"
        : "There was an issue processing your booking.\nPlease try again later.";

    return Scaffold(
      body: Center(
        child: _AnimatedResult(
          lottiePath: lottiePath,
          title: title,
          subtitle: subtitle,
          vm: widget.vm,
        ),
      ),
    );
  }
}

class _AnimatedResult extends StatelessWidget {
  final String lottiePath;
  final String title;
  final String subtitle;
  final CabBookViewModel? vm;

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
        if (vm?.cabBookingResponse?.message != null)
          Text(
            "🎟️ Order No: ${vm!.cabBookingResponse?.data?.booking.orderNo}",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(),
          ),
      ],
    );
  }
}