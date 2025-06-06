import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MoreLinksSection extends StatelessWidget {
  const MoreLinksSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildHeading('More Links'),
          SizedBox(height: 10,),
          buildLinkRow([
            'About Us', 'Privacy Policy', 'Terms & Conditions',
            'Contact Us', 'Download our Mobile App', 'Offers'
          ]),
          const SizedBox(height: 30),
          buildHeading('Popular Domestic Flight Routes'),
          SizedBox(height: 10,),
          buildLinkRow([
            'Delhi Goa flights', 'Mumbai Delhi flights', 'Delhi Kolkata flights', 'Pune Delhi flights',
            'Bangalore Delhi flights', 'Mumbai Bangalore flights',
            'Chennai Delhi flights', 'Kolkata Delhi flights',
            'Delhi Mumbai flights', 'Delhi Bangalore flights', 'Mumbai Goa flights',
          ]),
          const SizedBox(height: 30),
          buildHeading('Popular International Flight Routes'),
          SizedBox(height: 10,),
          buildLinkRow([
            'Delhi Singapore flights', 'Delhi Bangkok flights',
            'Mumbai Dubai flights', 'Delhi Dubai flights',
            'Delhi London flights', 'Delhi Toronto flights',
            'Delhi New York flights', 'Bangalore Singapore flights',
            'Delhi Paris flights', 'Mumbai Paris flights', 'Delhi Hong Kong flights',
          ]),
          const SizedBox(height: 30),
          buildHeading('Popular Hotels'),
          SizedBox(height: 10,),
          buildLinkRow([
            'Goa hotels', 'Mumbai hotels', 'Bangalore hotels', 'Chennai hotels', 'Nainital hotels',
            'Jaipur hotels', 'Manali hotels', 'Shimla hotels', 'Pune hotels',
            'Hyderabad hotels', 'Mahabaleshwar hotels', 'Ooty hotels',
            'Kolkata hotels', 'Matheran hotels', 'Shirdi hotels',
            'Agra hotels', 'Mysore hotels', 'Munnar hotels', 'Delhi hotels', 'Kodaikanal hotels',
          ]),
          const SizedBox(height: 30),
          buildHeading('Popular Domestic Tour Package'),
          SizedBox(height: 10,),
          buildLinkRow([
            'Kashmir Holiday Packages tour packages',
            'Leh Ladakh Packages tour packages',
            'Goa Holidays tour packages',
            'Andaman Holidays tour packages',
            'Kerala Tour Packages tour packages',
            'Himachal packages tour packages',
          ]),
          const SizedBox(height: 30),
          buildHeading('Popular International Tour Package'),
          SizedBox(height: 10,),
          buildLinkRow([
            'Dubai tour packages tour packages',
            'Malaysia tour package tour packages',
            'Singapore tour package tour packages',
            'Thailand tour packages tour packages',
            'Bali packages tour packages',
            'Srilanka tour package tour packages',
            'Europe tour packages tour packages',
            'Mauritius packages tour packages',
            'Maldives packages tour packages',
          ]),
        ],
      ),
    );
  }

  Widget buildHeading(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        color: Colors.black87,
      ),
    );
  }

  Widget buildLinkRow(List<String> links) {
    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: links.map((link) {
        return Text(

          '$link |',
          style: GoogleFonts.poppins(
            fontSize: 13,
            color: Colors.black54,
            height: 1.6
          ),
        );
      }).toList(),
    );
  }
}
