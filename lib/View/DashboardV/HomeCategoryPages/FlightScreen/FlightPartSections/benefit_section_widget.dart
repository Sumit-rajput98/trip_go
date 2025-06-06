import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BenefitSectionWidget extends StatelessWidget {
  const BenefitSectionWidget({super.key});


  @override
  Widget build(BuildContext context) {
    List imgList = [
      "https://images.pexels.com/photos/2178175/pexels-photo-2178175.jpeg?auto=compress&cs=tinysrgb&w=600",
      "https://images.pexels.com/photos/2082103/pexels-photo-2082103.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
      "https://images.pexels.com/photos/2161449/pexels-photo-2161449.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
      "https://images.pexels.com/photos/2161449/pexels-photo-2161449.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    ];
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 0),
          child: Container(
            height: size.height*0.2,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5)
            ),
            child: CarouselSlider(
              items: imgList.map(
                    (item) => SizedBox(
                  width: double.infinity,
                  child: Image.network(
                    item,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey[300],
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),
              ).toList(),
              options: CarouselOptions(
                viewportFraction: 1.0,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 4),
                height: size.height * 0.5,
                enableInfiniteScroll: true,
              ),
            ),
          ),
        ),
        SizedBox(height: 20,),
        // Title
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Color(0xff212529),
                fontWeight: FontWeight.w700
              ),
              children: [
                const TextSpan(text: 'Our ',),
                TextSpan(
                  text: 'Benefits',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red, // Highlight 'Benefits'
                  ),
                ),
                const TextSpan(text: ' & Key Advantages'),
              ],
            ),
          ),
        ),
        // Description
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'TripGo, a tour operator specializing in dream destinations, offers a variety of benefits for travelers.',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Color(0xff212529),
              fontWeight: FontWeight.w400
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Grid of Benefits
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 400, // Adjust height based on your card size
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1,
              physics: NeverScrollableScrollPhysics(), // Disable scroll inside
              children: [
                _buildBenefitCard(
                  icon: Icons.edit_calendar_outlined,
                  iconColor: Color(0xff98aa30),
                  title: 'Easy Booking',
                  description: 'Book Flights Easily and Grab Exciting Offers!',
                ),
                _buildBenefitCard(
                  icon: Icons.discount,
                  iconColor:Color(0xffe04f16),
                  title: 'Lowest Price',
                  description: 'Guaranteed Low Rates on Hotels, Holiday Packages, and Flights!',
                ),
                _buildBenefitCard(
                  icon: Icons.currency_rupee,
                  iconColor: Color(0xff6938ef),
                  title: 'Instant Refund',
                  description: 'Get Quick and Easy Refunds on All Your Travel Bookings!',
                ),
                _buildBenefitCard(
                  icon: Icons.phone_callback_outlined,
                  iconColor: Color(0xff0e9384),
                  title: '24/7 Support',
                  description: '24/7 Support for All Your Travel Queries - We are here to help!'
                ),
              ],
            ),
          ),
        ),
        Divider(
          thickness: 2,
        ),
      ],
    );
  }

  Widget _buildBenefitCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String description,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: iconColor,
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            description,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
