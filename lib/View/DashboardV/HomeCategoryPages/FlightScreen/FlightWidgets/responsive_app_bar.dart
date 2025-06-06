import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResponsiveAppBar extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onBack;
  final VoidCallback? onSwap;
  final VoidCallback? onFilter;
  final VoidCallback? onMore;

  const ResponsiveAppBar({
    super.key,
    required this.title,
    required this.subtitle,
    this.onBack,
    this.onSwap,
    this.onFilter,
    this.onMore,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: screenWidth * 0.03,
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: onBack ?? () => Navigator.of(context).pop(),
                  borderRadius: BorderRadius.circular(30),
                  child: Icon(
                    Icons.arrow_back,
                    size: screenWidth * 0.06,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(width: screenWidth * 0.02),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth * 0.045,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: screenWidth * 0.005),
                    Text(
                      subtitle,
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth * 0.032,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.search_outlined, size: screenWidth * 0.055),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.swap_vert, size: screenWidth * 0.055),
                      onPressed: onSwap,
                    ),
                    // IconButton(
                    //   icon: Icon(Icons.filter_alt_outlined, size: screenWidth * 0.055),
                    //   onPressed: onFilter,
                    // ),
                    IconButton(
                      icon: Icon(Icons.more_vert, size: screenWidth * 0.055),
                      onPressed: onMore,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
