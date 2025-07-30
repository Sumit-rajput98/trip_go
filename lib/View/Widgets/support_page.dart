import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trip_go/View/Widgets/custom_app_bar.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomAppBar(title: "Support"),
      body: Stack(
        children: [
          // Background Image with blur
          Container(
            height: media.height,
            width: media.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage("https://tripgoonline.com/static/media/insurance-img.6a5b9aa4922bf177f0fc.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
            child:BackdropFilter(
  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
  child: Container(
    color: Colors.black.withOpacity(0.2), // ✅ Updated for better contrast
  ),
),
  ),

          // Main content
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Get in touch!",
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    )),
                const SizedBox(height: 5),
                Text(
                  "Don't hesitate to get in touch with us - we'll be happy to talk to you!",
                  style: GoogleFonts.poppins(fontSize: 13, color: Colors.black87),
                ),
                const SizedBox(height: 20),

                // Contact Cards
                _buildContactCard(
                  icon: Icons.call_outlined,
                  title: "CALL US 24*7",
                  detail: "+91 92112 52358",
                  color: Colors.red.shade100,
                ),
                const SizedBox(height: 12),
                _buildContactCard(
                  icon: Icons.mail_outline,
                  title: "MAKE A QUOTE",
                  detail: "support@tripgoonline.com",
                  color: Colors.orange.shade100,
                ),
                const SizedBox(height: 12),
                _buildContactCard(
                  icon: Icons.location_on_outlined,
                  title: "WORK STATION",
                  detail:
                      "1815, Tower 4, DLF Corporate Greens, Sector 74A, Gurugram - 122004",
                  color: Colors.green.shade100,
                ),

                const SizedBox(height: 30),

                // Enquiry Form
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.95),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Send an Enquiry",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          )),
                      const SizedBox(height: 15),
                      _buildTextField("Your Name"),
                      _buildTextField("Your Email"),
                      _buildTextField("Your Phone Number"),
                      _buildTextField("Subject"),
                      _buildTextField("Your Message", maxLines: 5),
                      const SizedBox(height: 15),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff1B499F),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {},
                          child: Text("Submit", style: GoogleFonts.poppins(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String detail,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xffFFFFA3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, size: 32, color: Colors.black87),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )),
                const SizedBox(height: 4),
                Text(detail,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.black87,
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTextField(String hint, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextField(
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.poppins(fontSize: 13),
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        ),
      ),
    );
  }
}
