import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trip_go/constants.dart';
import '../destination_details_page.dart';
import '../trending_destinations.dart';
import 'city_builder.dart';

class PopularIndianDestination extends StatelessWidget {
  const PopularIndianDestination({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> cities = [
      {
        'img': 'https://images.unsplash.com/photo-1561359313-0639aad49ca6',
        'title': 'Varanasi',
      },
      {
        'img': 'https://static2.tripoto.com/media/filter/nl/img/1706196/TripDocument/1619425826_cq5dam_web_1280_765.jpeg',
        'title': 'Kaimur Hills',
      },
      {
        'img': 'https://www.holidify.com/images/cmsuploads/compressed/shutterstock_402506581_20191024172033.jpg',
        'title': 'Gaya',
      },
      {
        'img': 'https://cdn.getyourguide.com/img/tour/2f6fe4e17edef2ae.jpeg/145.jpg',
        'title': 'Ayodhya',
      },
      {
        'img': 'https://www.buddhisttourism.online/assets/images/rajgir-banner4.webp',
        'title': 'Rajgiri',
      },
      {
        'img': 'https://www.holidify.com/images/cmsuploads/compressed/15267714_20200120114034.jpg',
        'title': 'Kerela',
      },
      {
        'img': 'https://travelsetu.com/apps/uploads/new_destinations_photos/destination/2023/12/13/b9e1b5bbf87f3ec75c09613f9378b564_1000x1000.jpg',
        'title': 'Spiti Valley',
      },
      {
        'img': 'https://punetours.com/wp-content/uploads/2017/10/kashmir-tour-honeymoon-package-booking.jpg',
        'title': 'Kashmir',
      },
    ];

    return Column(
      children: [
        Text(
          "DESTINATION",
          style: GoogleFonts.poppins(
            color: constants.themeColor2,
            letterSpacing: 1.5,
          ),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Popular ',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: Color(0xffF73130),
                  fontSize: 20,
                ),
              ),
              TextSpan(
                text: 'Indian Destination',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        ...cities.map((city) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DestinationDetailsPage(
                    name: city['title']!,
                    image: city['img']!,
                  ),
                ),
              );
            },
            child: CityBuilder(
              img: city['img']!,
              title: city['title']!,
            ),
          ),
        )),
      ],
    );
  }
}
