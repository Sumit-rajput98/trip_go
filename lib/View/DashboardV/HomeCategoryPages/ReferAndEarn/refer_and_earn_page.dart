import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Uncomment if using FontAwesome for WhatsApp icon

class ReferAndEarnPage extends StatelessWidget {
 
  const ReferAndEarnPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeColor = const Color(0xFF1B499F);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Refer & Earn",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 19,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.account_balance_wallet_rounded,
              color: Colors.white,
            ),
            onPressed: () {},
            tooltip: 'My Wallet',
          ),
        ],
      ),
      backgroundColor: const Color(0xFFF6F8FA),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header illustration and headline
              Container(
                color: themeColor,
                padding: const EdgeInsets.only(top: 18, bottom: 18),
                child: Column(
                  children: [
                    SizedBox(
                      height: 140,
                      width: double.infinity,
                      child: Image.asset('assets/images/refer.png', fit: BoxFit.contain),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Invite & Earn",
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Earn up to ₹2000 by inviting friends!",
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Colors.white.withOpacity(0.92),
                      ),
                    ),
                  ],
                ),
              ),
              // Invite button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
                child: ElevatedButton.icon(
                  onPressed: () {},
                 icon: FaIcon(FontAwesomeIcons.whatsapp, color: Colors.white, size: 25,), // Uncomment if using FontAwesome
                  //icon: Icon(Icons.share, color: Colors.white), // Fallback icon
                  label: Text(
                    "Invite Now",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF25D366),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    elevation: 3,
                  ),
                ),
              ),
              // Earnings breakdown
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 1.5,
                  child: Column(
                    children: [
                      _RewardRow(
                        icon: Icons.flight_takeoff,
                        label: "Flight booked by friends",
                        reward: "₹100",
                        color: themeColor,
                      ),
                      const Divider(height: 0),
                      _RewardRow(
                        icon: Icons.hotel,
                        label: "Hotel booked by friends",
                        reward: "₹250",
                        color: Colors.deepPurple,
                      ),
                      const Divider(height: 0),
                      _RewardRow(
                        icon: Icons.directions_bus,
                        label: "Bus booked by friends",
                        reward: "₹50",
                        color: Colors.orange,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // How it works
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "How it Works",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _StepTile(
                      number: 1,
                      title: "Share Your Referral Code",
                      description:
                          "Select Refer and Earn option and share your referral code with friends.",
                      color: themeColor,
                    ),
                    _StepTile(
                      number: 2,
                      title: "Friend Installs & Signs Up",
                      description:
                          "When your friend installs the app, ask them to sign up.",
                      color: Colors.deepPurple,
                    ),
                    _StepTile(
                      number: 3,
                      title: "Earn Wallet Money",
                      description:
                          "When your friend books travel, you earn wallet money!",
                      color: Colors.orange,
                    ),
                  ],
                ),
              ),
              // Footer
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Earn Money Tips",
                        style: GoogleFonts.poppins(
                          color: themeColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const Text("|", style: TextStyle(color: Colors.grey)),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "FAQs",
                        style: GoogleFonts.poppins(
                          color: themeColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    // SizedBox(height: 20,)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RewardRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String reward;
  final Color color;
  const _RewardRow({
    required this.icon,
    required this.label,
    required this.reward,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: color.withOpacity(0.13),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(10),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
            decoration: BoxDecoration(
              border: Border.all(color: color, width: 1.2),
              borderRadius: BorderRadius.circular(22),
            ),
            child: Text(
              reward,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                color: color,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StepTile extends StatelessWidget {
  final int number;
  final String title;
  final String description;
  final Color color;
  const _StepTile({
    required this.number,
    required this.title,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: color.withOpacity(0.13),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              number.toString(),
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                color: color,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    color: color,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: GoogleFonts.poppins(
                    fontSize: 13.5,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
