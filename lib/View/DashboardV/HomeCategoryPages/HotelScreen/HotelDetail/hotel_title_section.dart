
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/HotelScreen/HotelDetail/hotel_detail_page.dart';

import '../../../../../Model/HotelM/hotel_detail_data.dart';
class HotelTitleSection extends StatelessWidget {
  final Hotel1 hotel;

  const HotelTitleSection({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    final starCount = int.tryParse(hotel.starRating?.split(".").first ?? "0") ?? 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Row(
        //   children: [
        //     Container(
        //       padding: const EdgeInsets.all(6),
        //       decoration: BoxDecoration(
        //         color: Colors.grey.shade200,
        //         borderRadius: BorderRadius.circular(8),
        //       ),
        //       child: const Icon(Icons.hotel, size: 20),
        //     ),
        //     const SizedBox(width: 8),
        //     Text(hotel.name ?? "Hotel", style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600)),
        //   ],
        // ),
        // const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                hotel.name.toString(),
                style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ),
            Row(
              children: List.generate(
                starCount,
                    (_) => const Icon(Icons.star, size: 18, color: themeColor1),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
