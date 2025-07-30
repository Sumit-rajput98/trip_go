import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/VisaScreen/visa_enquirey_service.dart';
import 'package:url_launcher/url_launcher.dart';

class VisaScreen extends StatefulWidget {
  const VisaScreen({super.key});

  @override
  State<VisaScreen> createState() => _VisaScreenState();
}

class _VisaScreenState extends State<VisaScreen> {

   final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final subjectController = TextEditingController();
  final messageController = TextEditingController();

  @override
  void dispose(){
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    subjectController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
Widget build(BuildContext context) {
  final media = MediaQuery.of(context).size;

  return Scaffold(
    body: Stack(
      children: [
        // Blurred background image
        SizedBox(
          height: media.height,
          width: media.width,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Image.network(
              "https://tripgoonline.com/static/media/insurance-img.6a5b9aa4922bf177f0fc.jpeg",
              fit: BoxFit.cover,
            ),
          ),
        ),

        // Dark overlay (for contrast)
        Container(
          height: media.height,
          width: media.width,
          color: Colors.black.withOpacity(0.2),
        ),

        // Main content
        SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Get in touch!",
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "Don't hesitate to get in touch with us - we're happy to talk to you!",
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 20),

                _buildContactCard(
  icon: Icons.call_outlined,
  title: "CALL US 24*7",
  detail: "+91 92112 52358",
  color: Colors.red.shade100,
  onTap: () async {
    final uri = Uri.parse("tel:+919211252358");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  },
),
const SizedBox(height: 12),
_buildContactCard(
  icon: Icons.mail_outline,
  title: "MAKE A QUOTE",
  detail: "support@tripgoonline.com",
  color: Colors.orange.shade100,
  onTap: () async {
    final uri = Uri(
      scheme: 'mailto',
      path: 'support@tripgoonline.com',
      query: 'subject=Visa Enquiry',
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  },
),
const SizedBox(height: 12),
_buildContactCard(
  icon: Icons.location_on_outlined,
  title: "WORK STATION",
  detail: "1815, Tower 4, DLF Corporate Greens,\nSector 74A, Gurugram - 122004",
  color: Colors.green.shade100,
  onTap: () async {
    final query = Uri.encodeComponent("DLF Corporate Greens, Sector 74A, Gurugram");
    final uri = Uri.parse("https://www.google.com/maps/search/?api=1&query=$query");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  },
),


                const SizedBox(height: 30),

                // Enquiry form
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Send an Enquiry",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      _buildTextField("Your Name",controller: nameController),
                      _buildTextField("Your Email",controller: emailController),
                      _buildTextField("Your Phone Number",controller: phoneController),
                      _buildTextField("Subject",controller: subjectController),
                      _buildTextField("Your Message", maxLines: 5,controller: messageController),
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
                         onPressed: () async {
  await VisaEnquiryService().sendVisaEnquiryEmail(
    name: nameController.text,
    email: emailController.text,
    phone: phoneController.text,
    subject: subjectController.text,
    message: messageController.text,
  );

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text("Enquiry sent. We'll contact you shortly!")),
  );
},

                          child: Text(
                            "Submit",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}Widget _buildContactCard({
  required IconData icon,
  required String title,
  required String detail,
  required Color color,
  VoidCallback? onTap,
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(8),
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
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
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  detail,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}

  Widget _buildTextField(String hint, {int maxLines = 1,required TextEditingController controller}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextField(
        controller: controller,
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