import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomWidget extends StatelessWidget {
  const BottomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Search Flights, Hotels, Bus and Holiday Packages',
            style: GoogleFonts.poppins(fontWeight: FontWeight.w700,fontSize: 19,
            color: Color(0xff212529))
          ),
          const SizedBox(height: 16),
          Text(
            'TripGo is one of the fastest-growing online travel platforms in India, and a trusted name among modern-day travelers. '
                'We provide comprehensive "end-to-end" travel solutions including flight bookings, hotel reservations, cab and bus services, '
                'train tickets, and curated holiday packages. On top of that, we offer a variety of add-on services to enhance your travel experience.',

            style: GoogleFonts.poppins(fontSize: 13,color: Color(0xff212529),
            fontWeight: FontWeight.w400,height: 1.8),textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 16),
          Text(
            'We know that organizing a trip can be time-consuming and stressful, so TripGo is designed to simplify your journey from start to finish. '
                'Our intuitive platform offers a wide range of options tailored to your preferences. Whether you’re heading out on a family holiday, '
                'an adventurous solo trip, or a business visit, TripGo has everything you need under one roof. From flights and stays to car rentals '
                'and holiday bundles, we help you plan your entire trip seamlessly.',
            style: GoogleFonts.poppins(fontSize: 13,color: Color(0xff212529),
                fontWeight: FontWeight.w400,height: 1.8),textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 16),
          Text(
            'At TripGo, transparency and customer satisfaction are at the heart of what we do. There are no hidden charges — our pricing is upfront and competitive. '
                'With TripGo, you can rest assured that you’re getting the best travel deals available. So if you’re searching for a reliable, affordable, and hassle-free '
                'way to book your next getaway, choose TripGo. Let us make your travel journey smooth, simple, and unforgettable.',
            style: GoogleFonts.poppins(fontSize: 13,color: Color(0xff212529),
                fontWeight: FontWeight.w400,height: 1.8),textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
