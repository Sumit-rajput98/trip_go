import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

class ResponsiveFlightCard extends StatelessWidget {
  final String departure;
  final String duration;
  final String departureDate;
  final String arrivalDate;
  final String arrival;
  final String stops;
  final String flightNo;
  final String price;
  final String publishedFare;
  final String airlineName;
  final double screenWidth;
  final String img;

  const ResponsiveFlightCard({
    super.key,
    required this.arrivalDate,
    required this.departureDate,
    required this.departure,
    required this.duration,
    required this.publishedFare,
    required this.arrival,
    required this.stops,
    required this.flightNo,
    required this.price,
    required this.airlineName,
    required this.screenWidth,
    required this.img
  });

  @override
  Widget build(BuildContext context) {
    String formatDateLabel(String timeStr) {
      try {
        final dateTime = DateTime.parse(timeStr);
        return DateFormat('dd MMM yyyy').format(dateTime); // Tue–15May2025
      } catch (_) {
        return '';
      }
    }
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      margin: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.03,
        vertical: screenWidth * 0.02,
      ),
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Image.network(img,
                            height: screenWidth * 0.075),
                        SizedBox(width: screenWidth * 0.02),
                        Text(
                          departure,
                          style: GoogleFonts.poppins(
                            fontSize: screenWidth * 0.045,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5,),
                    Text(
                        formatDateLabel(departureDate),
                        style: GoogleFonts.poppins(fontSize: 10)
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  children: [
                    Text(
                      duration,
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth * 0.035,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: screenWidth * 0.01),
                    Container(
                      height: 2,
                      width: screenWidth * 0.12,
                      color: Colors.grey.shade400,
                    ),
                    SizedBox(height: screenWidth * 0.01),
                    Text(
                      stops,
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth * 0.035,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  children: [
                    Text(
                      arrival,
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth * 0.045,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5,),
                    Text(
                        formatDateLabel(arrivalDate),
                        style: GoogleFonts.poppins(fontSize: 10)
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  children: [
                    Text(
                      publishedFare,
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth * 0.045,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffF73130),
                      ),
                    ),
                    // Text(
                    //   price,
                    //   style: GoogleFonts.poppins(
                    //     fontSize: screenWidth * 0.03,
                    //     fontWeight: FontWeight.w500,
                    //     color: Colors.grey,
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
            SizedBox(height: screenWidth * 0.03),
            Divider(color: Colors.grey.shade300, thickness: 1),
            SizedBox(height: screenWidth * 0.02),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      airlineName,
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth * 0.038,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: screenWidth * 0.005),
                    Text(
                      flightNo,
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth * 0.03,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "+ More Fare",
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth * 0.035,
                        fontWeight: FontWeight.w600,
                        color: Colors.blueAccent,
                      ),
                    ),
                    SizedBox(height: screenWidth * 0.01),
                    Text(
                      "Get Rs.200 OFF | Code BOOKNOW",
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth * 0.03,
                        fontWeight: FontWeight.w500,
                        color: Colors.green.shade800,
                      ),
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