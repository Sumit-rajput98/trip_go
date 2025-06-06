import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

class TripGoOfferCard extends StatefulWidget {
  const TripGoOfferCard({super.key});

  @override
  State<TripGoOfferCard> createState() => _TripGoOfferCardState();
}

class _TripGoOfferCardState extends State<TripGoOfferCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(); // Infinite loop
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final angle = _controller.value * 2 * math.pi;

        return Container(
          margin: const EdgeInsets.symmetric( vertical: 10),
          padding: const EdgeInsets.all(1.8), // Thin animated border
          decoration: BoxDecoration(
            gradient: SweepGradient(
              startAngle: 0,
              endAngle: math.pi * 2,
              center: Alignment.center,
              stops: const [0.0, 0.5, 1.0],
              transform: GradientRotation(angle),
              colors: const [
                Color(0xff1B499F),
                Color(0xffF73130),
                Color(0xff1B499F),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child:  Icon(Icons.account_balance_wallet_outlined),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "TripGo Card",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        "Extra rewards, free upgrades & more",
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFB56EFF), Color(0xFF6E9DFF)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "New",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Icon(Icons.arrow_forward_ios_rounded,
                    size: 16, color: Colors.grey),
              ],
            ),
          ),
        );
      },
    );
  }
}
