import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trip_go/View/Widgets/custom_app_bar.dart';
import 'package:trip_go/constants.dart';

import '../DashboardV/bottom_navigation_bar.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 40.0,
        centerTitle: false,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 0),
          child: Text(
            'Wallet',
            style: TextStyle(
              fontSize: 16.0,
              fontFamily: 'poppins',
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_circle_left_outlined, size: 30),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const BottomNavigationbar(),
              ),
                  (route) => false, // This removes all previous routes
            );
          },
        ),
      ),
       body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// EMT Wallet Balance Card
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  colors: [constants.themeColor1.withOpacity(0.1), constants.themeColor2.withOpacity(0.1)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
              child: Row(
                children: [
                  Expanded(
                    child: Text("TripGo Wallet",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("0",
                          style: GoogleFonts.poppins(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Text("TripGo CASH", style: GoogleFonts.poppins(fontSize: 12)),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 14),

            /// Placeholder for Graph/Chart
            Container(
              height: 120,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Text("Money Spent", style: GoogleFonts.poppins(color: Colors.grey)),
            ),
            const SizedBox(height: 12),

            /// Category Chips Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _walletCategory(Icons.flight, "Flight", constants.themeColor1),
                _walletCategory(Icons.train, "Train", Colors.teal),
                _walletCategory(Icons.hotel, "Hotel", Colors.red),
                _walletCategory(Icons.directions_bus, "Bus", Colors.orange),
              ],
            ),
            const SizedBox(height: 16),

            /// Transfer Money Section
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Transfer Money",
                            style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                        const SizedBox(height: 4),
                        Text("Transfer your Money to Bank Account →",
                            style: GoogleFonts.poppins(
                                fontSize: 12, color: constants.themeColor1)),
                      ],
                    ),
                  ),
                   CircleAvatar(
                    backgroundColor: Color(0xFFE5F0FF),
                    child: Icon(Icons.sync_alt_rounded, color: constants.themeColor1),
                  )
                ],
              ),
            ),
            const SizedBox(height: 14),

            /// Spend / Refund / Cashback Tiles
            Row(
              children: [
                _walletStatCard(Icons.payments, "Total Spend", "₹ 0", Colors.orange),
                const SizedBox(width: 8),
                _walletStatCard(Icons.refresh, "Total Refund", "₹ 0", Colors.green),
                const SizedBox(width: 8),
                _walletStatCard(Icons.wallet_giftcard, "Cashback", "₹ 0", constants.themeColor1),
              ],
            ),
            const SizedBox(height: 20),

            /// Bottom Passbook Link
            Row(
              children: [
                Icon(Icons.book_outlined, color: Colors.black),
                const SizedBox(width: 6),
                Text("TripGo Passbook",
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
              ],
            )
          ],
        ),
      ),
    );
  }

  /// Category Item Widget
  Widget _walletCategory(IconData icon, String label, Color color) {
    return Column(
      children: [
        Icon(icon, color: color),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text("0",
              style: GoogleFonts.poppins(
                  fontSize: 12, color: color, fontWeight: FontWeight.w600)),
        ),
        const SizedBox(height: 2),
        Text(label, style: GoogleFonts.poppins(fontSize: 12)),
      ],
    );
  }

  /// Spend / Refund / Cashback Card
  Widget _walletStatCard(IconData icon, String label, String value, Color iconColor) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: iconColor),
            const SizedBox(height: 6),
            Text(label, style: GoogleFonts.poppins(fontSize: 12)),
            const SizedBox(height: 4),
            Text(value,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold, fontSize: 13)),
          ],
        ),
      ),
    );
  }
}
