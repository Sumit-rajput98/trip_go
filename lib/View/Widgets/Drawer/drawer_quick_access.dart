import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trip_go/constants.dart'; // Assuming themeColor1 and themeColor2 are here

class DrawerQuickAccess extends StatelessWidget {
  const DrawerQuickAccess({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final iconSize = screenWidth * 0.06;
    final circleSize = screenWidth * 0.14;

    final items = [
      {'icon': Icons.person_outline, 'label': 'My Account'},
      {'icon': Icons.chat_bubble_outline, 'label': 'Support'},
      {'icon': Icons.notifications_none, 'label': 'Notifications'},
    ];

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.map((item) {
          return Column(
            children: [
              Container(
                width: circleSize,
                height: circleSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [constants.themeColor1, constants.themeColor2],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: constants.themeColor1.withOpacity(0.2),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    item['icon'] as IconData,
                    size: iconSize,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                item['label'] as String,
                style: GoogleFonts.poppins(
                  fontSize: screenWidth * 0.032,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
