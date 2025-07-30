import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trip_go/View/Widgets/custom_app_bar.dart';

class AboutTripGoPage extends StatelessWidget {
  const AboutTripGoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const CustomAppBar(title: "About TripGo"),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: About TripGo
            Text(
              "About TripGo Tour & Travels",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "Welcome to TripGo Tour & Travels, your premier B2C travel portal dedicated to transforming the way businesses navigate the world of travel. At TripGo Tour & Travels, we understand the unique needs of the travel industry and are committed to providing tailored solutions that empower businesses to thrive.",
              style: GoogleFonts.poppins(
                fontSize: 13,
                height: 1.6,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 24),

            // Section 2: Our Mission
            Text(
              "Our Mission",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "At TripGo Tour & Travels, our mission is to simplify and elevate the travel experience for our B2C partners. We strive to be the preferred travel portal by delivering cutting-edge technology, unparalleled service, and strategic partnerships that drive business success.\n\n"
              "Empowering Business Success: We are dedicated to empowering the success of our B2C partners by providing them with a dynamic platform that seamlessly integrates cutting-edge technology, strategic partnerships, and industry insights. Our mission is to be the driving force behind the growth and profitability of businesses in the travel sector.",
              style: GoogleFonts.poppins(
                fontSize: 13,
                height: 1.6,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 24),

            // Section 3: What Sets Us Apart with Image
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                'https://img.freepik.com/free-photo/couple-interacting-with-each-other-check-counter_107420-85045.jpg?t=st=1736426055~exp=1736429655~hmac=4d747669ea9116e5570ef2f2a8281d3d90a4b67a6bef10d0bacc5c77ced75684&w=900',
                width: media.width,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "What Sets Us Apart",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "TripGo Tour & Travels is exclusively designed for businesses in the travel industry. Whether you are a travel agency, tour operator, or corporate entity, our platform is crafted to meet your specific requirements, offering a comprehensive suite of tools and services.\n\n"
              "We leverage the latest technology to bring efficiency, transparency, and innovation to your fingertips. Our user-friendly portal is equipped with advanced features to streamline booking processes, manage reservations, and access real-time data, ensuring you stay ahead in a dynamic market.\n\n"
              "Your success is our priority. TripGo Tour & Travels is more than a platform; it’s a partnership. Our dedicated support team is committed to providing personalized assistance, ensuring that your business experiences seamless operations and growth.",
              style: GoogleFonts.poppins(
                fontSize: 13,
                height: 1.6,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
