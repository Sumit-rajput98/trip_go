import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DestinationDetailsPage extends StatelessWidget {
  final String name;
  final String image;

  const DestinationDetailsPage({
    super.key,
    required this.name,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 40.0, // Sets the AppBar height to 40 pixels
        centerTitle: false,  // Aligns the title to the start (left)
        titleSpacing: 0,     // Removes default spacing before the title
        leading: IconButton(
          icon: Icon(Icons.arrow_circle_left_outlined, size: 30),
          padding: EdgeInsets.zero, // Eliminates padding around the icon
          constraints: BoxConstraints(), // Removes default constraints
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Destination : $name", style: TextStyle(fontSize: 15, fontFamily: 'poppins', fontWeight: FontWeight.bold),),
        ),
      body: Column(
        children: [
          Image.network(
            image,
            height: 250,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$name",
                    style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 10,),
                  Text(
                    "Embark on an unforgettable journey with TripGo Tour & Travels as we take you on a magical adventure through the heart of Europe. Our carefully curated Europe tour packages offer you the opportunity to explore the continent's rich history, diverse cultures, stunning landscapes, and iconic landmarks. Whether you're a history enthusiast, a foodie, or simply seeking a romantic getaway, Europe has something to offer everyone, and we're here to make your dream vacation a reality.",
                    style: GoogleFonts.poppins(fontSize: 16),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
